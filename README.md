
<!-- README.md is generated from README.Rmd. Please edit that file -->

# calapi

<!-- badges: start -->
<!-- badges: end -->

An API for <sup>14</sup>C calibration powered by
[**plumber**](https://www.rplumber.io).

## Usage

``` r
library(plumber)

## Translate R code into a Plumber API
root <- pr("plumber.R")

## Bring the API to life
root |> pr_run(port = 8000)
```

The API should be running on your computer on port 8000. You should be
able to open
<http://localhost:8000/oxcal/calibrate?dates=5000&errors=25&names=KIA-12345>
or
<http://localhost:8000/oxcal/plot?dates=5000&errors=25&names=KIA-12345>
in a web browser to test the API endpoints.
