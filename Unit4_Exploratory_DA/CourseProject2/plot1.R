library(dplyr)
#get the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#group and sum the emissions
total_emi<-NEI  %>% group_by(year) %>% summarise(total=sum(Emissions)) 
# plot it
with(total_emi,plot(year,total,type="l",col='blue',xlab="Years",
                    ylab="Total PM2.5 emissions",main="Total PM2.5 emission by Year"))
# Save it in a PNG file
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()