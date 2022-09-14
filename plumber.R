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

#* @apiTitle 14C Calibration API

#* Calibrates a 14C Date Using OxCal
#* @param names A `character` vector giving the names of the date (e.g. laboratory codes).
#* @param dates A `numeric` vector giving the BP dates that should be calibrated.
#* @param errors A `numeric` vector giving the standard deviation that should be calibrated
#* @get /oxcal/calibrate
function(names, dates, errors){
  rdates <- oxcAAR::oxcalCalibrate(as.numeric(dates), as.numeric(errors), names)
  oxcAAR::get_sigma_ranges(rdates)
}

#* Plot a 14C Date Using OxCal
#* @serializer png
#* @get /oxcal/plot
function(names, dates, errors){
  rdates <- oxcAAR::oxcalCalibrate(as.numeric(dates), as.numeric(errors), names)
  plot(rdates)
}
