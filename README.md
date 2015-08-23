# Getting-and-Cleaning-Data

This repo explains how all of the scripts written for the Course Project of the Getting and Cleaning course (Coursera) work and how they are connected.  

## Overview 

The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

## Data

A full description of the data is available at the site where the data was obtained: 

> http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The data for the project: 

> https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

In order to run the script run_analysis.R you need to download and unzip the data in a folder called UCI HAR Dataset.

## Script

After you have downloaded the data and set your working directory, you can run the script run_analysis.R. It is composed of the following steps:
>1. Merges the training and the test sets to create one data set.
>2. Extracts only the measurements on the mean and standard deviation for each measurement. 
>3. Uses descriptive activity names to name the activities in the data set
>4. Appropriately labels the data set with descriptive variable names. 
>5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Output

At the end of the script run_analysis.R a txt file called 'tidyData.txt' is created and saved in the working directory. It contains the tidy dataset. 






