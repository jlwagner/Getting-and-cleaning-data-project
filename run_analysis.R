##create one R script called run_analysis.R that does the following
##Use libraries data.table and dplyr

library(data.table)
library(dplyr)

#MetaData

featurelabels <- read.table("features.txt")
activitylabels <- read.table("activity_labels.txt")

##1. Merges the training and the test sets to create one data set.
##Assign combined X variable

tmptrainx <- read.table("train/X_train.txt")
tmptestx <- read.table("test/X_test.txt")
featuresx <- rbind(tmptrainx, tmptestx)

## Assign combined Y variable

tmptrainy <- read.table("train/Y_train.txt")
tmptesty <- read.table("test/Y_test.txt")
activityy <- rbind(tmptrainy, tmptesty)

##Assign combined Subject info

tmptrainsub <- read.table("train/subject_train.txt")
tmptestsub <- read.table("test/subject_test.txt")
subject <- rbind(tmptrainsub, tmptestsub)

##Assign column names from featurelabels
colnames(featuresx)<-t(featurelabels[2])

#Merging data

colnames(activityy)<-"Activity"
colnames(subject)<-"Subject"
alldata <- cbind(featuresx,activityy,subject)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
##read features
features <- read.table("features.txt")

##features with mean & standard dev
features_good <- grep(".*Mean.*|.*Std.*",names(alldata),ignore.case=TRUE)

##add activity & subject columns to the list
requiredColumns <-c(features_good, 562, 563)

##look at dimensions of alldata
dim(alldata)

##extract data using selected columns in the required columns
extractdata <- alldata[requiredColumns]

##look at dimensions of extract data
dim(extractdata)

## 3. Uses descriptive activity names to name the activities in the data set 

extractdata$Activity <- as.character(extractdata$Activity)
for (i in 1:6){extractdata$Activity[extractdata$Activity==i]<- as.character(activitylabels[i,2])}

extractdata$Activity <-as.factor(extractdata$Activity)

##4. Appropriately label the data set with descriptive variable names. 
##change names from abbreviated names to understandable English metrics

names(extractdata)<-gsub("Acc", "Accelerometer", names(extractdata))
names(extractdata)<-gsub("Gyro", "Gyroscope", names(extractdata))
names(extractdata)<-gsub("BodyBody", "Body", names(extractdata))
names(extractdata)<-gsub("Mag", "Magnitude", names(extractdata))
names(extractdata)<-gsub("^t", "Time", names(extractdata))
names(extractdata)<-gsub("^f", "Frequency", names(extractdata))
names(extractdata)<-gsub("tBody", "TimeBody", names(extractdata))
names(extractdata)<-gsub("-mean()", "Mean", names(extractdata), ignore.case = TRUE)
names(extractdata)<-gsub("-std()", "STD", names(extractdata), ignore.case = TRUE)
names(extractdata)<-gsub("-freq()", "Frequency", names(extractdata), ignore.case = TRUE)
names(extractdata)<-gsub("angle", "Angle", names(extractdata))
names(extractdata)<-gsub("gravity", "Gravity", names(extractdata))

##5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

extractdata$Subject <-as.factor(extractdata$Subject)
extractdataData <- data.table(extractdata)

##Create tidydata dataset
tidydata<-aggregate(. ~Subject + Activity, extractdata, mean)
tidydata<-tidydata[order(tidydata$Subject,tidydata$Activity),]

##Write data to new table
write.table(tidydata,file="TidyData.txt",row.names = FALSE)
