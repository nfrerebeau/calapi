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
#* @apiLicense list(name = "GNU-GPL 3.0", url = "https://www.gnu.org/licenses/gpl-3.0.en.html")
#* @apiVersion 0.0.0.9000

#* Calibrates a 14C Date Using OxCal
#* @param names:[str] The names of the date (e.g. laboratory codes).
#* @param dates:[dbl] The BP dates that should be calibrated.
#* @param errors:[dbl] The standard deviation that should be calibrated.
#* @serializer print
#* @get /oxcal/calibrate
function(names, dates, errors){
  rdates <- memoise_oxcal_calibrate(as.numeric(dates), as.numeric(errors), names)
  rdates
}

#* Calibrates a 14C Date Using OxCal
#* @param names:[str] The names of the date (e.g. laboratory codes).
#* @param dates:[dbl] The BP dates that should be calibrated.
#* @param errors:[dbl] The standard deviation that should be calibrated.
#* @get /oxcal/calibrate/ranges
function(names, dates, errors){
  rdates <- memoise_oxcal_calibrate(as.numeric(dates), as.numeric(errors), names)
  oxcAAR::get_sigma_ranges(rdates)
}

#* Plot a 14C Date Using OxCal
#* @param names:[str] The names of the date (e.g. laboratory codes).
#* @param dates:[dbl] The BP dates that should be calibrated.
#* @param errors:[dbl] The standard deviation that should be calibrated.
#* @serializer png
#* @get /oxcal/calibrate/plot
function(names, dates, errors){
  rdates <- memoise_oxcal_calibrate(as.numeric(dates), as.numeric(errors), names)
  plot(rdates)
}
