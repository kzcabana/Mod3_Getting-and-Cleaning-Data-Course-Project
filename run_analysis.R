if (!file.exists('./Module3Project')){
  dir.create("./Module3Project")
}
setwd("~/Module3Project")

##Downloading File 

fileurl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists("./UCI HAR Dataset")){
  download.file(fileurl,'UCI HAR Dataset.zip', mode = 'wb')
  unzip("UCI HAR Dataset.zip", exdir = getwd())
}

##Read and Convert Data

library(data.table)
setwd("~/Module3Project/UCI HAR Dataset")
features <- read.csv('features.txt', header = FALSE, sep = ' ')
features <- as.character(features[,2])

train.X <- read.table('./train/X_train.txt')
train.Y <- read.csv('./train/y_train.txt', header = FALSE, sep = ' ')
trainSubject <- read.csv('./train/subject_train.txt',header = FALSE, sep = ' ')

Train<-  data.frame(trainSubject, train.Y, train.X)
names(Train) <- c(c('subject', 'activity'), features)

test.X <- read.table('./test/X_test.txt')
test.Y <- read.csv('./test/y_test.txt', header = FALSE, sep = ' ')
testSubject <- read.csv('./test/subject_test.txt', header = FALSE, sep = ' ')

Test <-  data.frame(testSubject, test.Y, test.X)
names(Test) <- c(c('subject', 'activity'), features)


## 1--Merges the Training and Testing Sets into 1 data set

allData <- rbind(Train, Test)

## 2--Extracts only the measurements on the mean and standard deviation for each measurement

mean_std <- grep('mean|std', features)
sub <- allData[,c(1,2,mean_std + 2)]

## 3--Uses descriptive activity names to name the activities in the data set

activityLabels <- read.table('activity_labels.txt', header = FALSE)
activityLabels <- as.character(activityLabels[,2])
sub$activity <- activityLabels[sub$activity]

## 4--Appropriately labels the data set with descriptive variable names.

nameNew <- names(sub)
nameNew <- gsub("[(][)]", "", nameNew)
nameNew <- gsub("^t", "TimeDomain", nameNew)
nameNew <- gsub("^f", "FrequencyDomain", nameNew)
nameNew <- gsub("Acc", "Accelerometer", nameNew)
nameNew <- gsub("Gyro", "Gyroscope", nameNew)
nameNew <- gsub("Mag", "Magnitude", nameNew)
nameNew <- gsub("-mean-", " Mean ", nameNew)
nameNew <- gsub("-std-", " StandardDeviation ", nameNew)
nameNew <- gsub("-", "_", nameNew)
names(sub) <- nameNew

## 5--Create a second, independent tidy data set with the average of each variable for each activity and each subject.

tidyData <- aggregate(sub[,3:81], by = list(activity = sub$activity, subject = sub$subject),FUN = mean)
write.table(x = tidyData, file = "tidydata.txt", row.names = FALSE)

