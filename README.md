
`voteogram` : U.S. House and Senate Voting Cartogram Generators

Produce voting cartograms in the style of 'ProPublica'.

Ref: <https://projects.propublica.org/represent/votes/115/senate/1/110>

### TODO

-   <strike>House cartogram generator</strike>
-   `htmlwidget` version
-   Colors for <strike>"vacant"</strike>, not voting" & "present"
-   Make a `voteogram` theme
-   <strike>Param bulletproofing (param checking, et al)</strike>
-   <strike>Add in ability to retrieve votes from ProPublica.</strike>

The following functions are implemented:

-   `house_carto`: Produce a House cartogram
-   `print.pprc`: Better default 'print' function for `roll_call()` (`pprc`) objects
-   `roll_call`: Get Voting Record for House or Senate By Number, Session & Roll Call Number
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
sen <- roll_call("senate", 115, 1, 110)
rep <- roll_call("house", 115, 1, 256)
```

``` r
sen
```

    ## 115th Congress / Session: 1 / Senate Roll Call: 110 / April  6, 2017
    ## 
    ## Neil M. Gorsuch, of Colorado, to be an Associate Justice of the Supreme Court of the United States
    ## 
    ## Result: Cloture Motion Agreed to

``` r
sen$votes
```

    ## # A tibble: 100 × 11
    ##    bioguide_id role_id        member_name  sort_name party state_abbrev display_state_abbrev district position
    ## *        <chr>   <int>              <chr>      <chr> <chr>        <chr>                <chr>    <chr>    <chr>
    ## 1      A000360     526   Lamar  Alexander  Alexander     R           TN                Tenn.        2      Yes
    ## 2      B001230     481      Tammy Baldwin    Baldwin     D           WI                 Wis.        1       No
    ## 3      B001261     498      John Barrasso   Barrasso     R           WY                 Wyo.        1      Yes
    ## 4      B001267     561     Michael Bennet     Bennet     D           CO                Colo.        1       No
    ## 5      B001277     535 Richard Blumenthal Blumenthal     D           CT                Conn.        2       No
    ## 6      B000575     547         Roy  Blunt      Blunt     R           MO                  Mo.        2      Yes
    ## 7      B001288     507       Cory  Booker     Booker     D           NJ                 N.J.        2       No
    ## 8      B001236     551      John  Boozman    Boozman     R           AR                 Ark.        1      Yes
    ## 9      B000944     480     Sherrod  Brown      Brown     D           OH                 Ohio        1       No
    ## 10     B001135     555    Richard M. Burr       Burr     R           NC                 N.C.        1      Yes
    ## # ... with 90 more rows, and 2 more variables: dw_nominate <lgl>, pp_id <chr>

``` r
rep
```

    ## 115th Congress / Session: 1 / House Roll Call: 256 / May  4, 2017
    ## 
    ## American Health Care Act
    ## 
    ## Result: Passed

``` r
rep$votes
```

    ## # A tibble: 435 × 11
    ##    bioguide_id role_id        member_name sort_name party state_abbrev display_state_abbrev district position
    ## *        <chr>   <int>              <chr>     <chr> <chr>        <chr>                <chr>    <int>    <chr>
    ## 1      A000374     274      Ralph Abraham   Abraham     R           LA                  La.        5      Yes
    ## 2      A000370     294        Alma  Adams     Adams     D           NC                 N.C.       12       No
    ## 3      A000055     224 Robert B. Aderholt  Aderholt     R           AL                 Ala.        4      Yes
    ## 4      A000371     427       Pete Aguilar   Aguilar     D           CA               Calif.       31       No
    ## 5      A000372     268         Rick Allen     Allen     R           GA                  Ga.       12      Yes
    ## 6      A000367     131       Justin Amash     Amash     R           MI                Mich.        3      Yes
    ## 7      A000369     388        Mark Amodei    Amodei     R           NV                 Nev.        2      Yes
    ## 8      A000375     320    Jodey Arrington Arrington     R           TX                Texas       19      Yes
    ## 9      B001291     590        Brian Babin     Babin     R           TX                Texas       36      Yes
    ## 10     B001298     206          Don Bacon     Bacon     R           NE                 Neb.        2      Yes
    ## # ... with 425 more rows, and 2 more variables: dw_nominate <lgl>, pp_id <chr>

``` r
senate_carto(sen) +
  labs(title="Senate Vote 110 - Invokes Cloture on Neil Gorsuch Nomination") +
  theme_ipsum_rc(grid="", plot_title_size = 24) +
  theme(axis.text=element_blank())
```

<img src="README_files/figure-markdown_github/sen-1.png" width="960" />

``` r
house_carto(rep) +
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

    ## [1] "Sun May  7 07:23:09 2017"

``` r
test_dir("tests/")
```

    ## testthat results ========================================================================================================
    ## OK: 0 SKIPPED: 0 FAILED: 0
    ## 
    ## DONE ===================================================================================================================
