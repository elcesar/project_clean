Introduction
=============

The purpose of this project is collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

About the Data
=============
One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Objectives
=============
R script called run_analysis.R that does the following. 
 - Merges the training and the test sets to create one data set.
 - Extracts only the measurements on the mean and standard deviation for each measurement. 
 - Uses descriptive activity names to name the activities in the data set
 - Appropriately labels the data set with descriptive variable names. 
 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
 
How to use
============= 
The R script conteins 02 functions:
- merge_files. Objective.  Merge the data from test and train source and calculate the mean from each column
- clean_data. Objective. read the source files and obtain only the selected columns and rename the column names and the activity labels with descriptive names.
The output will be used in the merge_files function.
- 
To execute. Run the merge_files() function. using the default parameters, to generate output.txt with the mean of each variable group by Subject and Activity.

assumption: The data source exists in the working directory in a folder called: "UCI HAR Dataset". It's possible change the data source by changing the input parameters of this function.
