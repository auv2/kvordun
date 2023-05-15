
<!-- README.md is generated from README.Rmd. Please edit that file -->

# kvordun

<!-- badges: start -->
<!-- badges: end -->

The goal of kvordun is to …

## Installation

You can install the development version of kvordun from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("auv2/kvordun")
```

## Dæmi

![](img/kolen_brennan_bls40.png)

“In this table, x refers to test score and f (x) to the proportion of examinees earning the score x. For example, the proportion of examinees earning a score of 0 is .20. F(x) is the cumulative proportion at or below x. For example, the proportion of examinees scoring 3 or below is .9. P(x) refers to the percentile rank, and for an integer score it equals the percentage of examinees below x plus 1/2 the percentage of examinees at x—i.e., for integer score x, P(x) = 100[F(x − 1) + f (x)/2].” (Kolen and Brennan, 2014, p. 38-39)

Kolen, M. J., & Brennan, R. L. (2014). Test Equating, Scaling, and Linking. Springer New York. https://doi.org/10.1007/978-1-4939-0317-7
``` r
library(kvordun)
value <- c(0,0,1,1,1,2,2,3,3,4)
reikna_hlutfall(value, kvardi = 0:4, punktar = 1)
#>       mean   sd  skew kurt min max  n
#> total  1.7 1.34 0.241  1.6   0   4 10
#> Joining, by = "value"
#> # A tibble: 5 x 11
#>   value group centrality  Freq cum_freq     p cum_p p_rank      z maelitala
#>   <dbl> <chr>      <dbl> <dbl>    <dbl> <dbl> <dbl>  <dbl>  <dbl>     <dbl>
#> 1     0 0-0            0     2        2   0.2   0.2     10 -1.27          7
#> 2     1 1-1            0     3        5   0.3   0.5     35 -0.523        10
#> 3     2 2-2            0     2        7   0.2   0.7     60  0.224        12
#> 4     3 3-3            0     2        9   0.2   0.9     80  0.972        14
#> 5     4 4-4            0     1       10   0.1   1       95  1.72         19
#> # ... with 1 more variable: lysing <chr>
```

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date. `devtools::build_readme()` is handy for this. You could also
use GitHub Actions to re-render `README.Rmd` every time you push. An
example workflow can be found here:
<https://github.com/r-lib/actions/tree/v1/examples>.
