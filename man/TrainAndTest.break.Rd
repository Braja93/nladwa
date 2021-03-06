% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/TrainAndTest.break.R
\name{TrainAndTest.break}
\alias{TrainAndTest.break}
\title{Create a data.table for actual v fitted, with train and test sets}
\usage{
TrainAndTest.break(data, variable, date.index = "Week", to.break = NA,
  append = FALSE)
}
\arguments{
\item{data}{data.table.}

\item{variable}{Character. The variable name, of which to create training and test sets.}

\item{date.index}{Character. The date index of the lm(data = ?) variable.}

\item{to.break}{Defaults to NA which creates the training set as 2/3 of the data, the last 1/3 is the test. Set to a number between 0 and 1 to act as a percentage split, e.g. 0.5 - half the data is training. Or, enter a character in yyyy-mm-dd as the date to split.}

\item{append}{Defaults to FALSE - which returns date.index, and the training and test variables. TRUE returns data, with two new columns at the end - useful to overwrite the original table.}
}
\description{
Takes a lm object and outputs an actual vs fitted table.
}
\examples{
x <- data.table::fread(system.file("extdata", "lm.csv", package = "nladwa"))
x[, Week := excelDateToRDate(Week)]

x <- TrainAndTest.break(x, "TotalGrossLeads", to.break = "2015-04-06", append = TRUE)
# 06/04/2015

lm1 <- lm(TotalGrossLeads.Train ~ Search.Spend + Competitor.Spend, data = x)
lm1.trainAndTest <- lm.trainAndTest(lm.object = lm1, date.index = "Week")
print(lm1.trainAndTest)

lm.trainAndTest.ggplot(lm1.trainAndTest)
lm.trainAndTest.resid.ggplot(lm1.trainAndTest)

MAPE.trainAndTest(lm1.trainAndTest)
}
\keyword{actual}
\keyword{fitted}
\keyword{lm}
\keyword{test}
\keyword{train}
