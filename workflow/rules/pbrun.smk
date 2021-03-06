__author__ = "Martin R"
__copyright__ = "Copyright 2022, Martin R"
__email__ = "martin.rippin@scilifelab.uu.se"
__license__ = "GPL-3"


rule pbrun_deepvariant:
    input:
        bam="parabricks/pbrun_fq2bam/{sample}_N.bam",
        bai="parabricks/pbrun_fq2bam/{sample}_N.bam.bai",
        fasta=config["reference"]["fasta"],
    output:
        vcf=temp("parabricks/pbrun_deepvariant/{sample}.vcf"),
    params:
        extra=config.get("pbrun_deepvariant", {}).get("extra", ""),
        num_gpus=lambda wildcards: get_num_gpus("pbrun_deepvariant", wildcards),
    log:
        "parabricks/pbrun_deepvariant/{sample}.vcf.log",
    benchmark:
        repeat(
            "parabricks/pbrun_deepvariant/{sample}.vcf.benchmark.tsv",
            config.get("pbrun_deepvariant", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("pbrun_deepvariant", {}).get("threads", config["default_resources"]["threads"])
    resources:
        gres=config.get("pbrun_deepvariant", {}).get("gres", ""),
        mem_mb=config.get("pbrun_deepvariant", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("pbrun_deepvariant", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("pbrun_deepvariant", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("pbrun_deepvariant", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("pbrun_deepvariant", {}).get("time", config["default_resources"]["time"]),
    conda:
        "../envs/pbrun.yaml"
    message:
        "{rule}: call snp and small indels for {wildcards.sample} with parabricks"
    shell:
        "pbrun deepvariant "
        "--ref {input.fasta} "
        "--in-bam {input.bam} "
        "--num-gpus {params.num_gpus} "
        "--out-variants {output.vcf} "
        "{params.extra} "
        "--tmp-dir parabricks/pbrun_deepvariant/{wildcards.sample} &> {log}"


rule pbrun_fq2bam:
    input:
        fastq=lambda wildcards: get_input_fastq(units, wildcards),
        fasta=config["reference"]["fasta"],
        sites=config["reference"]["sites"],
    output:
        bam=temp("parabricks/pbrun_fq2bam/{sample}_{type}.bam"),
        bai=temp("parabricks/pbrun_fq2bam/{sample}_{type}.bam.bai"),
        metrics=temp("parabricks/pbrun_fq2bam/{sample}_{type}.metrics"),
        recal=temp("parabricks/pbrun_fq2bam/{sample}_{type}.txt"),
    params:
        extra=config.get("pbrun_fq2bam", {}).get("extra", ""),
        in_fq=get_in_fq,
        num_gpus=lambda wildcards: get_num_gpus("pbrun_fq2bam", wildcards),
    log:
        "parabricks/pbrun_fq2bam/{sample}_{type}.bam.log",
    benchmark:
        repeat(
            "parabricks/pbrun_fq2bam/{sample}_{type}.bam.benchmark.tsv",
            config.get("pbrun_fq2bam", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("pbrun_fq2bam", {}).get("threads", config["default_resources"]["threads"])
    resources:
        gres=config.get("pbrun_fq2bam", {}).get("gres", ""),
        mem_mb=config.get("pbrun_fq2bam", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("pbrun_fq2bam", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("pbrun_fq2bam", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("pbrun_fq2bam", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("pbrun_fq2bam", {}).get("time", config["default_resources"]["time"]),
    conda:
        "../envs/pbrun.yaml"
    message:
        "{rule}: align and mark duplicates for {input.fastq} with parabricks"
    shell:
        "pbrun fq2bam "
        "--ref {input.fasta} "
        "--in-fq {params.in_fq} "
        "--knownSites {input.sites} "
        "--num-gpus {params.num_gpus} "
        "--out-bam {output.bam} "
        "--out-duplicate-metrics {output.metrics} "
        "--out-recal-file {output.recal} "
        "{params.extra} "
        "--tmp-dir parabricks/pbrun_fq2bam/{wildcards.sample}_{wildcards.type} &> {log}"


rule pbrun_mutectcaller_t:
    input:
        bam_t="parabricks/pbrun_fq2bam/{sample}_T.bam",
        bai_t="parabricks/pbrun_fq2bam/{sample}_T.bam.bai",
        recal_t="parabricks/pbrun_fq2bam/{sample}_T.txt",
        fasta=config["reference"]["fasta"],
    output:
        vcf=temp("parabricks/pbrun_mutectcaller_t/{sample}_T.vcf"),
    params:
        extra=config.get("pbrun_mutectcaller_t", {}).get("extra", ""),
        num_gpus=lambda wildcards: get_num_gpus("pbrun_mutectcaller_t", wildcards),
    log:
        "parabricks/pbrun_mutectcaller_t/{sample}_T.vcf.log",
    benchmark:
        repeat(
            "parabricks/pbrun_mutectcaller_t/{sample}_T.vcf.benchmark.tsv",
            config.get("pbrun_mutectcaller_t", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("pbrun_mutectcaller_t", {}).get("threads", config["default_resources"]["threads"])
    resources:
        gres=config.get("pbrun_mutectcaller_t", {}).get("gres", ""),
        mem_mb=config.get("pbrun_mutectcaller_t", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("pbrun_mutectcaller_t", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("pbrun_mutectcaller_t", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("pbrun_mutectcaller_t", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("pbrun_mutectcaller_t", {}).get("time", config["default_resources"]["time"]),
    conda:
        "../envs/pbrun.yaml"
    message:
        "{rule}: call snp and small indels for {wildcards.sample} tumor with parabricks"
    shell:
        "pbrun mutectcaller "
        "--ref {input.fasta} "
        "--in-tumor-bam {input.bam_t} "
        "--tumor-name {wildcards.sample}_T "
        "--in-tumor-recal-file {input.recal_t} "
        "--num-gpus {params.num_gpus} "
        "--out-vcf {output.vcf} "
        "{params.extra} "
        "--tmp-dir parabricks/pbrun_mutectcaller_t/{wildcards.sample} &> {log}"


rule pbrun_mutectcaller_tn:
    input:
        bam_t="parabricks/pbrun_fq2bam/{sample}_T.bam",
        bai_t="parabricks/pbrun_fq2bam/{sample}_T.bam.bai",
        recal_t="parabricks/pbrun_fq2bam/{sample}_T.txt",
        bam_n="parabricks/pbrun_fq2bam/{sample}_N.bam",
        bai_n="parabricks/pbrun_fq2bam/{sample}_N.bam.bai",
        recal_n="parabricks/pbrun_fq2bam/{sample}_N.txt",
        fasta=config["reference"]["fasta"],
    output:
        vcf=temp("parabricks/pbrun_mutectcaller_tn/{sample}.vcf"),
    params:
        extra=config.get("pbrun_mutectcaller_tn", {}).get("extra", ""),
        num_gpus=lambda wildcards: get_num_gpus("pbrun_mutectcaller_tn", wildcards),
    log:
        "parabricks/pbrun_mutectcaller_tn/{sample}.vcf.log",
    benchmark:
        repeat(
            "parabricks/pbrun_mutectcaller_tn/{sample}.vcf.benchmark.tsv",
            config.get("pbrun_mutectcaller_tn", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("pbrun_mutectcaller_tn", {}).get("threads", config["default_resources"]["threads"])
    resources:
        gres=config.get("pbrun_mutectcaller_tn", {}).get("gres", ""),
        mem_mb=config.get("pbrun_mutectcaller_tn", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("pbrun_mutectcaller_tn", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("pbrun_mutectcaller_tn", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("pbrun_mutectcaller_tn", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("pbrun_mutectcaller_tn", {}).get("time", config["default_resources"]["time"]),
    conda:
        "../envs/pbrun.yaml"
    message:
        "{rule}: call snp and small indels for {wildcards.sample} tumor/normal with parabricks"
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
        "{params.extra} "
        "--tmp-dir parabricks/pbrun_mutectcaller_tn/{wildcards.sample} &> {log}"


rule pbrun_rna_fq2bam:
    input:
        fastq=lambda wildcards: get_input_fastq(units, wildcards),
        genome_dir=config["reference"]["genome_dir"],
    output:
        bam=temp("parabricks/pbrun_rna_fq2bam/{sample}_{type}.bam"),
    params:
        extra=config.get("pbrun_rna_fq2bam", {}).get("extra", ""),
        in_fq=get_in_fq,
        num_gpus=lambda wildcards: get_num_gpus("pbrun_rna_fq2bam", wildcards),
    log:
        "parabricks/pbrun_rna_fq2bam/{sample}_{type}.bam.log",
    benchmark:
        repeat(
            "parabricks/pbrun_rna_fq2bam/{sample}_{type}.bam.benchmark.tsv",
            config.get("pbrun_rna_fq2bam", {}).get("benchmark_repeats", 1),
        )
    threads: config.get("pbrun_rna_fq2bam", {}).get("threads", config["default_resources"]["threads"])
    resources:
        gres=config.get("pbrun_rna_fq2bam", {}).get("gres", ""),
        mem_mb=config.get("pbrun_rna_fq2bam", {}).get("mem_mb", config["default_resources"]["mem_mb"]),
        mem_per_cpu=config.get("pbrun_rna_fq2bam", {}).get("mem_per_cpu", config["default_resources"]["mem_per_cpu"]),
        partition=config.get("pbrun_rna_fq2bam", {}).get("partition", config["default_resources"]["partition"]),
        threads=config.get("pbrun_rna_fq2bam", {}).get("threads", config["default_resources"]["threads"]),
        time=config.get("pbrun_rna_fq2bam", {}).get("time", config["default_resources"]["time"]),
    conda:
        "../envs/pbrun.yaml"
    message:
        "{rule}: splice-aware alignment with parabricks for {input.fastq}"
    shell:
        "pbrun rna_fq2bam "
        "{params.extra} "
        "--genome-lib-dir {input.genome_dir} "
        "--in-fq {params.in_fq} "
        "--num-gpus {params.num_gpus} "
        "--output-dir parabricks/pbrun_rna_fq2bam/ "
        "--out-bam {output.bam} "
        "--out-prefix {wildcards.sample}_{wildcards.type} "
        "--tmp-dir parabricks/pbrun_rna_fq2bam/{wildcards.sample}_{wildcards.type} "
        "{params.extra} "
        "--logfile {log}"
