# CodeBook

This is a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data.

## The data source

* Original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* Original description of the dataset: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Data Set Information

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years old. 
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a Samsung Galaxy S II on the waist. 
Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity were captured at a constant rate of 50Hz. 
The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers were selected for generating the training data and 30% for the test data.

## The data

The dataset includes the following files:

- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

The following files are available for the training and test data. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Range is from 1 to 30.
- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. 
  Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis.
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration.
- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.

## Transformation details

There are 5 parts:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## How ```run_analysis.R``` implements the above steps:

* Requires data.table and dplyr libraries.
* Load both test and train data
* Load the features and activity labels.
* Extract the mean and standard deviation column names and data.
* Process the data. There are two parts processing test and train data respectively.
* Merge data set.

## variables used in run_analysis.R
featurelabels - data from features.txt
activitylabels - data from activity_labels.txt

##Assign combined X variable
tmptrainx from train/X_train.txt
tmptestx from test/X_test.txt
featuresx combines tmptrainx and tmptestx

## Assign combined Y variable
tmptrainy from train/Y_train.txt
tmptesty from test/Y_test.txt
activityy combines tmptrainy, tmptesty

##Assign combined Subject info
tmptrainsub  from train/subject_train.txt
tmptestsub  from test/subject_test.txt
subject combines tmptrainsub, tmptestsub

#Merging data

alldata <- cbind(featuresx,activityy,subject)

##read features
features <- read.table("features.txt")

##features with mean & standard dev
features_good 

##extract data using selected columns in the required columns
extractdata 
