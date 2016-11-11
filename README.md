
<!-- Edit the README.Rmd only!!! The README.md is generated automatically from README.Rmd. -->
caliver: CALIbration and VERification of gridded model outputs
==============================================================

The package [caliver](https://cran.r-project.org/package=caliver) contains Utility functions for the post-processing, calibration and validation of gridded model outputs. Initial test cases include the outputs of the following forest fire models: GEFF and RISICO.

Dependencies and Installation
-----------------------------

Install [cdo](https://code.zmaw.de/projects/cdo/wiki) and the following packages before attempting to install caliver:

``` r
packs <- c('devtools', 'rgdal', 'sp', 'leaflet', 'testthat', 'knitr', 'rmarkdown')
new.packages <- packs[!(packs %in% installed.packages()[,'Package'])]
if(length(new.packages)) install.packages(new.packages)
```

### Installation

Get the development version from github using [devtools](https://github.com/hadley/devtools):

``` r
devtools::install_github('anywhereProject/caliver')
```

Load the caliver package:

``` r
library('caliver')
```

Typical workflow
----------------

Define the data folder

``` r
dirs <- "/var/tmp/moc0/forestfire"
```

Decompress all the files in a given folder (from *.nc.gz to *.nc)

``` r
decompressGZ(dirs, keep = FALSE)
```

Merge all the files (with name starting with *startingString*) over the time dimension

``` r
mergedFile <- mergetime(dirs, startingString = "geff_reanalysis_an_fwis_fwi_")
```

Get maps for given quantiles

``` r
listOfMaps <- getGriddedCDF(ncfile = mergedFile, varname = "fwi", probs = c(50, 75, 90, 99))
```

Plot maps

``` r
# Define a background map
newmap <- rworldmap::getMap(resolution = "low")
plotPercentiles(listOfMaps, background = newmap)
```

Meta
----

-   This package and functions herein are part of an experimental open-source project. They are provided as is, without any guarantee.
-   Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
-   Please [report any issues or bugs](https://github.com/anywhereProject/caliver/issues).
-   License: [GPL-3](https://opensource.org/licenses/GPL-3.0)
-   Get citation information for `caliver` in R doing `citation(package = 'caliver')`
