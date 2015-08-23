# Getting and Cleaning Data Code Book

This file describes the data and any transformations or work that was performed to clean up the data.

## Source Data

There are 8 datasets needed for this Course Project:

* activity_labels.txt: Links the class labels with their activity name.
* features.txt: List of all features.
* subject_test.txt: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
* X_test.txt: Test set.
* y_test.txt: Test labels.
* subject_train.txt: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
* X_train.txt: Trainig set.
* y_train.txt: Training labels.

## Modifications

### Section 1

Datasets subject_test, X_test, y_test, subject_train, X_train and y_train were merged to train.test.data.

### Section 2

Extracts from the dataset train.test.data created in Section 1 only the measurements on the mean and standard deviation.

### Section 3

Datasets train.test.data and activity_labels are joined and activity labels are modified in the following way:

* strings are converted to its lower case
* '_' is removed
* 'walkingupstairs' is converted to 'walkingUpstairs'
* 'walkingdownstairs' is converted to 'walkingDownstairs'

### Section 4

Column names are changed to descriptive variable names:

* '()' is removed
* 'std' is changed to 'StdDev'
* 'mean' is changed to 'Mean'
* 't' in the first place is replaced with 'Time'
* 'f' in the first place is replaced with 'Freq'

### Section 5

A copy of the dataset created in Section 4 is made, then aggregated by Activity and Subject and the Activity labels are joined to the newly created dataset.







