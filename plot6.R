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


