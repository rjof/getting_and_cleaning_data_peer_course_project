## Read the data
## Requires data.table 1.9.5 package 
## In case is not in you system run the next commands
## (https://github.com/Rdatatable/data.table/issues/956)
## install.packages("devtools")
## library(devtools)
## install_github("Rdatatable/data.table",  build_vignettes = FALSE)
library("data.table")

train <- read.table("UCI HAR Dataset/train/X_train.txt")
train_subject<-read.table("UCI HAR Dataset/train/subject_train.txt")
train_activities<-read.table("UCI HAR Dataset/train/y_train.txt")
test<-read.table("UCI HAR Dataset/test/X_test.txt", sep = "")
test_subject<-read.table("UCI HAR Dataset/test/subject_test.txt")
test_activities<-read.table("UCI HAR Dataset/test/y_test.txt")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")

## Merges the training and the test sets to create one data set.
s<-rbind(train,test)
dim(s)
all_activities <- rbind(train_activities,test_activities)
dim(all_activities)
subjects<-rbind(train_subject,test_subject)
dim(subjects)

## Extracts only the measurements on the mean
## and standard deviation for each measurement. 
s2<-s[,c(1,2,3,4,5,6,41,42,43,44,45,46,81,82,83,84,85,86,121:126,161:166,201,202,214,215,227,228,240,241,253,254,266:271,294:296,345:350,373:375,424:429,452:454,503,504,513,516,517,526,529,530,539,542,543,552)]
dim(s2)

## Uses descriptive activity names to name the activities in the data set
all_activities_desc <- sapply(all_activities,function(e){ activity_labels[as.numeric(e),2] })
all_activities_desc <- as.vector(all_activities_desc)
s3 <- cbind(all_activities_desc,s2)
dim(s3)
s4 <- cbind(subjects,s3)

## Appropriately labels the data set with descriptive variable names. 
names(s4) <- c( "subject","activity","tBodyAcc-mean-X", "tBodyAcc-mean-Y", "tBodyAcc-mean-Z", "tBodyAcc-std-X", "tBodyAcc-std-Y", "tBodyAcc-std-Z", "tGravityAcc-mean-X", "tGravityAcc-mean-Y", "tGravityAcc-mean-Z", "tGravityAcc-std-X", "tGravityAcc-std-Y", "tGravityAcc-std-Z", "tBodyAccJerk-mean-X", "tBodyAccJerk-mean-Y", "tBodyAccJerk-mean-Z", "tBodyAccJerk-std-X", "tBodyAccJerk-std-Y", "tBodyAccJerk-std-Z", "tBodyGyro-mean-X", "tBodyGyro-mean-Y", "tBodyGyro-mean-Z", "tBodyGyro-std-X", "tBodyGyro-std-Y", "tBodyGyro-std-Z", "tBodyGyroJerk-mean-X", "tBodyGyroJerk-mean-Y", "tBodyGyroJerk-mean-Z", "tBodyGyroJerk-std-X", "tBodyGyroJerk-std-Y", "tBodyGyroJerk-std-Z", "tBodyAccMag-mean", "tBodyAccMag-std", "tGravityAccMag-mean", "tGravityAccMag-std", "tBodyAccJerkMag-mean", "tBodyAccJerkMag-std", "tBodyGyroMag-mean", "tBodyGyroMag-std", "tBodyGyroJerkMag-mean", "tBodyGyroJerkMag-std", "fBodyAcc-mean-X", "fBodyAcc-mean-Y", "fBodyAcc-mean-Z", "fBodyAcc-std-X", "fBodyAcc-std-Y", "fBodyAcc-std-Z", "fBodyAcc-meanFreq-X", "fBodyAcc-meanFreq-Y", "fBodyAcc-meanFreq-Z", "fBodyAccJerk-mean-X", "fBodyAccJerk-mean-Y", "fBodyAccJerk-mean-Z", "fBodyAccJerk-std-X", "fBodyAccJerk-std-Y", "fBodyAccJerk-std-Z", "fBodyAccJerk-meanFreq-X", "fBodyAccJerk-meanFreq-Y", "fBodyAccJerk-meanFreq-Z", "fBodyGyro-mean-X", "fBodyGyro-mean-Y", "fBodyGyro-mean-Z", "fBodyGyro-std-X", "fBodyGyro-std-Y", "fBodyGyro-std-Z", "fBodyGyro-meanFreq-X", "fBodyGyro-meanFreq-Y", "fBodyGyro-meanFreq-Z", "fBodyAccMag-mean", "fBodyAccMag-std", "fBodyAccMag-meanFreq", "fBodyBodyAccJerkMag-mean", "fBodyBodyAccJerkMag-std", "fBodyBodyAccJerkMag-meanFreq", "fBodyBodyGyroMag-mean", "fBodyBodyGyroMag-std", "fBodyBodyGyroMag-meanFreq", "fBodyBodyGyroJerkMag-mean", "fBodyBodyGyroJerkMag-std", "fBodyBodyGyroJerkMag-meanFreq" )


## From the data set in step 4, creates a second, independent tidy
## data set with the average of each variable for each activity and
## each subject.
s4.aggregators<-subset(s4,select=c(activity,subject))
s4.data<-subset(s4,select=c(-subject,-activity))
final_tidy <- apply(s4.data, 2, function(c) tapply(c, s4.aggregators, mean))
write.table(final_tidy, row.names=F, file="final_tidy.txt")

