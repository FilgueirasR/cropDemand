% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/WaterDemand.R
\name{waterDemand}
\alias{waterDemand}
\title{Function to generate the  water demand based in available water capacity of the soil}
\usage{
waterDemand(out_dir, ppt_stack, eto_stack, AWC)
}
\arguments{
\item{out_dir}{output directory where you want to save the variables}

\item{ppt_stack}{Stack of mean rainfall Rasterstack calculated in monthly_stack function}

\item{eto_stack}{Stack of mean evapotranspiration Rasterstack calculated in monthly_stack function}

\item{AWC}{The available water capacity (AWC) that the function will use in the calculations. The AWC value must be chosen according to the crop (root system depth) you want to obtain the water balance.}
}
\value{
Returns multiple SpatRaster object as output (explained in description).
}
\description{
This function will calculate the water balance parameters based in the available water capacity informed (AWC).
The output water balance parameters for this function are:

   \enumerate{
     \item ARM - storage;
     \item ALT - alteration;
     \item ETR - actual evapotranspiration;
     \item DEF - deficit;
     \item EXC - excess;
     \item REP - replacement;
     \item RET - withdrawal;
     \item AWC_arm - percentage of storage compared to AWC;
}
}
\examples{
\dontrun{
cwd<- waterDemand(out_dir = "G:/My computer/test/CropWaterDemand",
                  ppt_stack = rainfall_image, eto_stack = eto_image, AWC = 100)
}
}
