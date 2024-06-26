#' Load image data to do crop water demand
#'
#' @description This fuction will load the evapotranspiration and rainfall data for the region of interest (ROI).
#' @param variable Stack of evapotranspiration or rainfall (SpatRaster).
#' @param region Use the "brazil" shp file to extract the SpatRaster (variable) for one state (Brazilian state), or use the "biomes_brazil" to extract the SpatRaster (variable) for one biome of Brazil.
#' @param sub_region You have two options in this section, if you choice the brazil (in region parameter) you need to choice the Brazilian states, but if you choice the biomes-brazil (in region parameter) you must choice one of Brazilian biomes.
#' @import terra
#' @import sf
#' @examples
#' \dontrun{
#' #For Brazilian states
#'
#' see_brazil_states()
#'
#' image_etp<-loadROI(variable = "eto", region = "brazil",
#'                     sub_region = 13) # sub_regions 1:27
#'
#' image_rainfall<-loadROI(variable = "ppt",
#'                         region = "brazil", sub_region = 13)
#'
#' #For Brazilian Biomes:
#'
#' see_brazil_biomes()
#'
#' image_tmin<- loadROI(variable = "eto", region = "biomes_brazil",
#'                       sub_region = 2)# sub regions: 1:6 (biomes)
#'
#' }
#' @references
#' The images used in this package can be found in the paper: Abatzoglou, J.T., S.Z. Dobrowski, S.A. Parks, K.C. Hegewisch, 2018, Terraclimate, a high-resolution global dataset of monthly climate and climatic water balance from 1958-2015, Scientific Data.
#' @return Load the reference evapotranspiration (eto) or rainfall (ppt) SpatRaster
#' @export


loadROI<-function(variable, region, sub_region){

  invisible(capture.output(shp <- sf::st_read(system.file("extdata", paste0(region, ".shp"), package = "cropDemand"))))
  area<-shp[sub_region,]
  img<-terra::rast(system.file('extdata', paste0(variable, ".tif"), package= 'cropDemand'))
  img_area<-terra::crop(img, area)
  img_area<-terra::mask(img_area, terra::vect(area))
}




