# Code Book for Getting and Cleaning Data course project
In this project we got the information from "Human Activity Recognition Using Smartphones Data Set" transformed it to a tidy data set that captures the average and standard deviation for the features that are themselves mean or std.

The original information comes from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones but we used here link in the assignment: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The original data set is separated in two main folders, 'train' for the training data set and 'test' for the test data set. Each folder is structured in files which correspond to the X = y, where X is a matrix of features and y is the vector result. This is commonly used for logistic regression in Machine Learning. 
The results vectors 'y' values correspond to the 'activity_labels.txt' file.
The matrices X has one column per feature in the 'features.txt' file and one row per observation.
The "subject_*.txt" files have the same amount of rows as the corresponding X files and each one has the subject (person in the experiment) number.

The result of running the script run_analysis.R is a tidy.txt file that contains the following columns:
__subject:__ a number identifying the subject (person doing the activity) in the study.
__activity:__ one of LAYING, SITTING, STANDING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS.
__variable:__ one of the original variables containing either "mean" or "std" in the name. See the file "features.txt" in the original data set.
__mean:__ the mean of the variable for the subject-activity pair. 
__sd:__ the mean of the variable for the subject-activity pair.


The run_analysis.R script does the following process:
* Load the data for subjects in the train set into subjectTrain variable.
* Rename the subjects column to "subject".
* Load the data for X in the train set into XTrain variable.
* Load features.txt into the features variable.
* Rename the features in Xtrain using the features.
* Load the data for y in the train set into yTrain variable.
* Rename the y column to "activity".
* Join columns for Train set (subject, X, y)
* Repeat the previous steps for Y (except loading the features, which we reuse).
* Join both sets into joinSet data frame.
* Filter the columns to only include activity, subject and columns containing either 'mean' or 'std'.
* Read the activity_labels.txt into activityLabels variable.
* Use activityLabels to replace the values in the column "activity" to the corresponding activity labels.
* Create a data frame using _melt_ function that has 'subjec' and 'activity' as the ids.
* Store in variable 'tidy' the result of applying _ddply_ function on the melted data frame to calculate mean and standard deviation grouping by 'subject' and 'activity'. 
* Save 'tidy' data frame to 'tidy.txt' file.

