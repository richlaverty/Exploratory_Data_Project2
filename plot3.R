# Question to answer: Of the four types of sources indicated by
# the type (point, nonpoint, onroad, nonroad) variable, which of
# these four sources have seen decreases in emissions from 1999–2008
# for Baltimore City? Which have seen increases in emissions from 1999–2008? 

# Use the ggplot2 plotting system to make a plot answer this question.
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

# get the Baltimore only data, split by type
baltPointNEI <- subset(NEI, NEI$fips == "24510" & NEI$type == "POINT")
baltNonPointNEI <- subset(NEI, NEI$fips == "24510" & NEI$type == "NONPOINT")
baltOnRoadNEI <- subset(NEI, NEI$fips == "24510" & NEI$type == "ON-ROAD")
baltNonRoadNEI <- subset(NEI, NEI$fips == "24510" & NEI$type == "NON-ROAD")

# get the total emissions, by year, for each of the 4 data sets
pointTotal <- tapply(baltPointNEI$Emissions, baltPointNEI$year, sum)
nonPointTotal <- tapply(baltNonPointNEI$Emissions, baltNonPointNEI$year, sum)
onRoadTotal <- tapply(baltOnRoadNEI$Emissions, baltOnRoadNEI$year, sum)
nonRoadTotal <- tapply(baltNonRoadNEI$Emissions, baltNonRoadNEI$year, sum)

# create one data frame with all the total emissions data
totalEmissions <- data.frame(Year = rep(as.numeric(names(pointTotal)),4))
totalEmissions$Emissions <- c(pointTotal, nonPointTotal, onRoadTotal, nonRoadTotal)
totalEmissions$type <- as.factor(rep(c("POINT", "NONPOINT", "ON-ROAD", "NON-ROAD"), each = 4))

# create the plot

library(ggplot2)
while(dev.cur() > 1) { dev.off() }
g <- ggplot(totalEmissions, aes(Year, Emissions))
g <- g + geom_point()
g <- g + geom_smooth(method = lm, se = FALSE)
g <- g + facet_grid(. ~ type)
g <- g + labs("Total PM2.5 Emissions in Baltimore by Type")
g <- g + labs(x = "Year", y = "Total Emissions (Tons)")
x11()
print(g)
dev.copy(png, file = "plot3.png", height = 480, width = 720, units = "px")
dev.off() # writes the file, but leaves the screen device open




