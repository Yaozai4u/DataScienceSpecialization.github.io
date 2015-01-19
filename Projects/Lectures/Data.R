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


# Reading XML
# http://en.wikipedia.org/wiki/XML
# Elements <Greeting> Hello </Greeting>
#         Attributes 
# <img src="jeff.jpg" alt"instructor"/>
# <step number"3"> Connect A to B </step>
# http://www.w3schools.com/xml/simple.xml

install.packages("XML")
library(XML)

url <- "http://www.w3schools.com/xml/simple.xml"

?xmlTreeParse
doc <-xmlTreeParse(url, useInternal=T)
rootNode <- xmlRoot(doc)
xmlName(rootNode)

names(rootNode)

rootNode[[1]]
# First Element
rootNode[[1]][[1]]

# Programatically extract parts of the file
xmlSApply(rootNode, xmlValue)

# # XPath
#  /node Top level node
#  //node Node at any level
#  node[@attr-name] Node with an attribute name
# node[@attr-name-'bob'] node with attribute name attr-name-'bob'

url <- "http://www.stat.berkeley.edu/~statcur/Workshop2/Presentations/XML.pdf"
download.file(url , destfile="./data/XML.pdf", method="curl")

# Get the items on the menu and prices
xpathSApply(rootNode, "//name",xmlValue)
xpathSApply(rootNode, "//price",xmlValue)

url <= "http://espn.go.com/nfl/team/_/name/bal/baltimore-ravens"
doc <- htmlTreeParse(url, useInternal=TRUE)
doc
# <li class="score">
scores <-xpathSApply(doc, "//li[@class='score']",xmlValue)
scores
# <li class="team-name">
teams <-xpathSApply(doc, "//li[@class='team-name']",xmlValue)
teams


# Reading JSON
# http://en.wikipedia.org/wiki/JSON
# Data store Number(double),string(double Quoted), Bollean(true,false) Array(ordered, comma separated in square bracket[])
# Object (unordered, comman seperated collection of key:value pairs in curley bracket{}

install.packages("jsonlite")

library(jsonlite)
install.packages('httr')
jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)

names(jsonData$owner)
jsonData$owner$login


# Writing data frames to JSON
myjson <-toJSON(iris, pretty=TRUE)
cat(myjson)
names(myjson)
names(iris)

# Convert back to JSON
iris2 <-fromJSON(myjson)
head(iris2)
# http://www.r-bloggers.com/new-package-jsonlite-a-smarter-json-encoderdecoder/
#         jsonlite vignette


# Using data.table
# Inherets from data.frame All functions that accept data.frame work on data.table
# Written in C so it is much faster
# Much much faster at subsetting, group, and updating

install.packages("data.table")
library(data.table)
?data.table
DF=data.frame(x=rnorm(9), y=rep(c("a","b","c"),each=3), z=rnorm(9))
DF
head(DF,3)

DT= data.table(x=rnorm(9), y=rep(c("a","b","c"),each=3), z=rnorm(9))
head(DT,3)

# see all data tables in memory
tables()

DT[2,]
DT[DT$y=='a',]

# Subsetting rows
DT[c(2,3)]

# Subsetting columns
DT[,c(2,3)]

# Column subsetting in data.table
{
        x=1
        y=2
}
k={print(10);5}

print(k)

Calculating values for variables with expressions

DT[,list(mean(x),sum(z))]
DT[,table(y)]

# Adding new columns
DT[,w:=z^2]
DT

DT2 <- DT
DT[, y:= 2 ]
head(DT, n=3)

head(DT2, n=3)

# Multiple operations

DT[,m:= {tmp <- (x+z); log2(tmp+5)}]
DT

# plyr like operations
DT[, a:= x>0]
DT

DT[,b:=mean(x+w),by=a]
DT

# Special variables
# .N integer length 1, 
set.seed(123);
DT <- data.table(x=sample(letters[1:3],1E5,TRUE))
DT

DT[,.N,by=x]


# Keys
DT <- data.table(x=rep(c("a","b","c"),each=100),y=rnorm(300))
setkey(DT,x)
DT['a']

DT

# Joins
DT1 <- data.table(x=c("a","a",'b','dt1'),y=1:4)
DT2 <- data.table(x=c('a','b','dt2'),z=5:7)

setkey(DT1, x); setkey(DT2, x)
DT1; DT2
merge(DT1,DT2)


# Fast reading

big_df <- data.frame(x=rnorm(1E6), y=rnorm(1E6))
file <- tempfile()
write.table(big_df, file=file, row.names=F, col.name=T, sep="\t", quote=F)
system.time(fread(file))
system.time(read.table(file, header=T,sep="\t"))


# lastest contain new function like melt dcast for data.tables

