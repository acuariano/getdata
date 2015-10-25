# getdata
## Assignment for Coursera's Getting and Cleaning Data from Johns Hopkins University

To run the code just run in R:
```
source("run_analysis.R") 
```
The code should result in a "tidy.txt" file being created. See the Code Book for details of the results and how we get them.

In this project we got the information from "Human Activity Recognition Using Smartphones Data Set" transformed it to a tidy data set that captures the average and standard deviation for the features that are themselves mean or std.

The original information comes from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones but we used here the link in the assignment: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The original data set is separated in two main folders, 'train' for the training data set and 'test' for the test data set. Each folder is structured in files which correspond to the X = y form, where X is a matrix of features and y is the vector result. This is commonly used for logistic regression in Machine Learning. 

The results vectors 'y' values correspond to the 'activity_labels.txt' file.

The matrices X has one column per feature in the 'features.txt' file and one row per observation.

The "subject_*.txt" files have the same amount of rows as the corresponding X files and each one has the subject (person in the experiment) number.


The run_analysis.R script does the following process:

1. Load the data for subjects in the train set into subjectTrain variable.
1. Rename the subjects column to "subject".
1. Load the data for X in the train set into XTrain variable.
1. Load features.txt into the features variable.
1. Rename the features in Xtrain using the features.
1. Load the data for y in the train set into yTrain variable.
1. Rename the y column to "activity".
1. Join columns for Train set (subject, X, y)
1. Repeat the previous steps for Y (except loading the features, which we reuse).
1. Join both sets into joinSet data frame.
1. Filter the columns to only include activity, subject and columns containing either 'mean' or 'std'.
1. Read the activity_labels.txt into activityLabels variable.
1. Use activityLabels to replace the values in the column "activity" to the corresponding activity labels.
1. Create a data frame using _melt_ function that has 'subjec' and 'activity' as the ids.
1. Store in variable 'tidy' the result of applying _ddply_ function on the melted data frame to calculate mean and standard deviation grouping by 'subject' and 'activity'. 
1. Save 'tidy' data frame to 'tidy.txt' file.
