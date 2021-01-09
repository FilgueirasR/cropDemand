#' Soil moisture estimation based in TOTRAM's models
#'
#' @description This fuction will calculate the soil moisture based in TOTRAM's models, which uses NDVI and LST as input (Rasterstack).
#' @param img_ndvi rasterstack of NDVI (Normalized Difference Vegetation Index)
#' @param img_lst rasterstack of LST (Land Surface Temperature)
#' @export
#' @import ggplot2
#' @import raster
#' @import extrafont
#' @importFrom ggplot2 aes
#' @importFrom ggplot2 geom_abline
#' @importFrom ggplot2 geom_point
#' @importFrom ggplot2 ggtitle
#' @importFrom ggplot2 theme_gray
#' @importFrom raster rasterToPoints
#' @importFrom dplyr left_join
#' @importFrom dplyr %>%
#' @importFrom dplyr group_by
#' @importFrom dplyr top_n
#' @importFrom dplyr mutate
#' @importFrom stats lm
#' @return Returns a Rasterstack of soil moisture (W).

w_totram <- function(img_ndvi, img_lst){
  df_ndvi<-as.data.frame(rasterToPoints(img_ndvi))
  df_lst<-as.data.frame(rasterToPoints(img_lst))
  names(df_ndvi)<-c("x", "y", "ndvi")
  names(df_lst)<-c("x", "y", "lst")
  df<-left_join(df_ndvi, df_lst, by = c("x", "y"))
  df<-round(df,2)

  # selecting the maximum values of land surface temperature of each group of NDVI


  max.df<- top_n(group_by(df$ndvi), 1, df$lst)
  max.df<- mutate(max.df, "Dry edge")
  names(max.df)<-c("X", "Y", "NDVI", "LST", "Edge")
  reg.df.max<-lm(formula=max.df$LST~max.df$NDVI, data= max.df)
  id <- summary(reg.df.max)$coef[1,1]
  sd <- summary(reg.df.max)$coef[2,1]

  # selecting the minimum values of land surface temperature of each group of NDVI

  min.df<- top_n(group_by(df$ndvi), -1, df$lst)
  min.df<- mutate(max.df, "dry edge")
  names(min.df)<-c("X", "Y", "NDVI", "LST", "Edge")

  reg.df.min<-lm(formula=min.df$LST~min.df$NDVI, data= min.df)

  iw <- summary(reg.df.min)$coef[1,1]
  sw <- summary(reg.df.min)$coef[2,1]

  #We will join the twi dataframes (max (dry edge) and min (wet edge)) to plot them in the same graphic

  df_total<- rbind(max.df, min.df)

a<-ggplot2::ggplot(data = df_total, aes(x = df_total$NDVI, y = df_total$LST, colour = df_total$Edge))+
    geom_point()+
    theme_gray(base_size = 16, base_family = "Times New Roman")+
    geom_abline(intercept =summary(reg.df.min)$coef[1,1] , slope = summary(reg.df.min)$coef[2,1], col = "blue")+
    geom_abline(intercept =summary(reg.df.max)$coef[1,1] , slope = summary(reg.df.max)$coef[2,1], col = "red")+
    ggtitle(label = "Parameters of TOTRAM's model")

print(a)

  W <- ((id + (sd*img_ndvi) - img_lst)/(id - iw + (sd - sw)*img_ndvi))


  return(W)

}




