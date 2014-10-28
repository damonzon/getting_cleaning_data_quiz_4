if (!file.exists("data")){
  dir.create("data")
}
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv "
download.file(fileURL,destfile="./data/gdp.csv", method='curl')
dateDownloaded <- date()
gdp <- read.csv("./data/gdp.csv",skip=5,header=FALSE,nrows=190)

colnames(gdp)[1]="CountryCode"
colnames(gdp)[5]="gdp"
gdp$gdp <- as.numeric(gsub(",","",gdp$gdp))

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv "
download.file(fileURL,destfile="./data/education.csv", method='curl')
dateDownloaded <- date()
education <- read.csv("./data/education.csv",header=TRUE)

answer2 <- mean(gdp$gdp)

answer3 <- grep("^United",gdp$V4)

merged <- merge(gdp,education,by="CountryCode")
has_fiscal_year_end <- merged[grep("^Fiscal year end",merged$Special.Notes),]
answer4 <- length(grep("June",has_fiscal_year_end$Special.Notes))

library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn) 
library(lubridate)
datelist <- ymd(sampleTimes)
answer5a <- length(which(year(datelist)==2012))
answer5b <- length(which(year(datelist)==2012 & weekdays(datelist)=="Monday"))