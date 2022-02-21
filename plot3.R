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
