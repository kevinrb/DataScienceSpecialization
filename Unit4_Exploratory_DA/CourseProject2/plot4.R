library(dplyr)
#get the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#filter, merge, group and sum the emissions
total_coal<-SCC %>%filter(grepl("Comb",EI.Sector)) %>%filter(grepl("Coal",EI.Sector)) %>%
  merge(NEI,by="SCC") %>% group_by(year) %>% summarise(total=sum(Emissions)) 
# plot it
with(total_coal,plot(year,total,type="l",col='blue',xlab="Years",
                     ylab="Total PM2.5 emissions",
                     main="Total PM2.5 emission from coal combustion-related sources by Year"))
# Save it in a PNG file
dev.copy(png,"plot4.png", width=480, height=480)
dev.off()