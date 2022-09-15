#
# This is a Plumber API. In RStudio 1.2 or newer you can run the API by
# clicking the 'Run API' button above.
#
# In RStudio 1.1 or older, see the Plumber documentation for details
# on running the API.
#
# Find out more about building APIs with Plumber here:
#
#    https://www.rplumber.io/
#

library(plumber)

oxcAAR::setOxcalExecutablePath("OxCal/bin/OxCalLinux")

memoise_oxcal_calibrate <- memoise::memoise(oxcAAR::oxcalCalibrate)

#* @apiTitle 14C Calibration API

#* Calibrates a 14C Date Using OxCal
#* @param names A `character` vector giving the names of the date (e.g. laboratory codes).
#* @param dates A `numeric` vector giving the BP dates that should be calibrated.
#* @param errors A `numeric` vector giving the standard deviation that should be calibrated
#* @serializer print
#* @get /oxcal/calibrate
function(names, dates, errors){
  rdates <- memoise_oxcal_calibrate(as.numeric(dates), as.numeric(errors), names)
  rdates
}

#* Calibrates a 14C Date Using OxCal
#* @param names A `character` vector giving the names of the date (e.g. laboratory codes).
#* @param dates A `numeric` vector giving the BP dates that should be calibrated.
#* @param errors A `numeric` vector giving the standard deviation that should be calibrated
#* @get /oxcal/calibrate/ranges
function(names, dates, errors){
  rdates <- memoise_oxcal_calibrate(as.numeric(dates), as.numeric(errors), names)
  oxcAAR::get_sigma_ranges(rdates)
}

#* Plot a 14C Date Using OxCal
#* @serializer png
#* @get /oxcal/calibrate/plot
function(names, dates, errors){
  rdates <- memoise_oxcal_calibrate(as.numeric(dates), as.numeric(errors), names)
  plot(rdates)
}
