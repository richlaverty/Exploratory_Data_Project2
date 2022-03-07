# Question to answer: Across the United States, how have emissions 
# from coal combustion-related sources changed from 1999–2008?

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

# get the relevant data rows
combustion <- SCC[grep("[Cc]ombust", SCC$SCC.Level.One), ]
coalCombustion <- combustion[grep("[Cc]oal", combustion$SCC.Level.Three), ]
SCCCodes <- unique(coalCombustion$SCC)

# get the total emissions for each year

coalCombNEI <- filter(NEI, SCC %in% SCCCodes)
totalEmissions <- tapply(coalCombNEI$Emissions, coalCombNEI$year, sum)

# make the plot

while(dev.cur() > 1) { dev.off() }
x11()
plot(as.numeric(names(totalEmissions)), totalEmissions, pch = 19, 
     main = "Sum of PM2.5 Emissions from Coal Combustion",
     xlab = "Year", ylab = "PM2.5 Emissions (Tons)")
abline(lm(totalEmissions ~ as.numeric(names(totalEmissions))), lwd = 3, col = "blue")
dev.copy(png, file = "plot4.png", height = 480, width = 480, units = "px")
dev.off() # writes the file, but leaves the screen device open

