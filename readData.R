library(data.table)
library(plyr)
library(ff)

temp = list.files(pattern="*.tsv")
allChannels2016ModelsCmsc <- list()
#allChannels2016ModelsCmsc_v1 <- NA
for(i in 1:length(temp)){
  #allChannels2016ModelsCmsc[[i]] <- fread(temp[i], header = FALSE,  stringsAsFactors = FALSE, na.strings="NA", blank.lines.skip=TRUE, fill=TRUE, sep = "\t")
  allChannels2016ModelsCmsc[[i]] <- read.table(temp[i], sep='\t', quote=NULL, comment='', header=FALSE, stringsAsFactors = FALSE)
}
allChannels2016ModelsCmsc_v1 <- rbind.fill(allChannels2016ModelsCmsc
                                           #,fill=TRUE
)


#create sums of every df and summarize them
sumSS <- 0
for(i in 1:length(allChannels2016ModelsCmsc)){
  allChannels2016ModelsCmsc[[i]]$V13 <- gsub('\\,','\\.',allChannels2016ModelsCmsc[[i]]$V13)
  allChannels2016ModelsCmsc[[i]]$V13 <- as.numeric(allChannels2016ModelsCmsc[[i]]$V13)
  temp1 <- sum(allChannels2016ModelsCmsc[[i]]$V13)
  sumSS <- sum(sumSS,temp1)
}
allChannels2016ModelsCmsc_v1$V13 <- as.numeric(gsub('\\,','\\.',allChannels2016ModelsCmsc_v1$V13))
sum(allChannels2016ModelsCmsc_v1$V13)

#remove ads
allChannels2016ModelsCmsc_v1 <- allChannels2016ModelsCmsc_v1[!(allChannels2016ModelsCmsc_v1$V7=='Advertentie'),]

library(dplyr)
#find nunl videos
simplified_total <- allChannels2016ModelsCmsc_v1[,-c(1,2)]
simplified_total <- group_by(simplified_total, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12) %>% summarize(V13=sum(V13))

colnames(simplified_total) <- c('sbs_station','sbs_partner','sbs_outlet','sbs_videotype','PrTitle','sko_pr','EpTitle','sbs_vpakey','nlz_cst_id','sko_cl','Streamstarts')
simplified_total <- simplified_total[!(simplified_total$PrTitle=='advertentie'),]
