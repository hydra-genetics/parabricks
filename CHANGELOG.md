# Changelog

### [1.2.1](https://www.github.com/hydra-genetics/parabricks/compare/v1.2.0...v1.2.1) (2025-05-09)


### Bug Fixes

* extract the number of gpus in a more robust manner ([670aaeb](https://www.github.com/hydra-genetics/parabricks/commit/670aaeb13e41ce29ce7189da974f2e74cdf92ed9))

## [1.2.0](https://www.github.com/hydra-genetics/parabricks/compare/v1.1.0...v1.2.0) (2024-03-05)


### Features

* change how tmp-dir is specified and remove bqsr ([7b9f7f3](https://www.github.com/hydra-genetics/parabricks/commit/7b9f7f34aad6f2330fc2fd576aaa99172ec832f3))


### Bug Fixes

* remove extra params.extra in shell ([9a7d40f](https://www.github.com/hydra-genetics/parabricks/commit/9a7d40f775bb4f8be2ae4e331a3f24dc89e0388b))

## [1.1.0](https://www.github.com/hydra-genetics/parabricks/compare/v1.0.0...v1.1.0) (2023-06-19)


### Features

* handle gres specification for slurm version 22 ([9d1e1a8](https://www.github.com/hydra-genetics/parabricks/commit/9d1e1a888c5c65b1d038b07903a09f42c4d36d96))
* update snakemake version, to range with upper limit 8 ([6b85c00](https://www.github.com/hydra-genetics/parabricks/commit/6b85c0060f3408fe9af4a90d83fad87a18d6c633))

## [1.0.0](https://www.github.com/hydra-genetics/parabricks/compare/v0.2.0...v1.0.0) (2023-05-02)


### ⚠ BREAKING CHANGES

* reorder wildcards for compatability with prealignment module

### Features

* **pbrun:** Add cuda env variable through params ([779a0ee](https://www.github.com/hydra-genetics/parabricks/commit/779a0eee5679e483e1d10ed77df7953f4fec6ca1))
* Updates for compatability with Parabricks v4 ([25f08dc](https://www.github.com/hydra-genetics/parabricks/commit/25f08dc55ec0ff997afe0ddb05bb689ef2ecd397))


### Bug Fixes

* add {type} to file name ([b2dd0b0](https://www.github.com/hydra-genetics/parabricks/commit/b2dd0b049c63b34e1384f560a74152e286d26144))
* **common:** add fq2bam basm file as one of the ouputs ([6f857cd](https://www.github.com/hydra-genetics/parabricks/commit/6f857cdd48ea39095055c79616a7fc0f03d63df7))
* reorder wildcards for compatability with prealignment module ([6918b1d](https://www.github.com/hydra-genetics/parabricks/commit/6918b1d0ae4d21fe3a9939ef0e1df042dc42f21d))
* type in common ([40d1738](https://www.github.com/hydra-genetics/parabricks/commit/40d17386a6d2d4adfc601191d3f71ed5d16fba98))
* type in sankemake compability ([b6a3be3](https://www.github.com/hydra-genetics/parabricks/commit/b6a3be328d4e517b9931323c80f933c77ec0ebb1))


### Documentation

* create dag for rulegraph ([aaed08b](https://www.github.com/hydra-genetics/parabricks/commit/aaed08b061e9c31ba0a147d6b2504d13730f0e73))
* update compatability.md ([d6a8ca8](https://www.github.com/hydra-genetics/parabricks/commit/d6a8ca80d6cf23a6ef54e5a142acc26d80a7c513))
* update the rulegraph ([bf52ecc](https://www.github.com/hydra-genetics/parabricks/commit/bf52eccd7f71d5eebfcbfb89fcb3d9cfaa87525d))

## [0.2.0](https://www.github.com/hydra-genetics/parabricks/compare/v0.1.0...v0.2.0) (2022-05-16)


### Features

* Add check for compatibility ([ac57f74](https://www.github.com/hydra-genetics/parabricks/commit/ac57f74d454a03a9222f71bc0e2f9e5fe7d48d6b))


### Bug Fixes

* added barcode ([f5a1cfb](https://www.github.com/hydra-genetics/parabricks/commit/f5a1cfb0367b58752c7449247885662aed2e6928))
* barcode needed for unique id in read group ([abda323](https://www.github.com/hydra-genetics/parabricks/commit/abda3231e8d4ae3bf8aabdf2e70067cb14cffe93))
* Remove unnecessary steps in dry run action ([b551660](https://www.github.com/hydra-genetics/parabricks/commit/b551660c4dac69d28b2426ea8f1a0217def0414e))


### Documentation

* Update README ([c8c4495](https://www.github.com/hydra-genetics/parabricks/commit/c8c4495090dd600fcca4addf21c27ad27d20b57a))

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
