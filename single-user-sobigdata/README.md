# How to

## Create a conda-lock file

Steps:

```shell
conda create -n conda-lock -c conda-forge conda-lock --yes
conda activate conda-lock
conda-lock --file=sbd-extended.yml --platform=linux-64
```

## Install conda-lock file

Steps:

```shell
conda create -n conda-lock -c conda-forge conda-lock --yes
conda activate conda-lock
conda-lock install --name sbd conda-lock.yml
```
