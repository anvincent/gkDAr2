Overview and Original Instruction Set
========================================================

This project provides the solution to the Course Project "Getting and Cleaning Data". The Course Project description is below:

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

1. You should create one R script called run_analysis.R that does the following. 
2. Merges the training and the test sets to create one data set.
3. Extracts only the measurements on the mean and standard deviation for each measurement. 
4. Uses descriptive activity names to name the activities in the data set
5. Appropriately labels the data set with descriptive activity names. 
6. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

Codebook and data dictionary for dataset2.csv
================================

Codebook overview
--------------------------------
The variables used are based on the features obtained from the raw dataset. Please refer to the next section for additional details. Each of the variables are defined based on the source, system, unit, and type of measurement. The combinations are noted below:

* Body / Gravity
  * Body
  * Gravity
* Acc / Gyro
  * Accelerometer
  * Gyroscope
* Mean / MeanFreq / Std
  * Mean
  * Mean frequency
  * Standard Deviation

Codebook details
--------------------------------
* subject.
  * System: N/A
  * Units: Factor - each observation is an end-user.
* activity.label.names
  * System: N/A
  * Units: Type of activity performed.
* tBodyAcc.mean.X
  * System: Body Accelerometer X axis
  * Units: Time
* tBodyAcc.mean.Y
  * System: Body Accelerometer Y axis
  * Units: Time
* tBodyAcc.mean.Z
  * System: Body Accelerometer
  * Units: Time
* tBodyAcc.std.X
  * System: Body Accelerometer
  * Units: Time
* tBodyAcc.std.Y
  * System: Body Accelerometer
  * Units: Time
* tBodyAcc.std.Z
  * System: Body Accelerometer
  * Units: Time
* tGravityAcc.mean.X
  * System: Gravity Accelerometer
  * Units: Time
* tGravityAcc.mean.Y
  * System: Gravity Accelerometer
  * Units: Time
* tGravityAcc.mean.Z
  * System: Gravity Accelerometer
  * Units: Time
* tGravityAcc.std.X
  * System: Gravity Accelerometer
  * Units: Time
* tGravityAcc.std.Y
  * System: Gravity Accelerometer
  * Units: Time
* tGravityAcc.std.Z
  * System: Gravity Accelerometer
  * Units: Time
* tBodyAccJerk.mean.X
  * System: Body Accelerometer
  * Units: Time
* tBodyAccJerk.mean.Y
  * System: Body Accelerometer
  * Units: Time
* tBodyAccJerk.mean.Z
  * System: Body Accelerometer
  * Units: Time
* tBodyAccJerk.std.X
  * System: Body Accelerometer
  * Units: Time
* tBodyAccJerk.std.Y
  * System: Body Accelerometer
  * Units: Time
* tBodyAccJerk.std.Z
  * System: Body Accelerometer
  * Units: Time
* tBodyGyro.mean.X
  * System: Body Gyroscope
  * Units: Time
* tBodyGyro.mean.Y
  * System: Body Gyroscope
  * Units: Time
* tBodyGyro.mean.Z
  * System: Body Gyroscope
  * Units: Time
* tBodyGyro.std.X
  * System: Body Gyroscope
  * Units: Time
* tBodyGyro.std.Y
  * System: Body Gyroscope
  * Units: Time
* tBodyGyro.std.Z
  * System: Body Gyroscope
  * Units: Time
* tBodyGyroJerk.mean.X
  * System: Body Gyroscope
  * Units: Time
* tBodyGyroJerk.mean.Y
  * System: Body Gyroscope
  * Units: Time
* tBodyGyroJerk.mean.Z
  * System: Body Gyroscope
  * Units: Time
* tBodyGyroJerk.std.X
  * System: Body Gyroscope
  * Units: Time
* tBodyGyroJerk.std.Y
  * System: Body Gyroscope
  * Units: Time
* tBodyGyroJerk.std.Z
  * System: Body Gyroscope
  * Units: Time
* tBodyAccMag.mean
  * System: Body Accelerometer
  * Units: Time
* tBodyAccMag.std
  * System: Body Accelerometer
  * Units: Time
* tGravityAccMag.mean
  * System: Gravity Accelerometer
  * Units: Time
* tGravityAccMag.std
  * System: Gravity Accelerometer
  * Units: Time
* tBodyAccJerkMag.mean
  * System: Body Accelerometer
  * Units: Time
* tBodyAccJerkMag.std
  * System: Body Accelerometer
  * Units: Time
* tBodyGyroMag.mean
  * System: Body Gyroscope
  * Units: Time
* tBodyGyroMag.std
  * System: Body Gyroscope
  * Units: Time
* tBodyGyroJerkMag.mean
  * System: Body Gyroscope
  * Units: Time
* tBodyGyroJerkMag.std
  * System: Body Gyroscope
  * Units: Time
* fBodyAcc.mean.X
  * System: Body Accelerometer
  * Units: Frequency
* fBodyAcc.mean.Y
  * System: Body Accelerometer
  * Units: Frequency
* fBodyAcc.mean.Z
  * System: Body Accelerometer
  * Units: Frequency
* fBodyAcc.std.X
  * System: Body Accelerometer
  * Units: Frequency
* fBodyAcc.std.Y
  * System: Body Accelerometer
  * Units: Frequency
* fBodyAcc.std.Z
  * System: Body Accelerometer
  * Units: Frequency
* fBodyAcc.meanFreq.X
  * System: Body Accelerometer
  * Units: Frequency
* fBodyAcc.meanFreq.Y
  * System: Body Accelerometer
  * Units: Frequency
* fBodyAcc.meanFreq.Z
  * System: Body Accelerometer
  * Units: Frequency
* fBodyAccJerk.mean.X
  * System: Body Accelerometer
  * Units: Frequency
* fBodyAccJerk.mean.Y
  * System: Body Accelerometer
  * Units: Frequency
* fBodyAccJerk.mean.Z
  * System: Body Accelerometer
  * Units: Frequency
* fBodyAccJerk.std.X
  * System: Body Accelerometer
  * Units: Frequency
* fBodyAccJerk.std.Y
  * System: Body Accelerometer
  * Units: Frequency
* fBodyAccJerk.std.Z
  * System: Body Accelerometer
  * Units: Frequency
* fBodyAccJerk.meanFreq.X
  * System: Body Accelerometer
  * Units: Frequency
* fBodyAccJerk.meanFreq.Y
  * System: Body Accelerometer
  * Units: Frequency
* fBodyAccJerk.meanFreq.Z
  * System: Body Accelerometer
  * Units: Frequency
* fBodyGyro.mean.X
  * System: Body Gyroscope
  * Units: Frequency
* fBodyGyro.mean.Y
  * System: Body Gyroscope
  * Units: Frequency
* fBodyGyro.mean.Z
  * System: Body Gyroscope
  * Units: Frequency
* fBodyGyro.std.X
  * System: Body Gyroscope
  * Units: Frequency
* fBodyGyro.std.Y
  * System: Body Gyroscope
  * Units: Frequency
* fBodyGyro.std.Z
  * System: Body Gyroscope
  * Units: Frequency
* fBodyGyro.meanFreq.X
  * System: Body Gyroscope
  * Units: Frequency
* fBodyGyro.meanFreq.Y
  * System: Body Gyroscope
  * Units: Frequency
* fBodyGyro.meanFreq.Z
  * System: Body Gyroscope
  * Units: Frequency
* fBodyAccMag.mean
  * System: Body Accelerometer
  * Units: Frequency
* fBodyAccMag.std
  * System: Body Accelerometer
  * Units: Frequency
* fBodyAccMag.meanFreq
  * System: Body Accelerometer
  * Units: Frequency
* fBodyBodyAccJerkMag.mean
  * System: Body Accelerometer
  * Units: Frequency
* fBodyBodyAccJerkMag.std
  * System: Body Accelerometer
  * Units: Frequency
* fBodyBodyAccJerkMag.meanFreq
  * System: Body Accelerometer
  * Units: Frequency
* fBodyBodyGyroMag.mean
  * System: Body Gyroscope
  * Units: Frequency
* fBodyBodyGyroMag.std
  * System: Body Gyroscope
  * Units: Frequency
* fBodyBodyGyroMag.meanFreq
  * System: Body Gyroscope
  * Units: Frequency
* fBodyBodyGyroJerkMag.mean
  * System: Body Gyroscope
  * Units: Frequency
* fBodyBodyGyroJerkMag.std
  * System: Body Gyroscope
  * Units: Frequency
* fBodyBodyGyroJerkMag.meanFreq
  * System: Body Gyroscope
  * Units: Frequency
  
Feature Selection (from original source data)
=================

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
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

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt'
