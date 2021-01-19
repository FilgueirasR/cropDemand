#' Function to see the Brazilian states available to use in download.terraclimate and loadROI function
#'
#' @description This function will show the Brazilian state available in the package and how we can call each state polygon.
#' @examples
#' \dontrun{
#' see_brazil_states()
#' }
#' @return The Brazilian state information available in the package to run the cropZoning package.
#' @export


see_brazil_states <- function(){
  a<- c("Acre = 1","Alagoas = 2", "Amapa = 3", "Amazonas = 4", "Bahia = 5", "Ceara = 6",
        "Distrito Federal = 7", "Espirito Santo = 8", "Goias = 9", "Maranhao = 10",
        "Mato Grosso = 11", "Mato Grosso do Sul = 12", "Minas Gerais = 13", "Parana = 14",
        "Paraiba = 15", "Para = 16", "Pernambuco = 17", "Piaui = 18", "Rio Grande do Norte = 19",
        "Rio Grande do Sul = 20", " Rio de Janeiro = 21", "Rondonia = 22", "Roraima = 23", "Santa Catarina = 24",
        "Sergipe = 25", "Sao Paulo = 26", "Tocantins = 27")
  print("Use the text format or the corresponding number:")
  return(a)
}
