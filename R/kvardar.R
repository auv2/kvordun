#' IQsubScale
#'
#' @param variable Nafn a breytu sem a ad setja a undirkvarda IQ
#' @export
IQsubScale  <- function(variable) {
  value <- NA
  value[variable <=	0.0025] <-	1
  value[variable >	0.0025	& variable	  <=  	0.007] <-	2
  value[variable >	0.007	& variable	  <=  	0.015] <-	3
  value[variable >	0.015	& variable	  <=  	0.035] <-	4
  value[variable >	0.035	& variable	  <=  	0.07] <-	5
  value[variable >	0.07	& variable	  <=  	0.125] <-	6
  value[variable >	0.125	& variable	  <=  	0.205] <-	7
  value[variable >	0.205	& variable	  <=  	0.31] <-	8
  value[variable >	0.31	& variable	  <=  	0.435] <-	9
  value[variable >	0.435	& variable	  <=  	0.565] <-	10
  value[variable >	0.565	& variable	  <=  	0.69] <-	11
  value[variable >	0.69	& variable	  <=  	0.795] <-	12
  value[variable >	0.795	& variable	  <=  	0.875] <-	13
  value[variable >	0.875	& variable	  <=  	0.93] <-	14
  value[variable >	0.93	& variable	  <=  	0.965] <-	15
  value[variable >	0.965	& variable	  <=  	0.985] <-	16
  value[variable >	0.985	& variable	  <=  	0.993] <-	17
  value[variable >	0.993	& variable	  <=  	0.9975] <- 18
  value[variable >	0.9975	& variable	  <=  	1] <-	19
  return(value)
}

rod_kvarda <- c("Neðri mörk kvarða / Veikleiki miðað við jafnaldra",
                "Fyrir neðan meðaltal / Veikleiki miðað við jafnaldra",
                "Neðri hluti meðaltals / Innan eðlilegra marka",
                "Meðaltal / Innan eðlilegra marka",
                "Efri hluti meðaltals /Innan eðlilegra marka",
                "Fyrir ofan meðaltal / Styrkur miðað við jafnaldra",
                "Efri mörk kvarða / Styrkur miðað við jafnaldra")
