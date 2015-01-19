# # Definition of data
# # 
# # Data are values of qualitative or quantitative variables, belonging to a set of items
# # http://en.wikipedia.org/wiki/Data
# # 
# # set of itmes: called population; set of objects you are interested in
# # Variables: A measurement or characteristic of an item
# # Qualitative: Country of origin, sex, treatment
# # Quantitative: Height, weight, blood pressure
# 
# # Raw vs Processed data
# # 
# # Raw
# #  original source of data
# # hard to use for data analyses
# # Data analysis includes processing
# # Raw data may only need to be processed once
# # 
# # http://en.wikipedia.org/wiki/Raw_data
# # 
# # Processed data
# # Data that is ready for analysis
# # Processing can include merging, subseting, transforming,etc.
# # There may be statndards for processing
# # All setps should be recorded
# 
# 
# # Tidy Data
# # raw data
# # tidy data set
# # code book describing each variable and its values in tidy data set.
# # Explicit and exact recipe you uesd to go from 1->2,3
# 
# raw data
# strange binary file you measurement machine spits out
# unformatted Exel file with 10 
# Ran no software on the data
# Did not manipulate any of the numbers in the data
# you did not remove any data from the data set
# did no 
# 
# tidy data
# Each variable you measure should be in one column
# Each different observation of that variable should be in different row
# There should be on table for each kind of variable
# if have multiple tables , should include a column in the table that allow them to be linked
# 
# Tips
# Include a row at the top of each file with variable names.
# make variable names human readable AgeAtDiagnosis insted of AgeDx
# In general
# 
# The code book
#  information about variables (including units) in data set not contained in the tidy data
#  Information about the summary choices you made.
# Tips
# A common format for this document is a Word/text files.
# section called "study design" that has a thorough description of 
# 
# Instruction list
# Ideally a computer script (R , python is ok too)
# input raw data
# output processed. tidy  data
# no parameters to the script

# Step 1 : take raw file run summarize software with parameters a=1, b=3,
# Setup 2 run the software separately for each sample
# Setup 3 take column three of coutputfile.out for each sample and that is the corresponding row in the output data set
# https://github.com/jtleek/datasharing

# Downloading files

# Get/set working directory
# getwd()
# setwd()
getwd()
# Relative - setwd(".data"), setwd("../")
# Absolute - setwd("/Users/data")

# Checking for and creating dir
if(!file.exists("data")) { 
        dir.create("data") #if return False
}

# Get data from internet - download.files()
# url destfile, method
# Useful for downloading tab-delimited, csv and other files..

# https://data.baltimorecity.gov/Transportation/Baltimore-Fixed-Speed-Cameras/dz54-2aru

url <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(url , destfile="./data/cameras.csv", method="curl")
list.files("./data")
dateDownload <- date()
dateDownload

# Reading local flat files
# read.table(0
# Read data into RAM - big data can cause problems
# Important parameters files, header, sep, row.names.nrows

cameraData <-read.table("./data/cameras.csv")
head(cameraData)

str(read.table)
cameraData <- read.table("./data/cameras.csv",sep=",", header = TRUE)
head(cameraData)

#read.csv set sep="," and header=TRUE
cameraData <- read.csv("./data/cameras.csv")
head(cameraData)


# quote - quote="" no quotes
# na.strings set the character that represents a missing value
# nrows = how many rows to read of file 
# skip = skip number of lines

# Reading Excel Files
if(!file.exists("data")) {dir.create("data")}
url <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD"
download.file(url , destfile="./data/cameras.xlsx", method="curl")
dateDownload <- date()
list.files("./data")

install.packages("xlsx")
library(xlsx)
?read.xlsx
cameraData <- read.xlsx("./data/cameras.xlsx", sheetIndex=1, header=TRUE)
head(cameraData)

colIndex <-2:3
rowIndex <-1:4
cameraDataSubset <- read.xlsx("./data/cameras.xlsx", sheetIndex=1,
                        colIndex=colIndex, rowIndex=rowIndex)

cameraDataSubset

?write.xlsx
# read.xlsx2 is faster than read.xlsx but unstable in subset of rows reading


