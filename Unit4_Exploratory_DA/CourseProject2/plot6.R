library(dplyr)
#get the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#filter, merge, group, filter and sum the emissions Baltimore
motor_balti_total<-SCC %>% filter(SCC.Level.One=="Mobile Sources") %>%
  filter(grepl("Vehicle",SCC.Level.Two) ) %>%
  merge(NEI,by="SCC") %>% filter(fips == "24510") %>%
  group_by(year) %>% summarise(total=sum(Emissions))
#filter, merge, group, filter and sum the emissions LA County
motor_LA_total<-SCC %>% filter(SCC.Level.One=="Mobile Sources") %>%
  filter(grepl("Vehicle",SCC.Level.Two) ) %>%
  merge(NEI,by="SCC") %>% filter(fips == "06037") %>%
  group_by(year) %>% summarise(total=sum(Emissions))
# plot it
plot(motor_LA_total$year,motor_LA_total$total,type="l",col='blue',xlab="Years",
     ylab="Total PM2.5 emissions",main="Total PM2.5 emission by Year in ",
     ylim=c(0,7500))
lines(motor_LA_total$year,motor_balti_total$total, col="red")
legend("left",legend=c("Los Angeles County","Baltimore City"),
       col=c("blue","red"),lty=1)
# Save it in a PNG file
dev.copy(png,"plot6.png", width=480, height=480)
dev.off()