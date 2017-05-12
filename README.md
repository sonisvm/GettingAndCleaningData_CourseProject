# Getting And Cleaning Data - Course Project
This repo contains the following:
* run_analysis.R - Script file which converts raw data available at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones into tidy data.
* CodeBook.md - CodeBook describing the measurements in the tidy data, as well as the steps followed to transform the raw data.
## Analysis Script - run_analysis.R
The script does the following:
* Download and unzip the files available at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.
* Read the measurements available in the files X_train, y_train, subject_train under the train folder.
* Read the measurements available in the files X_test, y_test, subject_test under the test folder
* Merge the training and test data sets into one data set.
* Set descriptive names for activities as well as the measurements.
* Extract the mean and standard deviation measurements.
* Form a tidy data set with the average of each measurement for each activity for each subject.
* Write the tidy data into a file called tidy_data.txt in the working directory.
Detailed description can be found under Transformation steps in the CodeBook.
