setwd("~/UCIHAR")

# Import dplyr
library(dplyr)
library(sqldf)

# Read in test files
x_test <- read.csv("./test/X_test.txt", sep="", header=FALSE)
y_test <- read.csv("./test/y_test.txt", sep="", header=FALSE)
subject_test <- read.csv("./test/subject_test.txt", sep="", header=FALSE)

# Merge the test datasets
testdata <- data.frame(subject_test, y_test, x_test)

# Read in train files
x_train <- read.csv("./train/X_train.txt", sep="", header=FALSE)
y_train <- read.csv("./train/y_train.txt", sep="", header=FALSE)
subject_train <- read.csv("./train/subject_train.txt", sep="", header=FALSE)

# Merge the training datasets
traindata <- data.frame(subject_train, y_train, x_train)

# Combine test with train
combinedata<-rbind(traindata, testdata)

# Read in the measurement labels
features <- read.csv("features.txt", sep="", header=FALSE)

# Convert the 2nd column into a vector
cnames <- as.vector(features[, 2])

# Assign the column names for the combined dataset
colnames(combinedata) <- c("subjectid", "activity", cnames)

labels <- read.csv("activity_labels.txt",  sep="", header=FALSE)
labels<-rename(labels, activityid=V1, activity=V2)

# Update activity column in combined data with activity label names
combinedata$activity<-labels[match(combinedata$activity, labels$activityid), 2]

# Clean column names; Names of variables should 1) be all lowercase; 2) not be duplicated; 3) not have underscores or dots or white spaces (Video: Editing Text Variables)
cleannames<-names(combinedata)
cleannames<-tolower(cleannames)
cleannames<-gsub("BodyBody", "Body", cleannames)

# Check for underscores, dots, and white spaces
grep("_", cleannames)
grep("/.", cleannames)
grep(" ", cleannames)

# Rename columns in combined dataset
colnames(combinedata)<-cleannames

# Remove duplicates
tidydata<-combinedata[, !duplicated(colnames(combinedata))]
tidydata<-select(tidydata, matches("subjectid|activity|mean|std"), -matches("freq"))

# Group by subject and activity; calculate the mean
summary <- tidydata %>% group_by(subjectid, activity) %>% summarise_each(funs(mean))

# Write results to txt file
write.table(summary, file = 'tidydata.txt', row.names = FALSE, sep="\t")