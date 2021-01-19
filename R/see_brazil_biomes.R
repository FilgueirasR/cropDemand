#' Function to see the Brazilian biomes available tp use in download.terraclimate and loadROI function
#'
#' @description This fuction will show the biomes available in the package and how we can call each biome polygon.
#' @examples
#' \dontrun{
#' see_brazil_biomes()
#' }
#' @return The biomes information available to run the cropDemand package.
#' @export


see_brazil_biomes <- function(){
  a<- c("Caatinga = 1", "Cerrado = 2", "Pantanal = 3", "Pampa = 4", "Amazonia = 5", "Mata Atlantica = 6")
  print("Use the text format or the corresponding number:")
  return(a)
}
