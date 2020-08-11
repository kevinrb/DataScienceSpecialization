library(dplyr)
#get the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#filter, group and sum the emissions
total_emi_balti<-NEI %>% filter(fips == "24510") %>% group_by(year) %>%
  summarise(total=sum(Emissions)) 
# plot it
with(total_emi_balti,plot(year,total,type="l",col='blue',xlab="Years",
                          ylab="Total PM2.5 emissions",
                          main="Total PM2.5 emission by Year in Baltimore City"))
# Save it in a PNG file
dev.copy(png,"plot2.png", width=480, height=480)
dev.off()