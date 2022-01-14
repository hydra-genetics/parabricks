__author__ = "Martin R"
__copyright__ = "Copyright 2021, Martin R"
__email__ = "martin.rippin@scilifelab.uu.se"
__license__ = "GPL-3"


rule deepvariant:
    input:
        bam="parabricks/fq2bam/{sample}_N.bam",
        fasta=config["reference"]["fasta"],
    output:
        vcf="parabricks/deepvariant/{sample}.vcf",
    params:
        num_gpus=get_num_gpus,
    log:
        "parabricks/deepvariant/{sample}.vcf.log",
    benchmark:
        repeat(
            "parabricks/deepvariant/{sample}.vcf.benchmark.tsv",
            config.get("deepvariant", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("deepvariant", {}).get("threads", config["default_resources"]["threads"])
    resources:
        gres=config.get("deepvariant", {}).get("gres", ""),
        mem_mb=config.get("deepvariant", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("deepvariant", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("deepvariant", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("deepvariant", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("deepvariant", {}).get("time", config["default_resources"]["time"]),
    conda:
        "../envs/deepvariant.yaml"
    message:
        "{rule}: Call SNP and small indels for {wildcards.sample} with parabricks"
    shell:
        "pbrun deepvariant "
        "--ref {input.fasta} "
        "--in-bam {input.bam} "
        "--num-gpus {params.num_gpus} "
        "--out-variants {output.vcf} "
        "--tmp-dir parabricks/deepvariant/{wildcards.sample} &> {log}"
