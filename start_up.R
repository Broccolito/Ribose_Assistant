#Importing needed packages
#Sys.setenv(JAVA_HOME="C:/Program Files/Java/jdk-11.0.1/")
#library(rJava, lib.loc = wd)
tryCatch({
  library(rJava, lib.loc = wd_lib)
}, error = function(e){
  Sys.setenv(JAVA_HOME="C:/Program Files/Java/jdk-11.0.1/")
  tryCatch({
    library(rJava, lib.loc = wd_lib)
  }, error = function(e){
    Sys.setenv(JAVA_HOME="C:/Program Files/Java/jdk-10.0.1/")
    tryCatch({
      library(rJava, lib.loc = wd_lib)
    }, error = function(e){
      stop("In order to run the program, Java installation is needed...")
    })
  })
})
library(jsonlite, lib.loc = wd_lib)
library(ps, lib.loc = wd_lib)
library(callr, lib.loc = wd_lib)
library(webshot, lib.loc = wd_lib) #Screenshot Website
library(rappdirs, lib.loc = wd_lib) #tesseract required package
library(tesseract, lib.loc = wd_lib) #Open source OCR
library(NLP, lib.loc = wd_lib)  #Natual Language Processing
library(openNLP, lib.loc = wd_lib) #NLP package
library(RWeka, lib.loc = wd_lib) #NLP package

#Import libraries await to be set up
library(magick) 
#library(imager)



#Set up webshot package
suppressMessages({
  install_phantomjs()
})

source("NLP_analysis.R")
source("file_operation.R")
