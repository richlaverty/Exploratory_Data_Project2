# Question to Answer: Compare emissions from motor vehicle sources
# in Baltimore City with emissions from motor vehicle sources in 
# Los Angeles County, California (fips == "06037").
# Which city has seen greater changes over time in motor vehicle emissions?

# clean up the workspace

rm(list = ls())

# set the working directory and download the data, if necessary

setwd("/home/rich/Documents/programs/data_science/04_Exploratory_Data_Analysis/Exploratory_Data_Project2")

# import the data

if(file.exists("./data/summarySCC_PM25.rds"))
{
  NEI <- readRDS("./data/summarySCC_PM25.rds")
}
if(file.exists("./data/Source_Classification_Code.rds"))
{
  SCC <- readRDS("./data/Source_Classification_Code.rds")
}

# get the Baltimore only data
baltNEI <- subset(NEI, NEI$fips == "24510")
laNEI <- subset(NEI, NEI$fips == "06037")
motorVehicles <- SCC[grep("[Mm]otor", SCC$SCC.Level.Three), ]
SCCCodes <- unique(motorVehicles$SCC)

# get the total emissions for each year

library(dplyr)
baltMotorVehicles <- filter(baltNEI, SCC %in% SCCCodes)
laMotorVehicles <- filter(laNEI, SCC %in% SCCCodes)
totalEmissionsBalt <- tapply(baltMotorVehicles$Emissions, baltMotorVehicles$year, sum)
totalEmissionsLA <- tapply(laMotorVehicles$Emissions, laMotorVehicles$year, sum)

# make the plot

while(dev.cur() > 1) { dev.off() }
x11()
plot(as.numeric(names(totalEmissionsBalt)), totalEmissionsBalt, 
     pch = 19, col = "blue", xlim = c(1998, 2009), ylim = c(0, 90),
     main = "Sum of PM2.5 Emissions from Motor Vehicles in Baltimore and LA",
     xlab = "Year", ylab = "PM2.5 Emissions (Tons)")
abline(lm(totalEmissionsBalt ~ as.numeric(names(totalEmissionsBalt))), lwd = 3,
       col = "blue")
points(as.numeric(names(totalEmissionsLA)), totalEmissionsLA,
       pch = 19, col = "red")
abline(lm(totalEmissionsLA ~ as.numeric(names(totalEmissionsLA))), lwd = 3, 
       col = "red")
legend(1998, 50, legend=c("Los Angeles", "Baltimore"),
       col=c("red", "blue"), lty=1, cex=0.8)
dev.copy(png, file = "plot6.png", height = 480, width = 480, units = "px")
dev.off() # writes the file, but leaves the screen device open
