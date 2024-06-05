#' Calculates the aridity index
#'
#' @description The aridity index (AI) is a numerical indicator used to quantify the degree of dryness of a climate at a given location. It is calculated as the ratio of annual precipitation to potential evapotranspiration.
#' @param annual_img_ppt rast image with the annual sum of the precipitation
#' @param annual_img_etp rast image of annual sum of the potential evapotranspiration
#' @examples
#' \dontrun{
#'
#'  ai_index_img <- ai_index_calculation(annual_img_ppt, annual_img_etp);
#' }
#' @return Returns a SpatRaster with the calculation.
#' @export
#'

ai_index_calculation <- function(annual_img_ppt, annual_img_etp){

  ai_index <- annual_img_ppt/annual_img_etp

  return(ai_index)
}
