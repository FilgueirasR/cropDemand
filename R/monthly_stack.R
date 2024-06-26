#' Function to calculate the mean monthly rainfall/reference evapotranspiration to generate the crop water demand
#'
#' @description This function will calculate the mean monthly air temperature based on the period of time selected (start_date and end_date).
#' @param stack Stack of mean rainfall/reference evapotranspiration SpatRaster
#' @param start_date Date that start the investigation, should be in the following format (2000-01-01 /Year-Month-Day)
#' @param end_date Date that end the investigation, should be in the following format (2017-12-31 /Year-Month-Day)
#' @importFrom terra tapp
#' @examples
#' \dontrun{
#' start_date <- c('2000-01-01')
#' end_date <- c('2017-12-01')
#' monthly_rainfall <- monthly_stack(stack = rainfall_stack,
#'                                   start_date = start_date, end_date = end_date)
#' }
#' @export
#' @return Returns a SpatRaster with a monthly mean air temperature from a period of time


monthly_stack<-function(stack, start_date, end_date){
  id_month <- seq(as.Date(start_date), as.Date(end_date), 'month')
  months <- as.numeric(format(id_month, "%m"))
  monthly_stack_img <- terra::tapp(stack,  index = months, mean)
  names(monthly_stack_img)<-c("January", "February", "March", "April", "May", "June",
                            "July", "August", "September", "October", "November", "December")

  return(monthly_stack_img)
}







