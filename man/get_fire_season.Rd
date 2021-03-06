% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_fire_season.R
\name{get_fire_season}
\alias{get_fire_season}
\title{get_fire_season}
\usage{
get_fire_season(dates, fss = NULL, fse = NULL, zone = NULL)
}
\arguments{
\item{dates}{vector of dates}

\item{fss}{Fire Season Start (date in the format Y-m-d)}

\item{fse}{Fire Season End (date in the format Y-m-d)}

\item{zone}{this can either: "north", "south" or "tropics"}
}
\description{
Get the season for each date in a vector
}
\examples{
\dontrun{
  # Modify default seasons
  seasons <- get_fire_season(dates,
                           fss = as.Date("2012-04-01", format = "\%Y-\%m-\%d"),
                           fse = as.Date("2012-10-31", format = "\%Y-\%m-\%d"))
}

}
