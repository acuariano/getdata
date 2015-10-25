## 1. Merges the training and the test sets to create one data set.
print("1. Merging sets and 4. Appropriately labeling the data set...")
## For this we need to join subject_train.txt, X_train.txt and y_train.txt by column
## subject_test.txt, X_test.txt and y_test.txt by column
## and join the resulting sets by rows.
## To add the column names we use the features.txt + "activity" + "subject".
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
names(subjectTrain) <- c("subject")
XTrain <- read.table("UCI HAR Dataset/train/X_train.txt")
features <- read.table("UCI HAR Dataset/features.txt")
names(XTrain) <- features$V2 ## rename the columns with the features
yTrain <- read.table("UCI HAR Dataset/train/y_train.txt")
names(yTrain) <- c("activity")
## Join columns for Train set
trainingSet <- cbind(subjectTrain, XTrain, yTrain)
## remove unecessary variables
rm(list = c("subjectTrain", "XTrain", "yTrain"))

## Same for Test set
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt")
names(subjectTest) <- c("subject")
XTest <- read.table("UCI HAR Dataset/test/X_test.txt")
names(XTest) <- features$V2 ## rename the columns with the features
yTest <- read.table("UCI HAR Dataset/test/y_test.txt")
names(yTest) <- c("activity")
## Join columns for Train set
testingSet <- cbind(subjectTest, XTest, yTest)

## join both sets
joinSet <- rbind(trainingSet, testingSet)

## remove unecessary variables
rm(list = c("features", "subjectTest", "XTest", "yTest", "trainingSet", "testingSet"))

print("2. Extracting only the measurements on the mean and standard deviation for each measurement...") 
filteredJoinedSet <- joinSet[ , grepl( "mean|std|subject|activity" , names( joinSet ) ) ]
rm(joinSet)

print("3. Replacing activity numeric values with names in the data set...")
library(plyr)
activityLabels <- read.table('UCI HAR Dataset/activity_labels.txt', colClasses=c("numeric", "character"))
filteredJoinedSet$activity <- mapvalues(filteredJoinedSet$activity, activityLabels$V1, activityLabels$V2)
rm(activityLabels)
## 4. Appropriately labels the data set with descriptive variable names.
## this was done with the merging. It's easier to name each file separately.

## 5. From the data set in step 4, creates a second, independent tidy data set with the average
## of each variable for each activity and each subject.
print("5. Creating tidy data set with the average and standard for each variable...")
library(reshape2)
melted <- melt(filteredJoinedSet, id.vars=c("subject", "activity"))
tidyMeanSd <- ddply(melted, c("subject", "activity", "variable"), summarise, mean = mean(value), sd = sd(value))
rm(melted)## remove intermediate objects
write.table(tidyMeanSd, file = "tidy.txt", row.names = FALSE)
