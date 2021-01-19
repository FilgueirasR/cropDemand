# cropDemand

<div class="fluid-row" id="header">
    <img src='https://lh5.googleusercontent.com/e4jYKURwni1-Sb9gwgfKP8un8HsZpdC6YmiTLoFMvdv6zh9CKpZYPcwEN_1O7I2iQ7ilm3iY76lEfSARhqH4kDjnC_NITEqJ-tzk146oCkvJN1ZlqC2G=w1280' height='150' width='auto' align='right'>


<!-- badges: start -->
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

see_brazil_states()

image_ppt<-loadROI(variable = "ppt", region = "brazil", sub_region = 10) # sub_region = Maranhão
image_etp<-loadROI(variable = "etp", region = "brazil", sub_region = 10) # sub_region = Maranhão

start_date<-c('2000-01-01')
end_date<-c('2017-12-01')

monthly_ppt <- cropDemand::monthly_stack(stack = image_ppt, start_date = start_date, end_date = end_date)
monthly_etp <- cropDemand::monthly_stack(stack = image_etp, start_date = start_date, end_date = end_date)

cd<-waterDemand(out_dir = "C:/Users/betof/Desktop/teste_WD", ppt_stack = monthly_ppt , etp_stack = monthly_etp, AWC = 100)

cropDemand::plot_AWC(cd)


```
