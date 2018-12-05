#If the dependency library is not constructed, compile set_up.R first
#In order to set up the environment, internet connection is required

if(!require("rstudioapi")){
  install.packages("rstudioapi")
  library("rstudioapi")
}

#Set Directory
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

#Working directory of libraries
wd_lib = paste(wd,"/libs", sep = "")

suppressWarnings({
  install.packages("rJava", lib = wd_lib)
  install.packages("webshot", lib = wd_lib)
  install.packages("tesseract", lib = wd_lib)
  install.packages("NLP", lib = wd_lib)
  install.packages("openNLP", lib = wd_lib)
  install.packages("RWeka", lib = wd_lib)
  install.packages("rappdirs", lib = wd_lib)
  install.packages("jsonlite", lib = wd_lib)
  install.packages("callr", lib = wd_lib)
  install.packages("ps", lib = wd_lib)
})


#...