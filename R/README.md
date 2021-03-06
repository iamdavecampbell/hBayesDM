
# hBayesDM

[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![Build
Status](https://travis-ci.org/CCS-Lab/hBayesDM.svg?branch=develop)](https://travis-ci.org/CCS-Lab/hBayesDM)
[![Documentation](https://github.com/CCS-Lab/hBayesDM/workflows/Documentation/badge.svg)](https://github.com/CCS-Lab/hBayesDM/actions?query=workflow%3ADocumentation)
[![CRAN Latest
Release](https://www.r-pkg.org/badges/version-last-release/hBayesDM)](https://cran.r-project.org/package=hBayesDM)
[![Downloads](https://cranlogs.r-pkg.org/badges/grand-total/hBayesDM)](https://cran.r-project.org/web/packages/hBayesDM/index.html)
[![DOI](https://zenodo.org/badge/doi/10.1162/CPSY_a_00002.svg)](https://doi.org/10.1162/CPSY_a_00002)

**hBayesDM** (hierarchical Bayesian modeling of Decision-Making tasks)
is a user-friendly package that offers hierarchical Bayesian analysis of
various computational models on an array of decision-making tasks.
hBayesDM uses [Stan](https://mc-stan.org/) for Bayesian inference.

## Quick Links

-   **Mailing list**:
    <https://groups.google.com/forum/#!forum/hbayesdm-users>
-   **Bug reports**: <https://github.com/CCS-Lab/hBayesDM/issues>
-   **Contributing**: See the
    [Wiki](https://github.com/CCS-Lab/hBayesDM/wiki) of this repository.
-   **Python interface for hBayesDM**:
    [PyPI](https://pypi.org/project/hbayesdm/),
    [documentation](https://hbayesdm.readthedocs.io)

## Getting Started

### Prerequisite

To install hBayesDM for R, **[RStan](https://github.com/stan-dev/rstan)
needs to be properly installed before you proceed**. For detailed
instructions on having RStan ready prior to installing hBayesDM, please
go to this link:
<https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started>

### Installation

The lastest **stable** version of hBayesDM can be installed from CRAN by
running the following command in R:

``` r
install.packages("hBayesDM")  # Install hBayesDM from CRAN
```

or you can also install from GitHub with:

``` r
# `devtools` is required to install hBayesDM from GitHub
if (!require(devtools)) install.packages("devtools")

devtools::install_github("CCS-Lab/hBayesDM", subdir="R")
```

If you want to use the latest *development* version of hBayesDM, run the
following in R:

``` r
# `devtools` is required to install hBayesDM from GitHub
if (!require(devtools)) install.packages("devtools")

devtools::install_github("CCS-Lab/hBayesDM", ref="develop", subdir="R")
```

### Building at once

By default, you will have to wait for compilation when you run each
model for the first time. If you plan on runnning several different
models and want to pre-build all models during installation time, set an
environment variable `BUILD_ALL` to `true`, like the following. We
highly recommend you only do so when you have multiple cores available,
since building all models at once takes quite a long time to complete.

``` r
Sys.setenv(BUILD_ALL = "true")  # Build *all* models at installation time
Sys.setenv(MAKEFLAGS = "-j 4")  # Use 4 cores for build (or any other number you want)

install.packages("hBayesDM")                    # Install from CRAN
# or
devtools::install_github("CCS-Lab/hBayesDM/R")  # Install from GitHub
```

## Citation

If you used hBayesDM or some of its codes for your research, please cite
[this
paper](https://www.mitpressjournals.org/doi/full/10.1162/CPSY_a_00002):

``` bibtex
@article{hBayesDM,
  title = {Revealing Neurocomputational Mechanisms of Reinforcement Learning and Decision-Making With the {hBayesDM} Package},
  author = {Ahn, Woo-Young and Haines, Nathaniel and Zhang, Lei},
  journal = {Computational Psychiatry},
  year = {2017},
  volume = {1},
  pages = {24--57},
  publisher = {MIT Press},
  url = {doi:10.1162/CPSY_a_00002},
}
```
