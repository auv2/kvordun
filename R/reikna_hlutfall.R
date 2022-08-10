#' Kvordun
#' Dæmi frá Kolen og Brennan (2004) bls 40
#' value <- c(0,0,1,1,1,2,2,3,3,4)

z_score <- function(value) {
  z <- (value - mean(value, na.rm = T)) / sd(value, na.rm = T)
  return(z)
}

#' Title
#'
#' @param value
#' @param kvardi  bil sem kvardinn er a t.d. 0:10
#' @param punktar fjoldi punkkta a kvarda sem a ad taka saman, ef punktar = 1
#' tha er 1 punktur a moti punkti, ef punktar = 2 tha eru tveir punktar teknir
#' saman i einn t.d. 1, 2, 3, 4, 5, 6 yrdi 1-2, 2-3, 3-4, 5-6
#'
#' @return Skilar gagnaramma med tidni, hlutfalli, safntidni, maelitolum og
#' lysingu
#'
#' @import dplyr
#' @import equate
#' @importFrom fill, tidyr
#' @export
#'
#' @examples
#'
reikna_hlutfall <- function(value, kvardi = 0:10, punktar = 1) {

  value <- as.numeric(value)

  ## Stilli upp stærð kvarða

  if (max(kvardi, na.rm = T) < max(value, na.rm = T)) {
    ## Ef hæsta gildi er stærra en kvraði
    freq_table <- equate::freqtab(value,
                                  min(kvardi, na.rm = T):max(value, na.rm = T))
  } else {
    ## Kvarði eins og hann er skilgreindur
    freq_table <- equate::freqtab(value, kvardi)
  }

  ## Nota loglinear smoothing til að draga úr staðbunidinni mælivillu
  #plot(freq_table)
  freq_table <- equate::presmoothing(freq_table, smoothmethod = "loglinear")
  #plot(freq_table)
  print(summary(freq_table), digits = 3)


  df <- as.data.frame(freq_table)
  colnames(df) <- c("value","Freq")
  df$Freq <- round(df$Freq)


  ## Fækka punktum
  fj.pnk <- data.frame(
    "value" = seq(from = min(kvardi),to = max(kvardi), by = punktar),
    "group" = seq(from = min(kvardi),to = max(kvardi), by = punktar))

  df <- left_join(df, fj.pnk) %>%
    tidyr::fill(group) %>%
    group_by(group) %>%
    summarise(
      group = paste0(min(value),"-",max(value)),
      centrality  = round(weighted.mean(value, Freq),2),
      value = max(value),
      centrality  = value - centrality ,
      Freq = sum(Freq)
    ) %>%
    relocate(value)

  # Finna tíðni og uppsafnaða hluttíðni
  df$cum_freq = cumsum(df$Freq)
  df$p = df$Freq / sum(df$Freq)
  df$cum_p = cumsum(df$Freq) / sum(df$Freq)
  df$p_rank = (ifelse(is.na(lag(df$cum_freq)), 0, lag(df$cum_freq)) + .5 * df$Freq) / (sum(df$Freq)) * 100


  df$p_rank = ifelse(is.na(df$p_rank), 0, df$p_rank)
  df$z <- (df$value - mean(value, na.rm = T)) / sd(value, na.rm = T)
  df$maelitala <- IQsubScale(df$cum_p)

  df <- dplyr::mutate(
    df,
    lysing = dplyr::case_when(
      maelitala < 4 ~ "Neðri mörk kvarða / Veikleiki miðað við jafnaldra",
      maelitala > 3 &  maelitala < 7 ~ "Fyrir neðan meðaltal / Veikleiki miðað við jafnaldra",
      maelitala > 6 &  maelitala < 9 ~ "Neðri hluti meðaltals / Innan eðlilegra marka",
      maelitala > 8 &  maelitala < 12 ~ "Meðaltal / Innan eðlilegra marka",
      maelitala > 11 &  maelitala < 14 ~ "Efri hluti meðaltals /Innan eðlilegra marka",
      maelitala > 13 &  maelitala < 17 ~ "Fyrir ofan meðaltal / Styrkur miðað við jafnaldra",
      maelitala > 16 ~ "Efri mörk kvarða / Styrkur miðað við jafnaldra"

    )
  )


  return(df)
}
