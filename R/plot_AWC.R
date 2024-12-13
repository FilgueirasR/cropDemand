#' Function to plot the percentage of Available Water Capacity (AWC)
#'
#' @description This function will plot the monthly AWC
#' @importFrom ggplot2
#'   ggplot
#'   aes
#'   geom_raster
#'   coord_fixed
#'   scale_fill_gradient
#'   theme
#'   facet_wrap
#'   guides
#'   guide_legend
#'   element_text
#'   element_blank
#'   labs
#'   unit
#' @importFrom tidyr
#'   gather
#' @importFrom terra
#'   na.omit
#' @param AWC_stack A SpatRaster generated in WaterDemand function
#' @examples
#' \dontrun{
#' plot_AWC(AWC_stack)
#' }
#' @return Returns a  plot (gg file) of monthly percentage of AWC
#' @export


plot_AWC<-function(AWC_stack){

  Months<-AWC<-y<-x<-NULL

names(AWC_stack)<-c( "January", "February", "March", "April", "May", "June",
                      "July", "August", "September", "October", "November", "December")
  df <- as.data.frame(terra::as.data.frame(AWC_stack, xy = T))
  levels(df)
  names(df)

  df<-terra::na.omit(tidyr::gather(df, "Months", "AWC", 3:14))
  Name.months<-c( "January", "February", "March", "April", "May", "June",
                  "July", "August", "September", "October", "November", "December")

  levels(df$Months)<-Name.months
  df$Months<-ordered(df$Months, levels = levels(df$Months))
  legend_title <- "AWC (%)"
  max<-100
  min<-0
  ggplot(data=df, aes(y = y, x = x)) +
    geom_raster(aes(fill= AWC))+
    coord_fixed(xlim = c(terra::ext(AWC_stack)[1], terra::ext(AWC_stack)[2]))+
    scale_fill_gradient(legend_title, low ="yellow", high = "blue", na.value = "transparent", limits=c(min, max))+
    theme(axis.title.x = element_blank(),
          axis.title.y = element_blank(),
          axis.text.x = element_blank(),
          axis.text.y = element_blank(),
          axis.ticks = element_blank(),
          legend.position = "right")+
    facet_wrap(~Months)+
    theme(strip.text.x = element_text(size = 12))+
    guides(color = guide_legend(override.aes = list(size=5)))+
    theme(legend.key.size = unit(1, "cm"),
          legend.text=element_text(size=12),
          legend.title = element_text(size = 14))+
    labs(fill = "AWC (%):")
}

