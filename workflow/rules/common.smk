__author__ = "Martin R"
__copyright__ = "Copyright 2021, Martin R"
__email__ = "martin.rippin@scilifelab.uu.se"
__license__ = "GPL-3"

import os
import re

import pandas as pd

from hydra_genetics.utils.resources import load_resources
from hydra_genetics.utils.samples import *
from hydra_genetics.utils.units import *
from snakemake.exceptions import WorkflowError
from snakemake.utils import min_version
from snakemake.utils import validate

min_version("9.0.0")

### Set and validate config file


configfile: "config.yaml"


validate(config, schema="../schemas/config.schema.yaml")
config = load_resources(config, config["resources"])
validate(config, schema="../schemas/resources.schema.yaml")


### Read and validate samples file

samples = pd.read_table(config["samples"], dtype=str).set_index("sample", drop=False)
validate(samples, schema="../schemas/samples.schema.yaml")

### Read and validate units file

units = (
    pd.read_table(config["units"], dtype=str)
    .set_index(["sample", "type", "flowcell", "lane", "barcode"], drop=False)
    .sort_index()
)
validate(units, schema="../schemas/units.schema.yaml")

### Set wildcard constraints


wildcard_constraints:
    sample="|".join(re.escape(s) for s in samples.index),
    unit="N|T|R",


# Sentinel separating "no default given, so this entry is required" from a default of
# None, [] or "", each of which is a value a caller may legitimately want back.
_REQUIRED = object()


def get_config_value(*keys, default=_REQUIRED):
    """
    Fetch a value from the config, failing with a message that names the missing entry.

    Defaulting to "" is not usable here: an empty string reaches Snakemake either as
    a rule input, where it aborts with a MissingInputException that lists no file, or
    as a params value, where it silently produces a malformed shell command. Call this
    from an input/params function so the check stays lazy -- a workflow that never uses
    the rule does not have to configure it.

    Pass default=[] for an input file that the rule can run without. Snakemake reads an
    empty list as "no file", which is what "" was never able to express. Without a
    default the entry is required, and a missing or blank one raises.
    """
    value = config
    for i, key in enumerate(keys):
        if not isinstance(value, dict) or key not in value:
            if default is not _REQUIRED:
                return default
            missing = ":".join(keys[: i + 1])
            raise WorkflowError(f"parabricks: missing config entry '{missing}', required by the rule being run")
        value = value[key]

    if not isinstance(value, str) or not value.strip():
        if default is not _REQUIRED:
            return default
        name = ":".join(keys)
        raise WorkflowError(f"parabricks: config entry '{name}' must be a non-empty string, got {repr(value)}")

    return value


def get_input_fastq(units, wildcards):
    return expand(
        "prealignment/fastp_pe/{{sample}}_{{type}}_{flowcell_lane_barcode}_{read}.fastq.gz",
        flowcell_lane_barcode=[
            "{}_{}_{}".format(unit.flowcell, unit.lane, unit.barcode) for unit in get_units(units, wildcards, wildcards.type)
        ],
        read=["fastq1", "fastq2"],
    )


def get_in_fq(wildcards):
    input_list = []
    for unit in get_units(units, wildcards, wildcards.type):
        prefix = "prealignment/fastp_pe/{}_{}_{}_{}_{}".format(unit.sample, unit.type, unit.flowcell, unit.lane, unit.barcode)
        input_unit = "{}_fastq1.fastq.gz {}_fastq2.fastq.gz {}".format(
            prefix,
            prefix,
            "'@RG\\tID:{}\\tSM:{}\\tPL:{}\\tPU:{}\\tLB:{}'".format(
                "{}_{}.{}.{}".format(unit.sample, unit.type, unit.lane, unit.barcode),
                "{}_{}".format(unit.sample, unit.type),
                unit.platform,
                "{}.{}.{}".format(unit.flowcell, unit.lane, unit.barcode),
                "{}_{}".format(unit.sample, unit.type),
            ),
        )
        input_list.append(input_unit)
    return " --in-fq ".join(input_list)


def get_num_gpus(rule, wildcards):
    gres = config.get(rule, {"gres": "--gres=gres:gpu:1"}).get("gres", "--gres=gres:gpu:1")[len("--gres=") :]
    gres_list = gres.split(':')
    num_gpus = gres_list[-1]

    return num_gpus


def get_cuda_devices(wildcards):
    if os.getenv("CUDA_VISIBLE_DEVICES") is not None:
        cuda_devices = "CUDA_VISIBLE_DEVICES={}".format(os.getenv("CUDA_VISIBLE_DEVICES"))
    else:
        cuda_devices = ""
    return cuda_devices


def compile_output_list(wildcards):
    files = {
        "pbrun_deepvariant": [
            "_N.vcf",
        ],
        "pbrun_fq2bam": [
            "_N.bam",
            "_T.bam",
        ],
        "pbrun_mutectcaller_t": ["_T.vcf"],
        "pbrun_mutectcaller_tn": [".vcf"],
        "pbrun_rna_fq2bam": [
            "_R.bam",
        ],
    }
    return [
        "parabricks/%s/%s%s" % (prefix, sample, suffix)
        for prefix in files.keys()
        for sample in get_samples(samples)
        for suffix in files[prefix]
    ]
