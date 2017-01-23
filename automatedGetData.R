startdate <- list('20160101','20160201','20160301','20160401','20160501','20160601','20160701','20160801','20160901','20161001','20161101','20161201')
enddate <- list('20160131','20160229','20160331','20160430','20160531','20160630','20160731','20160831','20160930','20161031','20161130','20161231')
site <- list('sbs6','sbs9','net5','kijk','veronicatv','kijk-app','kijk-embed')
#ad filter 17118
for(i in 1:12){
  for(j in 1:6){
    filename <- GET(paste0("https://dax-rest.comscore.eu/v1/datadownloadreportitem.csv?itemid=13229&eventfilterid=17118&startdate=",startdate[i],"&enddate=",enddate[i],"&site=",site[j],"&client=sbs&user=mgilissen&password=xem46ULjh-z5g8Sp&nrofrows=100000&sortorder=1A"))
    filename <- content(filename, 'text')
    filename <- gsub(" ","",filename)
    filename <- gsub("url","",filename)
    filename <- gsub("\n","",filename)
    filename <- gsub("[|]","",filename)
    file <- filename
    #### Unzip *.gz files ####
    for(k in 1:length(file)){
      filename <- file[[k]]
      fname <- strsplit(strsplit(filename, "\\.")[[1]][3],"/")[[1]][[7]]
      temp <- paste("W:/R scripts/R_scripts_Konstantina/comscoreDataDownload/",fname,".tsv.gz",sep="") 
      download.file(filename, destfile = temp)
      unzipped <- gunzip(temp)
    }
  }
}

#credits for sbs
#GET("https://dax-rest.comscore.eu/v1/credits.pretty_xml?client=sbs&user=mgilissen&password=xem46ULjh-z5g8Sp")

