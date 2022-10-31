#' Calibration of rainfall (ppt) of 'TerraClimate'
#'
#' @description This fuction will calibrate the rainfall (ppt) from TerraClimate dataset based in the relationship with observed weather stations data.
#' @param ppt_stack stack of ppt.
#' @param slope the slope of the linear regression (numeric).
#' @param intercept the intercept of the linear regression (numeric).
#' @import raster
#' @examples
#' \dontrun{
#'
#' ppt_cal<- ppt_calibration(slope = 0.7000972,
#'                           intercept = 23.753785, ppt_stack = ppt);
#' }
#' @return Returns a Rasterstack of ppt calibrated.
#' @export
#'
ppt_calibration<-function(slope, intercept, ppt_stack){
  ppt_calibrated<-slope*ppt_stack + intercept
  return(ppt_calibrated)}

#' Calibration of reference evapotranspiration (eto) of 'TerraClimate'
#'
#' @description This function will calibrate the reference evapotranspiration (eto) from TerraClimate dataset based in the relationship with observed weather stations data.
#' @param eto_stack stack of eto.
#' @param slope the slope of the linear regression (numeric).
#' @param intercept the intercept of the linear regression (numeric).
#' @import raster
#' @examples
#' \dontrun{
#' eto_cal<- eto_calibration(slope = 0.930073,
#'                            intercept = 22.399986, eto_stack = etp);
#' }
#' @return Returns a Rasterstack of eto calibrated.
#' @export
#'
eto_calibration<-function(slope, intercept, eto_stack){
  eto_calibrated<-slope*eto_stack + intercept
  return(eto_calibrated)}



