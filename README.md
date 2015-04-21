The code in run_analysis.R performs the next steps
## Read the data
Requires data.table 1.9.5 package 

Reads the files X_train.txt, subject_train.txt y_train.txt, X_test.txt, subject_test.txt, y_test.txt and activity_labels.txt

## Merges the training and the test sets to create one data set.
Merges train and test
Merges the activities
Merges the subjects

## Extracts only the measurements on the mean and standard deviation for each measurement. 
The desired columns are: 1,2,3,4,5,6,41,42,43,44,45,46,81,82,83,84,85,86,121:126,161:166,201,202,214,215,227,228,240,241,253,254,266:271,294:296,345:350,373:375,424:429,452:454,503,504,513,516,517,526,529,530,539,542,543,552

## Uses descriptive activity names to name the activities in the data set
Apply a recursive sapply to get the activity labels

## Appropriately labels the data set with descriptive variable names.
Use thoes labels for the names of the data frame


## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
With apply over the columns of the data makes a tapply for each activity and subject

