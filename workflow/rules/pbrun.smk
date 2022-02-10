__author__ = "Martin R"
__copyright__ = "Copyright 2022, Martin R"
__email__ = "martin.rippin@scilifelab.uu.se"
__license__ = "GPL-3"


rule rna_fq2bam:
    input:
        fastq1="prealignment/merged/{sample}_{type}_fastq1.fastq.gz",
        fastq2="prealignment/merged/{sample}_{type}_fastq2.fastq.gz",
        genome_dir=config["reference"]["genome_dir"],
    output:
        bam="parabricks/rna_fq2bam/{sample}_{type}.bam",
    params:
        extra=config.get("rna_fq2bam", {}).get("extra", ""),
        num_gpus=lambda wildcards: get_num_gpus("rna_fq2bam", wildcards),
        platform=lambda wildcards: get_unit_platforms(units, wildcards),
    log:
        "parabricks/rna_fq2bam/{sample}_{type}.bam.log",
    benchmark:
        repeat(
            "parabricks/rna_fq2bam/{sample}_{type}.bam.benchmark.tsv",
            config.get("rna_fq2bam", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("rna_fq2bam", {}).get("threads", config["default_resources"]["threads"])
    resources:
        gres=config.get("rna_fq2bam", {}).get("gres", ""),
        mem_mb=config.get("rna_fq2bam", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("rna_fq2bam", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("rna_fq2bam", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("rna_fq2bam", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("rna_fq2bam", {}).get("time", config["default_resources"]["time"]),
    conda:
        "../envs/pbrun.yaml"
    message:
        "{rule}: splice-aware alignment with parabricks for prealignment/merged/{wildcards.sample}_{wildcards.type}_fastq1/2.fastq.gz"
    shell:
        "pbrun rna_fq2bam "
        "{params.extra} "
        "--genome-lib-dir {input.genome_dir} "
        "--in-fq {input.fastq1} {input.fastq2} "
        "--read-group-sm {wildcards.sample}_{wildcards.type} "
        "--read-group-id-prefix {wildcards.sample}_{wildcards.type} "
        "--read-group-pl {params.platform} "
        "--num-gpus {params.num_gpus} "
        "--output-dir parabricks/rna_fq2bam/ "
        "--out-bam {output.bam} "
        "--out-prefix {wildcards.sample}_{wildcards.type} "
        "--tmp-dir parabricks/rna_fq2bam/{wildcards.sample}_{wildcards.type} "
        "--logfile {log}"
