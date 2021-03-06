#' Plot residuals of a lm over time.
#'
#' Prints a ggplot of residuals from a model over time.
#' @param lm.object Output of lm function.
#' @param date.index Character. The column from the model source data that is the date variable.
#' @keywords residuals plot
#' @import data.table
#' @import ggplot2
#' @export

residPlot <- function(lm.object, date.index = "Week") {
  
  lm.data <- data.table(fortify(lm.object))
  data.source <- as.character(lm.object$call[3])
  data.cols <- names(lm.object$model)
  
  date.data <- get(data.source)[, c(date.index, data.cols), with = FALSE]
  date.data <- date.data[complete.cases(date.data), get(date.index)]
  lm.data[, `:=`(Week, date.data)]
  
  resid.plot <- ggplot(lm.data, aes_string(date.index, ".resid")) + 
    geom_point() + geom_hline(yintercept = 0) + geom_smooth(se = FALSE) + 
    labs(list(y = "Residuals"))
  
  print(resid.plot)
  
}


