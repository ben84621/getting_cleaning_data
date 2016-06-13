# getting_cleaning_data
course project

# Overview
This project demonstrates the ability to ingest data and assemble it into a coherent dataset which can be used for more analysis or communicating results. The data in question is from a series of tests in which users performed basic movements while wearing a smartphone. The measurements recorded by the phone were saved in several different files. 

Overview of the tests: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
Source data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The assignment entailed:
- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement.
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names.
- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The only script required is run_analysis.R. 

The resultant file, tidy_data.txt, shows a summary of the measurements by user and by activity.
