# Code Book

 ## Human Activity Recognition Using Smartphones Data Set

Source: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#

### Read - Convert - Merge
 Read data from X_train, Y_train and subject_train and convert data to tabular form Train

Read data from X_test, Y_test and subject_test and convert data to tabular form Test

Train -> the variable for data obtained from X_train, Y_train and subject_train

Test -> the variable for data obtained from X_test, Y_test and subject_test

allData -> variable used for merged data set

### Proper labeling of data sets

*Replace existing labels using the gsub function

names -> variable for the data set labels

nameNew -> variable for the replaced labels

### Create tidy data set with the average of each variable for each activity and each subject
aggregate() function

write.table() function
