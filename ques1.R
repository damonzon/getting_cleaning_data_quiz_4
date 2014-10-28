if (!file.exists("data")){
  dir.create("data")
}
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileURL,destfile="./data/community_survey.csv", method='curl')
dateDownloaded <- date()
acs <- read.table("./data/community_survey.csv",sep=',',header=TRUE)

answer <- strsplit(colnames(acs),"wgtp")[123]