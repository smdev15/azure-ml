## Only one of the following two lines should be used
## If running in ML Studio use the first line with maml.mapInputPort().
## If in RStudio used the second line with read.csv()
mammalsdata <- maml.mapInputPort(1)
#mammalsdata  <- read.csv("../../data/mammals.csv", header = TRUE, stringsAsFactors = FALSE)

## Get rid of any rows with NA values
mammalsdata <- na.omit(mammalsdata)  

# The log transformation function
log.transform <- function(invec) {
  ## Function for the transformation which is the log
  ## of the input value times a multiplier
  
  warningmessages <- c("ERROR: Non-numeric argument encountered in function log.transform",
                       "ERROR: Arguments to function log.transform must be greater than zero")
  
  ## Check the input arguments.
  if(!is.numeric(invec)) {warning(warningmessages[1]); return(NA)}  
  if(any(invec < 0.0)) {warning(warningmessages[2]); return(NA)}

  ## Wrap the transformation in tryCatch.
  ## If there is an exception, print the warningmessage to
  ## standard error and return NA.
  tryCatch(log(invec), 
           error = function(e){warning(e); NA})
}

## Apply the transformation function to the 2 columns
## of the dataframe with production data. 
mammalsdata[, 2:3] <- Map(log.transform, mammalsdata[, 2:3])

## Get rid of any rows with NA values
mammalsdata <- na.omit(mammalsdata)  
str(mammalsdata) # Check the results

plot(mammalsdata$body, mammalsdata$brain)
## The following line should be executed only when running in
## Azure ML Studio. 
maml.mapOutputPort('mammalsdata') 

