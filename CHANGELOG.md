# Changelog

## 0.1.0 (2022-03-21)


### Features

* Add bai files as input and output ([23fc89d](https://www.github.com/hydra-genetics/parabricks/commit/23fc89d351fdc7e4361c0b8546c9fd2f098fec35))
* Add deepvariant as a caller ([2fab948](https://www.github.com/hydra-genetics/parabricks/commit/2fab948cadb05ad9ee84f45fd17dc252ac3f4804))
* Add fq2bam rule and integrate in workflow ([162d558](https://www.github.com/hydra-genetics/parabricks/commit/162d5580a5c30cad0eb401ffe1bb49d79e25d598))
* Add get_num_gpus function to common.smk ([0e1e408](https://www.github.com/hydra-genetics/parabricks/commit/0e1e4081af41a5cd350bda2f6786703855aa0338))
* Add get_platform function from latest hydra-genetics version ([37f9cdd](https://www.github.com/hydra-genetics/parabricks/commit/37f9cdd32e2fb44fbd031fddc007bdbf379ffcce))
* Add mutectcaller rule ([65555af](https://www.github.com/hydra-genetics/parabricks/commit/65555af4761fefec1808f087fd4efc449ea3f572))
* Add mutectcaller_t rule ([94ce820](https://www.github.com/hydra-genetics/parabricks/commit/94ce820f5d3ae20b9a99574218ac430d4693a364))
* Add rna_fq2bam ([2294087](https://www.github.com/hydra-genetics/parabricks/commit/2294087d0a20c8ffcc21aa24b7d6f17bbe51731c))
* Add sites file to fq2bam and collect recal output file ([7ec03e4](https://www.github.com/hydra-genetics/parabricks/commit/7ec03e474b5eaa349944c5cf0885e6b6fc6be340))
* Change run to flowcell and add all columns to tsvs ([bdc550f](https://www.github.com/hydra-genetics/parabricks/commit/bdc550fba28fbfd19b48d6c54f378cb00b621d35))
* Have unique RG per fastq file pair ([d64c337](https://www.github.com/hydra-genetics/parabricks/commit/d64c3378e11d0e84b357541f9e572029b02a7e05))
* Initiate snakemake module structure ([ac0571d](https://www.github.com/hydra-genetics/parabricks/commit/ac0571dce02d491cb574e4ea61637ed82cbb49a6))
* Remove default_resources from parabricks rules ([12e12e9](https://www.github.com/hydra-genetics/parabricks/commit/12e12e90ec75b5933f5f01b8fb96d9c4c37c391e))
* Remove dummy rule and vim syntaxing ([73f38b3](https://www.github.com/hydra-genetics/parabricks/commit/73f38b3fcc56dcf7b6af98c5c5edd26433375f81))
* Remove integration1 test as parabricks is not available ([0165024](https://www.github.com/hydra-genetics/parabricks/commit/016502445cfdef4e6648f334adcaf7f836a9a72a))
* Remove unused scripts ([81c93e9](https://www.github.com/hydra-genetics/parabricks/commit/81c93e9d7c3ac179a1640bfb2353c5a7841d3c27))
* Rename rules and move files to match standard ([83d8ded](https://www.github.com/hydra-genetics/parabricks/commit/83d8ded08b4d77ca3c38e2829f0892f8e2385cb9))
* temp output files ([05ded14](https://www.github.com/hydra-genetics/parabricks/commit/05ded14946f9592c09e558be09a0e4e9f2f6bb1b))
* Use RG tag and merging in pbrun_rna_fq2bam ([7f4ab7e](https://www.github.com/hydra-genetics/parabricks/commit/7f4ab7e0206d88c6f297cfb171f9b6fb844607e3))


### Bug Fixes

* Add extra params to rna_fq2bam ([846f74e](https://www.github.com/hydra-genetics/parabricks/commit/846f74edee61cffabb180b12b14f1cfa03300cbf))
* Add LB tag to RG header ([76cb238](https://www.github.com/hydra-genetics/parabricks/commit/76cb238313d4277a109a71f4e9d988ef7f4e6e1c))
* Add type to SM tag in @RG ([94227fc](https://www.github.com/hydra-genetics/parabricks/commit/94227fc4bd529b54c21c5e45127ef54d3c3a507e))
* Add type wildcard to PU and ID in @RG ([4345820](https://www.github.com/hydra-genetics/parabricks/commit/4345820a4285188ac0e79ccc269898ce4c5ef9c8))
* Another gres change ([990af7b](https://www.github.com/hydra-genetics/parabricks/commit/990af7b222c40bc4eef0b563556bee67e6ccc5cf))
* change run column name to flowcell in units. ([dfd11a6](https://www.github.com/hydra-genetics/parabricks/commit/dfd11a67d86652c5ca1eb987fe28f78280a95f58))
* Change version indication to >= ([70a18af](https://www.github.com/hydra-genetics/parabricks/commit/70a18af5c801af6d46d6b568ce19988049f8e145))
* Make get_gpu_num work for older python versions ([d7a83be](https://www.github.com/hydra-genetics/parabricks/commit/d7a83be469ea9625de57dbbba4b72bc95e4100b3))


### Documentation

* Remove small dataset badge from README ([cd10c4b](https://www.github.com/hydra-genetics/parabricks/commit/cd10c4bc7054527053d8255df3a2a5fc73fd5fbc))
* some small corrections ([17a531f](https://www.github.com/hydra-genetics/parabricks/commit/17a531f25b92f490ecc8402b807f11ef4366a345))
* Update README ([0155b6d](https://www.github.com/hydra-genetics/parabricks/commit/0155b6d754835be0978bf89e395c740db895642a))
