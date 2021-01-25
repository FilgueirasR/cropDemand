#' Download of reference evapotranspiration (eto) and rainfall (ppt) from 'TerraClimate'
#' \if{html}{\figure{logo_cropDemand.png}{options: height= 300 width=auto style = float:right alt= Our logo}}
#'
#' @description This function will download the eto and ppt and will load a rasterstack according to the the region of interest (Region and sub_region).
#' @param dir_out Directory where you want to save the raster images that you are goind to download.
#' @param variable Variable to download. This function will download the eto or ppt (Rasterstack).
#' @param region Use the "brazil" shapefile to extract the Rasterstack (variable) for one state (Brazilian state), or use the "biomes_brazil" to extract the Rasterstack (variable) for one biome of Brazil.
#' @param sub_region You have two options in this section, if you choice the brazil (in region parameter) you need to choice the Brazilian states, but if you choice the biomes_brazil (in region parameter) you must choice one of Brazilian biomes.
#' @param years The period in years that the function should download images.
#' @import raster
#' @import rgdal
#' @import ncdf4
#' @examples
#' \dontrun{
#'
#' ### Downloading eto based on Brazil states.
#' see_brazil_states()
#'
#' img<-download_terraclimate(variable = "eto",
#'                           years = c(2018:2019),
#'                           region = "brazil",
#'                           sub_region = 13)
#'
#' ### Downloading the ppt based on Brazil biomes.
#' see_brazil_biomes()
#'
#' img<-download_terraclimate(variable = "ppt",
#'                           years = c(2018:2019),
#'                           region = "biomes_brazil",
#'                           sub_region = 6)
#' }
#' @return Download for the region of interest the ppt (Rainfall) or eto (reference evapotranspiration) rasterstack
#' @references
#' The images used in this package can be found in the paper: Abatzoglou, J.T., S.Z. Dobrowski, S.A. Parks, K.C. Hegewisch, 2018, Terraclimate, a high-resolution global dataset of monthly climate and climatic water balance from 1958-2015, Scientific Data.
#' @export

download_terraclimate <- function(dir_out, variable, years, region, sub_region){

  if(variable == "eto"){variable<-"pet"} else {}
  if(variable == "ppt"| variable == "pet"){

    for(i in 1:length(years)){
      baseurl <- paste0("http://thredds.northwestknowledge.net:8080/thredds/fileServer/TERRACLIMATE_ALL/data/TerraClimate_", variable, "_", years[i],".nc")
      name_img<- paste0("TerraClimate_", variable, "_", years[i], ".nc")
      outfile<-paste0(dir_out, "/", name_img)
      utils::download.file(url = baseurl, destfile = outfile, mode = "wb")
      img<-stack(list.files(dir_out, pattern = name_img, full.names = T))
      invisible(capture.output(shp<-readOGR(system.file('extdata', paste0(region, ".shp"), package= 'cropDemand'))))
      area<-shp[sub_region,]
      img<-crop(img, area)
      img<-mask(img, area)
      img<-projectRaster(img, crs = "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")
      unlink(outfile)
      writeRaster(img, filename = paste0(dir_out,"/", paste0(substr(name_img, 1, 21), ".tif")), format = "GTiff")
    }

    setwd(dir_out)
    s<-stack(list.files(dir_out, pattern = ".tif$", full.names = T))
    return(s)} else{message("Please, pay attention. You should download the variable ppt or eto!")}
}
