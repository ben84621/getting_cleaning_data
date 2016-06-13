
# Code for Getting and Cleaning Data - Course Project
# Ben Fischer

# This code is designed to accomplish the following steps:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


setwd("~/Documents/datascience/files/UCIHARDataset")

# set the paths for the various files in the research
path_traindata_raw <- "train/X_train.txt"
path_trainlabels_raw <- "train/y_train.txt"
path_trainsubjects_raw <- "train/subject_train.txt"
path_testdata_raw <- "test/X_test.txt"
path_testlabels_raw <- "test/y_test.txt"
path_testsubjects_raw <- "test/subject_test.txt"
path_activityheaders <- "features.txt"
path_activitydesc <- "activity_labels.txt"

# read the files into variables. Note the activity headers file is numbered - we just want the description
traindata_raw <- read.table(path_traindata_raw, header = FALSE)
trainsubjects_raw <- read.table(path_trainsubjects_raw, header = FALSE)
activityheaders <- read.table(path_activityheaders, header = FALSE)[,2]
trainlabels_raw <- read.table(path_trainlabels_raw, header = FALSE)
activitydesc <- read.table(path_activitydesc, header = FALSE) 

# This code pulls merges the activity names into the activity file to accomplish requirement 3
names(activitydesc) <- c("ActivityID", "activity_name")
names(trainlabels_raw) <- "ActivityID"
trainlabels_raw <- merge(trainlabels_raw, activitydesc, by = "ActivityID" )

# set the names of the main dataset to the values in the header file (requirement 4)
names(traindata_raw) <- activityheaders
names(trainsubjects_raw) <- c("Subject")

# remove any columns from the data which don't represent mean or standard deviation (requirement 2)
traindata_raw <- traindata_raw[,grepl("mean|std", names(traindata_raw))]

# assemble the disparate training datasets into one data frame
traindata <- bind_cols(traindata_raw, trainsubjects_raw, trainlabels_raw)

# now follow the same steps for the test data
testdata_raw <- read.table(path_testdata_raw, header = FALSE)
testlabels_raw <- read.table(path_testlabels_raw, header = FALSE)
testsubjects_raw <- read.table(path_testsubjects_raw, header = FALSE)

names(testdata_raw) <- activityheaders
names(testsubjects_raw) <- c("Subject")
names(testlabels_raw) <- "ActivityID"
testlabels_raw <- merge(testlabels_raw, activitydesc, by = "ActivityID" )

testdata_raw <- testdata_raw[,grepl("mean|std", names(testdata_raw))]

testdata <- bind_cols(testdata_raw, testsubjects_raw, testlabels_raw)

# now that we've assembled the test and training data into complete, labeled dataframes, we can 
# put them together into one file (requirement 1) and then produce the aggregate file (requirement 5)
cleandata <- bind_rows(traindata, testdata)
cleandata <- data.table(cleandata)
tidy_data <- cleandata[,lapply(.SD, mean), by = 'Subject,activity_name']
tidy_data <- tidy_data[order(Subject, activity_name),]

# write the tidy data file using tab delimiter 
write.table(tidy_data, "tidy_data.txt", sep = "\t", row.names = FALSE)