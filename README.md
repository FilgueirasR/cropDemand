# cropDemand

<div class="fluid-row" id="header">
    <img src='man/figures/logo_cropDemand.png' height='150' width='auto' align='right'>


<!-- badges: start -->
[![R-CMD-check](https://github.com/FilgueirasR/cropDemand/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/FilgueirasR/cropDemand/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of cropDemand is to make a crop water balance based on Thornwaite Matter (1955),  with possibility to change the available water capacity value according to different crops, for any region of Brazil. The cropDemand package uses the Terraclimate dataset (http://www.climatologylab.org/terraclimate.html) calibrated with the automatic weather stations of National Meteorological Institute of Brazil (INMET).


## Installation

To install the last version of cropDemand package follow this steps:

``` r
devtools::install_github("FilgueirasR/cropDemand")

```

## Example

This is a basic example which shows you how to run the cropDemand package:

``` r
## basic example code

#devtools::install_github("FilgueirasR/cropDemand")
library(cropDemand)
library(raster)

see_brazil_biomes()

# dir_out = directory to save the images
# ppt and eto should have different directories

img_eto <- download_terraclimate(dir_out = "C:/eto", variable = "eto", years = c(2000:2017), region = "biomes_brazil", sub_region = 5) 
img_ppt <- download_terraclimate(dir_out = "C:/ppt", variable = "eto", years = c(2000:2017), region = "biomes_brazil", sub_region = 5) 

# if you want to calibrate the images for Brazil conditions, you can use the function eto_calibration and ppt_calibration

img_eto_cal <- eto_calibration(slope = 0.930073, intercept = 22.399986, eto_stack = img_eto)
img_ppt_cal <- ppt_calibration(slope = 0.7000972, intercept = 23.753785, ppt_stack = img_ppt)


start_date<-c('2000-01-01')
end_date<-c('2017-12-01')

monthly_ppt <- cropDemand::monthly_stack(stack = image_ppt, start_date = start_date, end_date = end_date)
monthly_eto <- cropDemand::monthly_stack(stack = image_eto, start_date = start_date, end_date = end_date)

cd<-waterDemand(out_dir = "C:/Users/betof/Desktop/teste_WD", ppt_stack = monthly_ppt , eto_stack = monthly_eto, AWC = 100)

cropDemand::plot_AWC(cd)


```
