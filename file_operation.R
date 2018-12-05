#File operation functions
note = function(string){
  cat("")
}
getinto = function(filename){
  if(!dir.exists(filename)){
    print("The file is not found...")
    stop("Wrong directory...")
  }else{
    setwd(paste(getwd(),"/",filename,sep = ""))
    # print("The new directory is:")
    # getwd()
  }
}
getback = function(){
  wd = strsplit(getwd(),"/")
  wd = wd[[1]]
  if(length(wd)>1){
    newwd = wd[1:length(wd)-1]
    temwd = ""
    for(i in 1:length(newwd)){
      temwd = paste(temwd,newwd[i],sep = "/")
    }
    temwd = substring(temwd,2,nchar(temwd))
    setwd(temwd)
  }else{
    print("The current directory is already the mother directory...")
    warning("Unable to get back to previous directory...")
  }
  # print("The current directory is:")
  # getwd()
}

show_image = function(pic_mat){
  if(!any(rownames(installed.packages()) == "EBImage")){
    source("https://bioconductor.org/biocLite.R")
    biocLite("EBImage")
  }
  library(EBImage)
  if(length(dim(pic_mat)) == 2){
    picture = Image(data = pic_mat,
                    dim = dim(pic_mat),
                    colormode = "Grayscale")
  }else if(length(dim(pic_mat)) == 3){
    if(all(dim(pic_mat)[1] == dim(pic_mat)[2],
           dim(pic_mat)[3] == 3)){
      picture = Image(data = pic_mat,
                      dim = dim(pic_mat),
                      colormode = "Color")
    }else if(all(dim(pic_mat)[2] == dim(pic_mat)[3],
                 dim(pic_mat)[3] != 3)){
      picture = Image(data = aperm(pic_mat,c(2,3,1)),
                      dim = dim(aperm(pic_mat,c(2,3,1))),
                      colormode = "Grayscale")
    }
  }
  display(picture)
  return(picture)
}
