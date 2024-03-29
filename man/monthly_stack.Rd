% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/monthly_stack.R
\name{monthly_stack}
\alias{monthly_stack}
\title{Function to calculate the mean monthly rainfall/reference evapotranspiration to generate the crop water demand}
\usage{
monthly_stack(stack, start_date, end_date)
}
\arguments{
\item{stack}{Stack of mean rainfall/reference evapotranspiration Rasterstack}

\item{start_date}{Date that start the investigation, should be in the following format (2000-01-01 /Year-Month-Day)}

\item{end_date}{Date that end the investigation, should be in the following format (2017-12-31 /Year-Month-Day)}
}
\value{
Returns a stack with a monthly mean air temperature from a period of time
}
\description{
This function will calculate the mean monthly air temperature based on the period of time selected (start_date and end_date).
}
\examples{
\dontrun{
start_date <- c('2000-01-01')
end_date <- c('2017-12-01')
monthly_rainfall <- monthly_stack(stack = rainfall_stack,
                                  start_date = start_date, end_date = end_date)
}
}
