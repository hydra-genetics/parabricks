__author__ = "Martin R"
__copyright__ = "Copyright 2021, Martin R"
__email__ = "martin.rippin@scilifelab.uu.se"
__license__ = "GPL-3"


rule fq2bam:
    input:
        fastq=lambda wildcards: get_fq2bam_input(units, wildcards),
        fasta=config["reference"]["fasta"],
        sites=config["reference"]["sites"],
    output:
        bam=temp("parabricks/fq2bam/{sample}_{type}.bam"),
        bai=temp("parabricks/fq2bam/{sample}_{type}.bam.bai"),
        metrics="parabricks/fq2bam/{sample}_{type}.metrics",
        recal="parabricks/fq2bam/{sample}_{type}.txt",
    params:
        in_fq=get_in_fq,
        num_gpus=lambda wildcards: get_num_gpus("fq2bam", wildcards),
    log:
        "parabricks/fq2bam/{sample}_{type}.bam.log",
    benchmark:
        repeat(
            "parabricks/fq2bam/{sample}_{type}.bam.benchmark.tsv",
            config.get("fq2bam", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("fq2bam", {}).get("threads", config["default_resources"]["threads"])
    resources:
        gres=config.get("fq2bam", {}).get("gres", ""),
        mem_mb=config.get("fq2bam", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("fq2bam", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("fq2bam", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("fq2bam", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("fq2bam", {}).get("time", config["default_resources"]["time"]),
    conda:
        "../envs/pbrun.yaml"
    message:
        "{rule}: Align and mark duplicates for {wildcards.sample}_{wildcards.type} with parabricks"
    shell:
        "pbrun fq2bam "
        "--ref {input.fasta} "
        "--in-fq {params.in_fq} "
        "--knownSites {input.sites} "
        "--num-gpus {params.num_gpus} "
        "--out-bam {output.bam} "
        "--out-duplicate-metrics {output.metrics} "
        "--out-recal-file {output.recal} "
        "--tmp-dir parabricks/fq2bam/{wildcards.sample}_{wildcards.type} &> {log}"
