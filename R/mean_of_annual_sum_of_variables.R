#' Calculates the mean of the annual sum of the variables values
#'
#' @description The function calculates the mean of the annual sum of the variables of interest.
#' @param list_dir_of_imgs directory containing the images downloaded in download_terraclimate
#' @examples
#' \dontrun{
#'
#' annual_mean_ppt<- mean_of_annual_sum_of_variables(list_dir_of_imgs = C:/ppt_dir);
#' }
#' @return Returns a SpatRaster with the calculation.
#' @export
#'

mean_of_annual_sum_of_variables <- function(list_dir_of_imgs){

imgs <- terra::rast(list_dir_of_imgs)
n_imgs<- terra::nlyr(imgs)/12
img_sum<- terra::app(imgs, sum)
img <- img_sum/n_imgs
return(img)
}
