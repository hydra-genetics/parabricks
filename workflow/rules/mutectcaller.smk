__author__ = "Martin R"
__copyright__ = "Copyright 2021, Martin R"
__email__ = "martin.rippin@scilifelab.uu.se"
__license__ = "GPL-3"


rule mutectcaller_tn:
    input:
        bam_t="parabricks/fq2bam/{sample}_T.bam",
        bai_t="parabricks/fq2bam/{sample}_T.bam.bai",
        recal_t="parabricks/fq2bam/{sample}_T.txt",
        bam_n="parabricks/fq2bam/{sample}_N.bam",
        bai_n="parabricks/fq2bam/{sample}_N.bam.bai",
        recal_n="parabricks/fq2bam/{sample}_N.txt",
        fasta=config["reference"]["fasta"],
    output:
        vcf="parabricks/mutectcaller/{sample}.vcf",
    params:
        num_gpus=lambda wildcards: get_num_gpus("mutectcaller", wildcards),
    log:
        "parabricks/mutectcaller/{sample}.vcf.log",
    benchmark:
        repeat(
            "parabricks/mutectcaller/{sample}.vcf.benchmark.tsv",
            config.get("mutectcaller", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("mutectcaller", {}).get("threads", config["default_resources"]["threads"])
    resources:
        gres=config.get("mutectcaller", {}).get("gres", ""),
        mem_mb=config.get("mutectcaller", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("mutectcaller", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("mutectcaller", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("mutectcaller", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("mutectcaller", {}).get("time", config["default_resources"]["time"]),
    conda:
        "../envs/mutectcaller.yaml"
    message:
        "{rule}: Call SNP and small indels for {wildcards.sample} tumor/normal with parabricks"
    shell:
        "pbrun mutectcaller "
        "--ref {input.fasta} "
        "--in-tumor-bam {input.bam_t} "
        "--tumor-name {wildcards.sample}_T "
        "--in-tumor-recal-file {input.recal_t} "
        "--in-normal-bam {input.bam_n} "
        "--normal-name {wildcards.sample}_N "
        "--in-normal-recal-file {input.recal_n} "
        "--num-gpus {params.num_gpus} "
        "--out-vcf {output.vcf} "
        "--tmp-dir parabricks/mutectcaller/{wildcards.sample}_tn &> {log}"


rule mutectcaller_t:
    input:
        bam_t="parabricks/fq2bam/{sample}_T.bam",
        bai_t="parabricks/fq2bam/{sample}_T.bam.bai",
        recal_t="parabricks/fq2bam/{sample}_T.txt",
        fasta=config["reference"]["fasta"],
    output:
        vcf="parabricks/mutectcaller/{sample}_T.vcf",
    params:
        num_gpus=lambda wildcards: get_num_gpus("mutectcaller", wildcards),
    log:
        "parabricks/mutectcaller/{sample}_T.vcf.log",
    benchmark:
        repeat(
            "parabricks/mutectcaller/{sample}_T.vcf.benchmark.tsv",
            config.get("mutectcaller", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("mutectcaller", {}).get("threads", config["default_resources"]["threads"])
    resources:
        gres=config.get("mutectcaller", {}).get("gres", ""),
        mem_mb=config.get("mutectcaller", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("mutectcaller", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("mutectcaller", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("mutectcaller", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("mutectcaller", {}).get("time", config["default_resources"]["time"]),
    conda:
        "../envs/mutectcaller.yaml"
    message:
        "{rule}: Call SNP and small indels for {wildcards.sample} tumor with parabricks"
    shell:
        "pbrun mutectcaller "
        "--ref {input.fasta} "
        "--in-tumor-bam {input.bam_t} "
        "--tumor-name {wildcards.sample}_T "
        "--in-tumor-recal-file {input.recal_t} "
        "--num-gpus {params.num_gpus} "
        "--out-vcf {output.vcf} "
        "--tmp-dir parabricks/mutectcaller/{wildcards.sample}_t &> {log}"
