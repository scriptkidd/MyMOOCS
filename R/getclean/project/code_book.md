---
title: "CodeBook"
date: "Saturday 21 March 2015"
output: html_document
---
In short, this script merges x_test and x_train data for  accelerometer and gyroscope sensor signals generated from 30
individuals, each of whom performed 6 activities - WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, 
STANDING, LAYING)- wearing a smartphone (Samsung Galaxy S II) on the waist.

x_test and x_train data were first merged with the respective activities and subjects file. Descriptive activity names were used to name the activities in the test and train data set, and descriptive variable names were used to label the variables.

Training and the test sets were then merged to create one data set, and only the measurements on the mean and standard deviation for each measurement were extracted.

From this dataset, a second, independent tidy data set with the average of each variable for each activity and each subject were created. Average of mean variables were prefixed with 'MAvg' and of standard deviation were prefixed with 'SDAvg'