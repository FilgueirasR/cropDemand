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
#' @import raster
#' @importFrom dplyr %>%
#' @importFrom stats na.omit
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

crs<-crs(ppt)
Neg.ac <- replicate(12,(raster(nrows=nrow(ppt), ncols = ncol(ppt), xmn = extent(ppt)[1,], xmx = extent(ppt)[2,], ymn = extent(ppt)[3,], ymx = extent(ppt)[4,],
                               crs = crs(ppt), resolution = res(ppt), vals = 0))) %>% stack()
Neg.ac[is.na(ppt)]<--9999
Neg.ac<-Neg.ac %>% as.data.frame() %>% na.omit()


ARM <- replicate(12,(raster(nrows=nrow(ppt), ncols=ncol(ppt), xmn = extent(ppt)[1,], xmx = extent(ppt)[2,], ymn = extent(ppt)[3,], ymx = extent(ppt)[4,],
                            crs = crs(ppt), resolution = res(ppt), vals = AWC))) %>% stack()
ARM[is.na(ppt)]<-9999
ARM<-ARM%>% as.data.frame() %>% na.omit()

ALT<-replicate(12,(raster(nrows = nrow(ppt), ncols = ncol(ppt), xmn = extent(ppt)[1,], xmx = extent(ppt)[2,], ymn = extent(ppt)[3,], ymx = extent(ppt)[4,],
                          crs = crs(ppt), resolution = res(ppt), vals = 0 ))) %>% stack()
ALT[is.na(ppt)]<--9999
ALT<-ALT%>% as.data.frame() %>% na.omit()

ETR<-replicate(12,(raster(nrows = nrow(ppt), ncols = ncol(ppt), xmn = extent(ppt)[1,], xmx = extent(ppt)[2,], ymn = extent(ppt)[3,], ymx = extent(ppt)[4,],
                          crs = crs(ppt), resolution = res(ppt), vals = 0 ))) %>% stack()
ETR[is.na(ppt)]<--9999
ETR<-ETR%>% as.data.frame() %>% na.omit()

RET<-replicate(12,(raster(nrows = nrow(ppt), ncols = ncol(ppt), xmn = extent(ppt)[1,], xmx = extent(ppt)[2,], ymn = extent(ppt)[3,], ymx = extent(ppt)[4,],
                          crs = crs(ppt), resolution = res(ppt), vals = 0 ))) %>% stack()
RET[is.na(ppt)]<--9999
RET<-RET%>% as.data.frame() %>% na.omit()

DEF<-replicate(12,(raster(nrows = nrow(ppt), ncols = ncol(ppt), xmn = extent(ppt)[1,], xmx = extent(ppt)[2,], ymn = extent(ppt)[3,], ymx = extent(ppt)[4,],
                          crs = crs(ppt), resolution = res(ppt), vals = 0 ))) %>% stack()
DEF[is.na(ppt)]<--9999
DEF<-DEF%>% as.data.frame() %>% na.omit()

EXC<-replicate(12,(raster(nrows = nrow(ppt), ncols = ncol(ppt), xmn = extent(ppt)[1,], xmx = extent(ppt)[2,], ymn = extent(ppt)[3,], ymx = extent(ppt)[4,],
                          crs = crs(ppt), resolution = res(ppt), vals = 0 ))) %>% stack()
EXC[is.na(ppt)]<--9999
EXC<-EXC%>% as.data.frame() %>% na.omit()

REP<-replicate(12,(raster(nrows = nrow(ppt), ncols = ncol(ppt), xmn = extent(ppt)[1,], xmx = extent(ppt)[2,], ymn = extent(ppt)[3,], ymx = extent(ppt)[4,],
                          crs = crs(ppt), resolution = res(ppt), vals = 0 ))) %>% stack()
REP[is.na(ppt)]<--9999
REP<-REP%>% as.data.frame() %>% na.omit()

AWC_arm<-replicate(12,(raster(nrows = nrow(ppt), ncols = ncol(ppt), xmn = extent(ppt)[1,], xmx = extent(ppt)[2,], ymn = extent(ppt)[3,], ymx = extent(ppt)[4,],
                              crs = crs(ppt), resolution = res(ppt), vals = 0 ))) %>% stack()
AWC_arm[is.na(ppt)]<--9999
AWC_arm<-AWC_arm%>% as.data.frame() %>% na.omit()

etp[is.na(etp)]<--9999
etp.df<-as.data.frame(etp) %>% na.omit()
ppt[is.na(ppt)]<--9999
ppt.df<-as.data.frame(ppt) %>% na.omit()

PPT_ETP <- ppt.df-etp.df

PPT_ETP<- as.data.frame(PPT_ETP)


xy<-as.data.frame(rasterToPoints(ppt)[,c(1,2)])


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
Neg.ac<-rasterFromXYZ(Neg.ac, crs = crs)
names(Neg.ac)<- c("January", "February", "March", "April", "May", "June",
                  "July", "August", "September", "October", "November", "December")
Neg.ac[ppt == -9999]<-NA



ARM<- cbind(xy, ARM)
ARM<-rasterFromXYZ(ARM, crs = crs)
names(ARM)<- c("January", "February", "March", "April", "May", "June",
               "July", "August", "September", "October", "November", "December")
ARM[ppt == -9999]<-NA

ALT<- cbind(xy, ALT)
ALT<-rasterFromXYZ(ALT, crs = crs)
names(ALT)<- c("January", "February", "March", "April", "May", "June",
               "July", "August", "September", "October", "November", "December")
ALT[ppt == -9999]<-NA

ETR<- cbind(xy, ETR)
ETR<-rasterFromXYZ(ETR, crs = crs)
names(ETR)<- c("January", "February", "March", "April", "May", "June",
               "July", "August", "September", "October", "November", "December")
ETR[ppt == -9999]<-NA

DEF<- cbind(xy, DEF)
DEF<-rasterFromXYZ(DEF, crs = crs)
names(DEF)<- c("January", "February", "March", "April", "May", "June",
               "July", "August", "September", "October", "November", "December")
DEF[ppt == -9999]<-NA

EXC<- cbind(xy, EXC)
EXC<-rasterFromXYZ(EXC, crs = crs)
names(EXC)<- c("January", "February", "March", "April", "May", "June",
               "July", "August", "September", "October", "November", "December")
EXC[ppt == -9999]<-NA

REP<- cbind(xy, REP)
REP<-rasterFromXYZ(REP, crs = crs)
names(REP)<- c("January", "February", "March", "April", "May", "June",
               "July", "August", "September", "October", "November", "December")
REP[ppt == -9999]<-NA

RET<- cbind(xy, RET)
RET<-rasterFromXYZ(RET, crs = crs)
names(RET)<- c("January", "February", "March", "April", "May", "June",
               "July", "August", "September", "October", "November", "December")
RET[ppt == -9999]<-NA

AWC_arm<- cbind(xy, AWC_arm)
AWC_arm<-rasterFromXYZ(AWC_arm, crs = crs)
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
writeRaster(Neg.ac ,filename = name.Neg.ac, format = "GTiff", overwrite=T)
writeRaster(ARM ,filename = name.ARM, format = "GTiff", overwrite=T)
writeRaster(ALT ,filename = name.ALT, format = "GTiff", overwrite=T)
writeRaster(ETR ,filename = name.ETR, format = "GTiff", overwrite=T)
writeRaster(DEF ,filename = name.DEF, format = "GTiff", overwrite=T)
writeRaster(EXC ,filename = name.EXC, format = "GTiff", overwrite=T)
writeRaster(REP ,filename = name.REP, format = "GTiff", overwrite=T)
writeRaster(RET ,filename = name.RET, format = "GTiff", overwrite=T)
writeRaster(AWC_arm ,filename = name.AWC_arm, format = "GTiff", overwrite=T)

}

