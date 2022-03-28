__author__ = "Martin R"
__copyright__ = "Copyright 2021, Martin R"
__email__ = "martin.rippin@scilifelab.uu.se"
__license__ = "GPL-3"

import pandas as pd

from hydra_genetics.utils.resources import load_resources
from hydra_genetics.utils.samples import *
from hydra_genetics.utils.units import *
from snakemake.utils import min_version
from snakemake.utils import validate

min_version("6.10.0")

### Set and validate config file


configfile: "config.yaml"


validate(config, schema="../schemas/config.schema.yaml")
config = load_resources(config, config["resources"])
validate(config, schema="../schemas/resources.schema.yaml")


### Read and validate samples file

samples = pd.read_table(config["samples"], dtype=str).set_index("sample", drop=False)
validate(samples, schema="../schemas/samples.schema.yaml")

### Read and validate units file

units = pandas.read_table(config["units"], dtype=str).set_index(["sample", "type", "flowcell", "lane"], drop=False).sort_index()
validate(units, schema="../schemas/units.schema.yaml")

### Set wildcard constraints


wildcard_constraints:
    sample="|".join(samples.index),
    unit="N|T|R",


def get_input_fastq(units, wildcards):
    return expand(
        "prealignment/fastp_pe/{{sample}}_{flowcell_lane}_{{type}}_{read}.fastq.gz",
        flowcell_lane=["{}_{}".format(unit.flowcell, unit.lane) for unit in get_units(units, wildcards, wildcards.type)],
        read=["fastq1", "fastq2"],
    )


def get_in_fq(wildcards):
    input_list = []
    for unit in get_units(units, wildcards, wildcards.type):
        prefix = "prealignment/fastp_pe/{}_{}_{}_{}".format(unit.sample, unit.flowcell, unit.lane, unit.type)
        input_unit = "{}_fastq1.fastq.gz {}_fastq2.fastq.gz {}".format(
            prefix,
            prefix,
            "'@RG\\tID:{}\\tSM:{}\\tPL:{}\\tPU:{}\\tLB:{}'".format(
                "{}_{}.{}".format(unit.type, unit.sample, unit.lane),
                "{}_{}".format(unit.sample, unit.type),
                unit.platform,
                "{}.{}.{}".format(unit.flowcell, unit.lane, unit.barcode),
                "{}_{}".format(unit.sample, unit.type),
            ),
        )
        input_list.append(input_unit)
    return " --in-fq ".join(input_list)


def get_num_gpus(rule, wildcards):
    gres = config.get(rule, {"gres": "--gres=gpu:1"}).get("gres", "--gres=gpu:1")[len("--gres=") :]
    gres_dict = dict()
    for item in gres.split(","):
        items = item.split(":")
        gres_dict[items[0]] = items[1]
    return gres_dict["gpu"]


def compile_output_list(wildcards):
    files = {
        "pbrun_deepvariant": [
            ".vcf",
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
