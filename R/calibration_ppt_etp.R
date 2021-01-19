#' Calibration of ppt and etp of TerraClimate
#'
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

#' Calibration of minimum air temperature from TerraClimate
#'
#' @description This fuction will calibrate the reference evapotranspiration (etp) from TerraClimate dataset based in the relationship with observed weather stations data.
#' @param etp_stack stack of etp.
#' @param slope the slope of the linear regression (numeric).
#' @param intercept the intercept of the linear regression (numeric).
#' @import raster
#' @examples
#' \dontrun{
#' etp_cal<- etp_calibration(slope = 0.930073,
#'                            intercept = 22.399986, etp_stack = etp);
#' }
#' @return Returns a Rasterstack of etp calibrated.
#' @export
#'
etp_calibration<-function(slope, intercept, etp_stack){
  etp_calibrated<-slope*etp_stack + intercept
  return(etp_calibrated)}



