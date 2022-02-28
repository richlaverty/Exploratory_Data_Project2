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