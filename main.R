#Author: Wanjun Gu
#Email: Wag001@ucsd.edu


#Ribose Assistant
#System Requirement:
#Java/jdk-11.0.1 installed

#Workplace and garbage collection
rm(list = ls())
gc()

#Detach all external packages
detachAllPackages <- function() {
  basic.packages <- c("package:stats",
                      "package:graphics",
                      "package:grDevices",
                      "package:utils",
                      "package:datasets",
                      "package:methods",
                      "package:base")
  package.list <- search()[ifelse(unlist(gregexpr("package:",search()))==1,TRUE,FALSE)]
  package.list <- setdiff(package.list,basic.packages)
  if (length(package.list)>0)  for (package in package.list){
    detach(package, character.only=TRUE)
  } 
}
try({
  detachAllPackages()
}, silent = TRUE)

#Set Directory
if(!require("rstudioapi")){
  install.packages("rstudioapi")
  library("rstudioapi")
}
get_directory = function(){
  args <- commandArgs(trailingOnly = FALSE)
  file <- "--file="
  rstudio <- "RStudio"
  
  match <- grep(rstudio, args)
  if(length(match) > 0){
    return(dirname(rstudioapi::getSourceEditorContext()$path))
  }else{
    match <- grep(file, args)
    if (length(match) > 0) {
      return(dirname(normalizePath(sub(file, "", args[match]))))
    }else{
      return(dirname(normalizePath(sys.frames()[[1]]$ofile)))
    }
  }
}

wd = get_directory()
setwd(wd)

#Working directory of libraries
wd_lib = paste(wd,"/libs", sep = "")

#Initializing Workspace
source("start_up.R")
source("file_operation.R")
source("NLP_analysis.R")
source("web_shot.R")


