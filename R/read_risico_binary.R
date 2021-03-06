#' @title read_risico_binary
#'
#' @description Reads a RISICO output file and returns a raster map
#'
#' @param filename is the file to read
#'
#' @export
#'
#' @examples
#' \dontrun{
#'   r_values <- read_risico_binary("data/RISICO2015_VPPF_201611140300")
#' }
#'

read_risico_binary <- function(filename){

  my_file <- gzfile(filename, "rb")
  grid_type <- readBin(my_file, integer(), 1)

  if (grid_type == 1) {

    #regular grid
    grid_size <- readBin(my_file, "integer", 2, size = 4)
    n_values <- grid_size[1] * grid_size[2]

    lats <- readBin(my_file, "double", 2, size = 4)
    lons <- readBin(my_file, "double", 2, size = 4)

    values_vect <- readBin(my_file, "double", n_values, size = 4)
    values_vect[values_vect == -9999] <- NA

    vals <- matrix(values_vect, nrow = grid_size[1], byrow = T)
    vals <- vals[nrow(vals):1, 1:ncol(vals)]

    r_values <- raster::raster(vals, xmn = lons[1], xmx = lons[2],
                               ymn = lats[1], ymx = lats[2])

  }

  close(my_file)

  return(r_values)

}
