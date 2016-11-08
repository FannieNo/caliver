caliver: CALIbration and VERification of gridded model outputs
==============================================================


The package [caliver](https://cran.r-project.org/package=caliver) contains Utility functions for the post-processing, calibration and validation of gridded model outputs. Initial test cases include the outputs of the following forest fire models: GEFF and RISICO.

## Installation

Install the following packages before attempting to install caliver:

```{r}
packs <- c('devtools', 'rgdal', 'sp', 'leaflet', 'testthat', 'knitr', 'rmarkdown')
new.packages <- packs[!(packs %in% installed.packages()[,'Package'])]
if(length(new.packages)) install.packages(new.packages)
```

### Installation

Get the development version from github using [devtools](https://github.com/hadley/devtools):

```{r}
devtools::install_github('anywhereProject/caliver')
```

Load the caliver package:

```{r}
library('caliver')
```

## Meta

* This package and functions herein are part of an experimental open-source project. They are provided as is, without any guarantee.
* Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
* Please [report any issues or bugs](https://github.com/anywhereProject/caliver/issues).
* License: [GPL-3](https://opensource.org/licenses/GPL-3.0)
* Get citation information for `caliver` in R doing `citation(package = 'caliver')`
