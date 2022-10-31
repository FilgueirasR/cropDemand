#cropDemand 1.0.2

## html bugs fix - reported by CRAN

Found the following HTML validation problems:
    download_terraclimate.html:20:1 (download_terraclimate.Rd:6): Warning: <img> attribute "width" has invalid value "auto"
    download_terraclimate.html:20:1 (download_terraclimate.Rd:6): Warning: <img> proprietary attribute "logo"
    eto_calibration.html:20:1 (eto_calibration.Rd:6): Warning: <img> attribute "width" has invalid value "auto"
    eto_calibration.html:20:1 (eto_calibration.Rd:6): Warning: <img> proprietary attribute "logo"
    loadROI.html:20:1 (loadROI.Rd:6): Warning: <img> attribute "width" has invalid value "auto"
    loadROI.html:20:1 (loadROI.Rd:6): Warning: <img> proprietary attribute "logo"
    monthly_stack.html:20:1 (monthly_stack.Rd:6): Warning: <img> attribute "width" has invalid value "auto"
    monthly_stack.html:20:1 (monthly_stack.Rd:6): Warning: <img> proprietary attribute "logo"
    plot_AWC.html:20:1 (plot_AWC.Rd:6): Warning: <img> attribute "width" has invalid value "auto"
    plot_AWC.html:20:1 (plot_AWC.Rd:6): Warning: <img> proprietary attribute "logo"
    ppt_calibration.html:20:1 (ppt_calibration.Rd:6): Warning: <img> attribute "width" has invalid value "auto"
    ppt_calibration.html:20:1 (ppt_calibration.Rd:6): Warning: <img> proprietary attribute "logo"
    see_brazil_biomes.html:20:1 (see_brazil_biomes.Rd:6): Warning: <img> attribute "width" has invalid value "auto"
    see_brazil_biomes.html:20:1 (see_brazil_biomes.Rd:6): Warning: <img> proprietary attribute "logo"
    see_brazil_states.html:20:1 (see_brazil_states.Rd:6): Warning: <img> attribute "width" has invalid value "auto"
    see_brazil_states.html:20:1 (see_brazil_states.Rd:6): Warning: <img> proprietary attribute "logo"
    waterDemand.html:20:1 (waterDemand.Rd:6): Warning: <img> attribute "width" has invalid value "auto"
    waterDemand.html:20:1 (waterDemand.Rd:6): Warning: <img> proprietary attribute "logo"


#cropDemand 1.0.1

## Minor improvements and fixes 

*`download_terraclimate` no more error when downloading many years. it was include a variable dir_out in this function
* general improvement in description of the functions

# cropDemand 1.0.0

* Added a `NEWS.md` file to track changes to the package.
