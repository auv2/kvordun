% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/reikna_hlutfall.R
\name{relative_percentile}
\alias{relative_percentile}
\title{Finn relative perecentile}
\usage{
relative_percentile(frequency)
}
\arguments{
\item{frequency}{tidni}
}
\value{
relative perecentile
}
\description{
Finn relative perecentile
}
\examples{
value <- c(0,0,1,1,1,2,2,3,3,4)
frequency <- as.data.frame(table(value))$Freq
}
