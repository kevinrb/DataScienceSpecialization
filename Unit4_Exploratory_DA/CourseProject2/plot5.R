library(dplyr)
#get the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#filter, merge, group, filter and sum the emissions
motor_balti_total<-SCC %>% filter(SCC.Level.One=="Mobile Sources") %>%
  filter(grepl("Vehicle",SCC.Level.Two) ) %>%
  merge(NEI,by="SCC") %>% filter(fips == "24510") %>%
  group_by(year) %>% summarise(total=sum(Emissions))
# plot it
with(motor_balti_total,plot(year,total,type="l",col='blue',xlab="Years",
                            ylab="Total PM2.5 emissions",
                            main="Total PM2.5 emission from motor vehicle sources by Year"))
# Save it in a PNG file
dev.copy(png,"plot5.png", width=480, height=480)
dev.off()