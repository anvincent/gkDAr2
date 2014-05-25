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


Read me details for run_analysis.R
================================

Objectives
--------------------------------
1. Build "Base Dataset". "Base Dataset" is defined as bringing in all data from all files within the zip. This dataset forms the basis for subsequent cleansing and analysis. Instruction sets used to build this dataset include numbers 1, 2, 4, and 5.
2. Build "Tidy Set 1". "Tidy Set 1" is defined as the "Base Dataset" transformed by only focusing on the mean and standard deviation variables. Instruction sets used to build this dataset include number 3.
3. Build "Tidy Set 2". "Tidy Set 2" is defined as the "Tidy Set 1" transformed by calculating the mean of each variable. Instruction sets used to build this dataset include numbers 6.
4. Export "Tidy Set 2" into a CSV file in the working directory. Instruction sets used to build this dataset include numbers 6.

Workflow
--------------------------------
The program is designed to obtain a set of flat files zipped together at a predefined download location as specified in the project documentation.

1. Locate all files from pre-defined zip file and download a list of files to import
2. Assemble helper functions from attached "data_import_lib.R"
  * This includes setting key parameters including defining data groups (label, data, ignore, files to import)
3. Build base dataframe. All other cleansing and analysis was based on this set. This executes in the following manner:
  * Load all data as individual data files.
  * Divide data files between train and test sets.
  * Bind each set of columns.
  * Union train and test sets.
4. Build "Tidy Set 1". Tidy Set 1 is defined above in the objectives section. This executes in the following manner:
  * Scan dataframe and build a list of column names that related to mean or standard deviaiton data.
  * Extract the columns from the dataframe based on the list built above.
5. Write "Tidy Set 1" to CSV.
6. Build "Tidy Set 2". "Tidy Set 2" is defined above in the objectives section. This executes in the following manner:
  * Enable reshape2 library
  * Melt "Tidy Set 1" between id columns (Subject and Activity Labels), and data (the remainder of columns)
  * Cast the new data set based on the identifiers and executing the mean function
7. Write "Tidy Set 2" to CSV.

File Structure
--------------------------------
The following files are implemented as a part of this solution:
* run_analysis.R [Main Program]
* "data_import_lib.R" [Program Libraries and auxilury functions]


Assumptions
--------------------------------
* Source data is located at the zip file link above and automatically downloaded
* Parameters limit the cleansing and analysis by excluding inertial signals.

Program Library
--------------------------------
* run_analysis.R()
  * Main program.
* getZippedData(sourceLink)
  * DEPRECIATED
  * param: sourceLink : WWW link to zip file
  * Downloads and extracts the zipfile provided by "sourceLink"
* substrRight(x, n)
  * param: x : string to 
  * param: n : number of characters to keep, starting from the right
  * Extracts a defined number of characters "n" counted from the right in string "x"
* substrLeft(x, n)
  * param: x : string to 
  * param: n : number of characters to keep, starting from the left
  * Extracts a defined number of characters "n" counted from the left in string "x"
* setParameters(fileList,option="full")
  * param: fileList : List of files to scan.
  * param: option : Sets the option between performing the objectives against the entire dataset, or excluding inertial signals. Please note: if you include the inertial signals (via option="full"), the script requires anywhere from 30-75 minutes to execute and may require up to 300 Mb of disk space. Default is set to "full".
  * Sets a variety of properties required to execute the program including files that do not contain data or are to be ignored, builds the list of files to import, and sets variables to which the dataset will be measured against.
* directoryUpload(directoryPath="./")
  * param: directoryPath : Path to directory.
  * Builds a list of data files based on a directory path passed in "directoryPath". This defaults to the current working directory.
* fileUpload(pathToFile,group="")
  * param: pathToFile : Path to the file that is to be uploaded.
  * param: group : Name of group (i.e. test or train).
  * Returns a dataframe based upon a file passed to it by its path "pathToFile". The file must be a txt file with no header and space delimited. Using the optional group parameter, one can analyze and include classification around which group the dataframe should end with (i.e. test, or train).
* buildData(data,labels,groups)
  * param: data : Vector containing names to be interpreted as file locations to be uploaded.
  * param: labels : Vector containing names to be interpreted as labels (i.e. activities, etc)
  * param: groups : Vector containing names to be interpreted as groups (i.e. test or train)
  * Builds the "Base Dataset" by analyzing all of the directories and files in the path, determining which are data versus label files, and categorizing them into groups.
* mergeActivityLabels(df,labels,mergeBy)
  * param: df : Dataframe containing label indicies that are to be replaced with labels.
  * param: labels : Dataframe containing activity labels.
  * param: mergeBy : Vector defining how to merge the activity labels with the dataset.
  * Merges activity names to their indicies within the dataset.
* renameColumns(df,label)
  * param: df : Dataframe containing column names to be updated.
  * param: label : List of descriptive column names to use.
  * Updates feature column names into "." delimited descriptive column names.
* carve.mean.std(df,colNames)
  * param: df : Dataframe containing columns to be removed.
  * param: colNames : Key attributes to use when reducing the dataframes' columns
  * Reduces the dataframe based upon key attributes passed into as "colNames".