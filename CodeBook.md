This script will produce two data frames called tidy_data and tidy_data2 from the UCI HAR Dataset.

In tidy_data, the variables will be:
subject: numbered from 1 to 30
activity: labeles as 1 WALKING,2 WALKING_UPSTAIRS,3 WALKING_DOWNSTAIRS,4 SITTING,5 STANDING or 6 LAYING

The mean and standard deviation of the variables:
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

As described in the UCI HAR Dataset.

The data frame tidy_data2 contains the average of the values of the mean and std of the previous data set and a variable called "grouping_variable" that specifies which subject or activity was used to group the values to calculate the averages.