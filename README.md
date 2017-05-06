
`voteogram` : U.S. House and Senate Voting Cartogram Generators

Produce voting cartograms in the style of 'ProPublica'.

Ref: <https://projects.propublica.org/represent/votes/115/senate/1/110>

### TODO

-   House cartogram generator
-   `htmlwidget` version
-   Colors for "not voting" & "present"
-   Carto theme
-   Ability to retrieve votes from ProPublica.

The following functions are implemented:

-   `senate_carto`: Produce a Senate cartogram

### Installation

``` r
devtools::install_github("hrbrmstr/voteogram")
```

### Usage

``` r
library(voteogram)
library(jsonlite)
library(hrbrthemes)
library(tidyverse)

# current verison
packageVersion("voteogram")
```

    ## [1] '0.1.0'

``` r
sen_df <- fromJSON("https://pp-projects-static.s3.amazonaws.com/congress/assets/senate_115_1_110.json")$votes

rep_df <- fromJSON("https://pp-projects-static.s3.amazonaws.com/congress/assets/house_115_1_256.json")$votes
```

``` r
select(sen_df, state_abbrev, district, party, position) %>% 
  senate_carto() +
  labs(title="Senate Vote 110 - Invokes Cloture on Neil Gorsuch Nomination") +
  theme_ipsum_rc(grid="", plot_title_size = 24) +
  theme(axis.text=element_blank())
```

<img src="README_files/figure-markdown_github/sen-1.png" width="960" />

``` r
select(rep_df, state_abbrev, district, party, position) %>% 
  house_carto() +
  labs(title="House Vote 256 - Passes American Health Care Act,\nRepealing Obamacare") +
  theme_ipsum_rc(grid="", plot_title_size = 24) +
  theme(axis.text=element_blank())
```

<img src="README_files/figure-markdown_github/rep-1.png" width="960" />

### Test Results

``` r
library(voteogram)
library(testthat)

date()
```

    ## [1] "Sat May  6 18:26:23 2017"

``` r
test_dir("tests/")
```

    ## testthat results ========================================================================================================
    ## OK: 0 SKIPPED: 0 FAILED: 0
    ## 
    ## DONE ===================================================================================================================
