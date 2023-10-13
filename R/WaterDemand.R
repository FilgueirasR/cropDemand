#' Function to generate the  water demand based in available water capacity of the soil
#'
#' @description This function will calculate the water balance parameters based in the available water capacity informed (AWC).
#' The output water balance parameters for this function are:
#'
#'    \enumerate{
#'      \item ARM - storage;
#'      \item ALT - alteration;
#'      \item ETR - actual evapotranspiration;
#'      \item DEF - deficit;
#'      \item EXC - excess;
#'      \item REP - replacement;
#'      \item RET - withdrawal;
#'      \item AWC_arm - percentage of storage compared to AWC;
#' }
#'
#' @param out_dir output directory where you want to save the variables
#' @param ppt_stack Stack of mean rainfall Rasterstack calculated in monthly_stack function
#' @param eto_stack Stack of mean evapotranspiration Rasterstack calculated in monthly_stack function
#' @param AWC The available water capacity (AWC) that the function will use in the calculations. The AWC value must be chosen according to the crop (root system depth) you want to obtain the water balance.
#' @import terra
#' @importFrom dplyr %>%
#' @importFrom terra na.omit
#' @examples
#' \dontrun{
#' cwd<- waterDemand(out_dir = "G:/My computer/test/CropWaterDemand",
#'                   ppt_stack = rainfall_image, eto_stack = eto_image, AWC = 100)
#' }
#' @export
#' @return Returns multiple Rasterstack object as output (explained in description).


waterDemand <- function(out_dir, ppt_stack, eto_stack, AWC){

ppt<-ppt_stack
etp<-eto_stack

crs<-terra::crs(ppt)

Neg.ac <- sapply(1:12, function(i) {
  rast(nrows = nrow(ppt), ncols = ncol(ppt),
       xmin = terra::ext(ppt)[1], xmax = terra::ext(ppt)[2],
       ymin = terra::ext(ppt)[3], ymax = terra::ext(ppt)[4],
       crs = terra::crs(ppt), resolution = terra::res(ppt),
       vals = 0)
}) %>% rast()


Neg.ac[is.na(ppt)]<--9999
Neg.ac<-Neg.ac %>% as.data.frame() %>% na.omit()


ARM <- sapply(1:12, function(i) {
  rast(nrows = nrow(ppt), ncols = ncol(ppt),
       xmin = terra::ext(ppt)[1], xmax = terra::ext(ppt)[2],
       ymin = terra::ext(ppt)[3], ymax = terra::ext(ppt)[4],
       crs = terra::crs(ppt), resolution = terra::res(ppt),
       vals = AWC)
}) %>% rast()

ARM[is.na(ppt)]<-9999
ARM<-ARM%>% as.data.frame() %>% na.omit()

ALT <- sapply(1:12, function(i) {
  rast(nrows = nrow(ppt), ncols = ncol(ppt),
       xmin = terra::ext(ppt)[1], xmax = terra::ext(ppt)[2],
       ymin = terra::ext(ppt)[3], ymax = terra::ext(ppt)[4],
       crs = terra::crs(ppt), resolution = terra::res(ppt),
       vals = 0)
}) %>% rast()

ALT[is.na(ppt)]<--9999
ALT<-ALT%>% as.data.frame() %>% na.omit()

ETR<-sapply(1:12, function(i) {
  rast(nrows = nrow(ppt), ncols = ncol(ppt),
       xmin = terra::ext(ppt)[1], xmax = terra::ext(ppt)[2],
       ymin = terra::ext(ppt)[3], ymax = terra::ext(ppt)[4],
       crs = terra::crs(ppt), resolution = terra::res(ppt),
       vals = 0)
}) %>% rast()

ETR[is.na(ppt)]<--9999
ETR<-ETR%>% as.data.frame() %>% na.omit()

RET<-sapply(1:12, function(i) {
  rast(nrows = nrow(ppt), ncols = ncol(ppt),
       xmin = terra::ext(ppt)[1], xmax = terra::ext(ppt)[2],
       ymin = terra::ext(ppt)[3], ymax = terra::ext(ppt)[4],
       crs = terra::crs(ppt), resolution = terra::res(ppt),
       vals = 0)
}) %>% rast()

RET[is.na(ppt)]<--9999
RET<-RET%>% as.data.frame() %>% na.omit()

DEF<-sapply(1:12, function(i) {
  rast(nrows = nrow(ppt), ncols = ncol(ppt),
       xmin = terra::ext(ppt)[1], xmax = terra::ext(ppt)[2],
       ymin = terra::ext(ppt)[3], ymax = terra::ext(ppt)[4],
       crs = terra::crs(ppt), resolution = terra::res(ppt),
       vals = 0)
}) %>% rast()

DEF[is.na(ppt)]<--9999
DEF<-DEF%>% as.data.frame() %>% na.omit()

EXC<-sapply(1:12, function(i) {
  rast(nrows = nrow(ppt), ncols = ncol(ppt),
       xmin = terra::ext(ppt)[1], xmax = terra::ext(ppt)[2],
       ymin = terra::ext(ppt)[3], ymax = terra::ext(ppt)[4],
       crs = terra::crs(ppt), resolution = terra::res(ppt),
       vals = 0)
}) %>% rast()

EXC[is.na(ppt)]<--9999
EXC<-EXC %>% as.data.frame() %>% na.omit()

REP<-sapply(1:12, function(i) {
  rast(nrows = nrow(ppt), ncols = ncol(ppt),
       xmin = terra::ext(ppt)[1], xmax = terra::ext(ppt)[2],
       ymin = terra::ext(ppt)[3], ymax = terra::ext(ppt)[4],
       crs = terra::crs(ppt), resolution = terra::res(ppt),
       vals = 0)
}) %>% rast()

REP[is.na(ppt)]<--9999
REP<-REP%>% as.data.frame() %>% na.omit()

AWC_arm<-sapply(1:12, function(i) {
  rast(nrows = nrow(ppt), ncols = ncol(ppt),
       xmin = terra::ext(ppt)[1], xmax = terra::ext(ppt)[2],
       ymin = terra::ext(ppt)[3], ymax = terra::ext(ppt)[4],
       crs = terra::crs(ppt), resolution = terra::res(ppt),
       vals = 0)
}) %>% rast()

AWC_arm[is.na(ppt)]<--9999
AWC_arm<-AWC_arm%>% as.data.frame() %>% na.omit()

etp[is.na(etp)]<--9999
etp.df<-as.data.frame(etp) %>% na.omit()
ppt[is.na(ppt)]<--9999
ppt.df<-as.data.frame(ppt) %>% na.omit()

PPT_ETP <- ppt.df-etp.df

PPT_ETP<- as.data.frame(PPT_ETP)

xy <- data.frame(x = terra::as.data.frame(ppt, xy = T)[, 1], y = terra::as.data.frame(ppt, xy = T)[, 2])

i<-1
j<-1


for(i in 1:12){ for(j in 1:nrow(PPT_ETP)){

  if(i == 1 && PPT_ETP[,i][j]  >= 0){Neg.ac[,i][j] <- 0} else{}

  if(i == 1 && PPT_ETP[,i][j] < 0){Neg.ac[,i][j] <- PPT_ETP[,i][j]} else{}
  if(i == 1){ARM[,i][j] <- AWC*exp(Neg.ac[,i][j]/AWC)} else{}

  if(i != 1 && PPT_ETP[,i][j] < 0){Neg.ac[,i][j] <- PPT_ETP[,i][j] + Neg.ac[, i - 1][j]} else{}
  if(i != 1 && PPT_ETP[,i][j] < 0){ARM[,i][j] <- AWC*exp(Neg.ac[,i][j]/AWC)} else{}

  if(i != 1 && PPT_ETP[,i][j]  >= 0  && PPT_ETP[,i-1][j] < 0 && (PPT_ETP[,i][j] + ARM[,i-1][j]) <= AWC ){ ARM[,i][j] <- PPT_ETP[,i][j] + ARM[,i-1][j]} else{}
  if(i != 1 && PPT_ETP[,i][j]  >= 0  && PPT_ETP[,i-1][j] < 0 && (PPT_ETP[,i][j] + ARM[,i-1])[j] <= AWC ){ Neg.ac[,i][j] <- AWC*log(ARM[,i][j]/AWC)} else{}

  if(i != 1 && PPT_ETP[,i][j]  >= 0 && (PPT_ETP[,i][j] + ARM[,i-1][j]) > AWC ){ ARM[,i][j]<- AWC} else{}
}
}


for(i in 1:12){ for(j in 1:nrow(PPT_ETP)){
  if(i == 1){ALT[,i][j]<-ARM[,1][j]-ARM[,12][j]} else{ALT[,i][j]<-ARM[,i][j]-ARM[,i-1][j]}
}
}



for(i in 1:12){ for(j in 1:nrow(PPT_ETP)){
  if(PPT_ETP[,i][j] >= 0){ETR[,i][j] <- etp.df[,i][j]} else{}
  if(PPT_ETP[,i][j] < 0){ETR[,i][j] <- ppt.df[,i][j] - ALT[,i][j]}
}
}



for(i in 1:12){ for(j in 1:nrow(PPT_ETP)){
  if(ALT[,i][j] >= 0){RET[,i][j] <- 0} else {RET[,i][j] <-(((ALT[,i][j]))/AWC)*100}
}
}



DEF<-etp.df - ETR



for(i in 1:12){ for(j in 1:nrow(PPT_ETP)){
  if(PPT_ETP[,i][j] > 0 && ARM[,i][j] == AWC){EXC[,i][j] <- PPT_ETP[,i][j] - ALT[,i][j]}else{EXC[,i][j] <- 0}
}
}

AWC_arm<- (ARM/AWC)*100

Neg.ac<- cbind(xy, Neg.ac)
Neg.ac<- terra::rast(Neg.ac , type="xyz")
names(Neg.ac)<- c("January", "February", "March", "April", "May", "June",
                  "July", "August", "September", "October", "November", "December")
Neg.ac[ppt == -9999]<-NA

ARM<- cbind(xy, ARM)
ARM<-terra::rast(ARM , type="xyz")
names(ARM)<- c("January", "February", "March", "April", "May", "June",
               "July", "August", "September", "October", "November", "December")
ARM[ppt == -9999]<-NA

ALT<- cbind(xy, ALT)
ALT<-terra::rast(ALT , type="xyz")
names(ALT)<- c("January", "February", "March", "April", "May", "June",
               "July", "August", "September", "October", "November", "December")
ALT[ppt == -9999]<-NA

ETR<- cbind(xy, ETR)
ETR<-terra::rast(ETR , type="xyz")
names(ETR)<- c("January", "February", "March", "April", "May", "June",
               "July", "August", "September", "October", "November", "December")
ETR[ppt == -9999]<-NA

DEF<- cbind(xy, DEF)
DEF<-terra::rast(DEF , type="xyz")
names(DEF)<- c("January", "February", "March", "April", "May", "June",
               "July", "August", "September", "October", "November", "December")
DEF[ppt == -9999]<-NA

EXC<- cbind(xy, EXC)
EXC<-terra::rast(EXC , type="xyz")
names(EXC)<- c("January", "February", "March", "April", "May", "June",
               "July", "August", "September", "October", "November", "December")
EXC[ppt == -9999]<-NA

REP<- cbind(xy, REP)
REP<-terra::rast(REP , type="xyz")
names(REP)<- c("January", "February", "March", "April", "May", "June",
               "July", "August", "September", "October", "November", "December")
REP[ppt == -9999]<-NA

RET<- cbind(xy, RET)
RET<-terra::rast(RET , type="xyz")
names(RET)<- c("January", "February", "March", "April", "May", "June",
               "July", "August", "September", "October", "November", "December")
RET[ppt == -9999]<-NA

AWC_arm<- cbind(xy, AWC_arm)
AWC_arm<- terra::rast(AWC_arm , type="xyz")
names(AWC_arm)<- c("January", "February", "March", "April", "May", "June",
                   "July", "August", "September", "October", "November", "December")
AWC_arm[ppt == -9999]<-NA

setwd(out_dir)
name.Neg.ac<-paste0("Neg.ac_","AWC_", AWC, ".tif")
name.ARM<-paste0("ARM_","AWC_", AWC, ".tif")
name.ALT<-paste0("ALT_","AWC_", AWC, ".tif")
name.ETR<-paste0("ETR_","AWC_", AWC, ".tif")
name.DEF<-paste0("DEF_","AWC_", AWC, ".tif")
name.EXC<-paste0("EXC_","AWC_", AWC, ".tif")
name.REP<-paste0("REP_","AWC_", AWC, ".tif")
name.RET<-paste0("RET_","AWC_", AWC, ".tif")
name.AWC_arm<-paste0("AWC_arm_","AWC_", AWC, ".tif")
terra::writeRaster(Neg.ac ,filename = name.Neg.ac,  filetype = "GTiff")
terra::writeRaster(ARM ,filename = name.ARM,  filetype = "GTiff")
terra::writeRaster(ALT ,filename = name.ALT,  filetype = "GTiff")
terra::writeRaster(ETR ,filename = name.ETR,  filetype = "GTiff")
terra::writeRaster(DEF ,filename = name.DEF,  filetype = "GTiff")
terra::writeRaster(EXC ,filename = name.EXC,  filetype = "GTiff")
terra::writeRaster(REP ,filename = name.REP,  filetype = "GTiff")
terra::writeRaster(RET ,filename = name.RET,  filetype = "GTiff")
terra::writeRaster(AWC_arm ,filename = name.AWC_arm, filetype = "GTiff")

}

