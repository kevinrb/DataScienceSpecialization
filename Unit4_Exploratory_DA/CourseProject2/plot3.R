library(dplyr)
library(ggplot2)
#get the data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#filter, group and sum the emissions
total_emi_balti_type<-NEI %>% filter(fips == "24510") %>%
  group_by(type,year) %>% summarise(total=sum(Emissions)) 

# plot it with ggplot2
qplot(year,total,data=total_emi_balti_type,facets=.~type,geom="line",xlab="Years",
      ylab="Total PM2.5 emissions",
      main="Total PM2.5 emission by Year and Type in Baltimore City")
# Save it in a PNG file
dev.copy(png,"plot3.png", width=480, height=480)
dev.off()