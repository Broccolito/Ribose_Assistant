#library(webshot, lib.loc = wd_lib) #Screenshot Website

setwd(wd)

#For every start up, remove all the screenshots
getinto("shots")
file.remove(list.files())
setwd(wd)

#Test internet connection
is_connected = function(){
  url = "http://www.google.com"
  # test the http capabilities of the current R build
  if (!capabilities(what = "http/ftp")) return(FALSE)
  # test connection by trying to read first line of url
  test <- try(suppressWarnings(readLines(url, n = 1)), silent = TRUE)
  # return FALSE if test inherits 'try-error' class
  !inherits(test, "try-error")
}

if(!is_connected()){
  stop("Internet connection is required for this function...")
}

save_shot = function(URL = "www.facebook.com"){
  if(!grepl("http", URL)){
    URL = paste("https://" ,URL, sep = "")
  }
  getinto("shots")
  filename_index = as.character(length(list.files()) + 1)
  filename = paste(filename_index, ".png", sep = "")
  
  try_with_time_limit <- function(expr,
                                  cpu = Inf,
                                  elapsed = Inf){
    y <- try({setTimeLimit(cpu, elapsed); expr}, silent = TRUE) 
    if(inherits(y, "try-error")){
      return(NULL)
    }else{
      return(y)
    }
  }
  tryCatch({
    try_with_time_limit({
      webshot(url = URL, file = filename)
    }, 15) 
    # Set 15 seconds timeout. Any requests taking longer than 15 will be considered timeout
  }, finally = {
    setwd(wd)
  })
  #Make a global variable of the name of the last file saved
  last_shot <<- filename
}

#Test
#save_shot()