# Question to Answer: How have emissions from motor vehicle sources
# changed from 1999–2008 in Baltimore City?

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
motorVehicles <- SCC[grep("[Mm]otor", SCC$SCC.Level.Three), ]
SCCCodes <- unique(motorVehicles$SCC)

# get the total emissions for each year

library(dplyr)
baltMotorVehicles <- filter(baltNEI, SCC %in% SCCCodes)
totalEmissions <- tapply(baltMotorVehicles$Emissions, baltMotorVehicles$year, sum)

# make the plot

while(dev.cur() > 1) { dev.off() }
x11()
plot(as.numeric(names(totalEmissions)), totalEmissions, pch = 19, 
     main = "Sum of PM2.5 Emissions from Motor Vehicles in Baltimore",
     xlab = "Year", ylab = "PM2.5 Emissions (Tons)")
abline(lm(totalEmissions ~ as.numeric(names(totalEmissions))), lwd = 3, col = "blue")
dev.copy(png, file = "plot5.png", height = 480, width = 480, units = "px")
dev.off() # writes the file, but leaves the screen device open
