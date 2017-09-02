context("mask_with_fuelmodel")

inFile <- tempfile()
download.file(url = "https://dl.dropboxusercontent.com/u/23404805/caliver_test_data/outTest.nc", destfile = inFile)
x <- raster::raster(inFile)

test_that("mask_with_fuelmodel works in the range 0+360", {
  
  xmasked <- mask_with_fuelmodel(x)
  
  # Check whether layers are named correctly
  expect_equal(round(raster::cellStats(xmasked, mean),3), 1.618)
  
})

test_that("mask_with_fuelmodel works in the range -180+180", {
  
  y <- raster::rotate(x)
  
  ymasked <- mask_with_fuelmodel(y)
  
  # Check whether layers are rotated correctly
  expect_equal(round(raster::extent(ymasked),0)[1], -180)
  expect_equal(round(raster::extent(ymasked),0)[2], 180)
  
})