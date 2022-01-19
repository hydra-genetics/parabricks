__author__ = "Martin R"
__copyright__ = "Copyright 2021, Martin R"
__email__ = "martin.rippin@scilifelab.uu.se"
__license__ = "GPL-3"

import pandas as pd
from snakemake.utils import validate
from snakemake.utils import min_version

from hydra_genetics.utils.resources import load_resources
from hydra_genetics.utils.samples import *
from hydra_genetics.utils.units import *

min_version("6.8.0")

### Set and validate config file


configfile: "config.yaml"


validate(config, schema="../schemas/config.schema.yaml")
config = load_resources(config, config["resources"])
validate(config, schema="../schemas/resources.schema.yaml")


### Read and validate samples file

samples = pd.read_table(config["samples"], dtype=str).set_index("sample", drop=False)
validate(samples, schema="../schemas/samples.schema.yaml")

### Read and validate units file

units = pandas.read_table(config["units"], dtype=str).set_index(["sample", "type", "run", "lane"], drop=False).sort_index()
validate(units, schema="../schemas/units.schema.yaml")

### Set wildcard constraints


wildcard_constraints:
    sample="|".join(samples.index),
    unit="N|T|R",


def get_num_gpus(rule, wildcards):
    gres = config.get(rule, {"gres": "gpu:1"}).get("gres", "--gres gpu:1")[len("--gres ") :]
    gres_dict = dict()
    for item in gres.split(","):
        items = item.split(":")
        gres_dict[items[0]] = items[1]
    return gres_dict["gpu"]


def compile_output_list(wildcards):
    return [
        "parabricks/%s/%s.vcf" % (tool, sample) for tool in ["deepvariant", "mutectcaller"] for sample in get_samples(samples)
    ]
