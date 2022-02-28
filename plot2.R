# Question to answer: Have total emissions from PM2.5 decreased
# in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 

# Use the base plotting system to make a plot answering this question.

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

# get the Baltimore only data, then sum over each year
baltimoreNEI <- subset(NEI, NEI$fips == "24510")
totalEmissions <- tapply(baltimoreNEI$Emissions, baltimoreNEI$year, sum)

# make the plot

while(dev.cur() > 1) { dev.off() }
x11()
plot(as.numeric(names(totalEmissions)), totalEmissions, pch = 19, 
     main = "Sum of PM2.5 Emissions in Baltimore",
     xlab = "Year", ylab = "PM2.5 Emissions (Tons)")
abline(lm(totalEmissions ~ as.numeric(names(totalEmissions))), lwd = 3, col = "blue")
dev.copy(png, file = "plot2.png", height = 480, width = 480, units = "px")
dev.off() # writes the file, but leaves the screen device open