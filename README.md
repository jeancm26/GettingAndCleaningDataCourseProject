# Course Project

The objetive of the project is to collect, process and clean a data set whose topic is "Human Activity Recognition Using Smartphones ", which contains data from 30 volunteers between 19 and 48 years, who are using a Samsung Galaxy S II device and developed a set of activities recorded their movements through the accelerometer and gyroscope mobile device.

To fulfillment the main objective it was established five (5) question and they listed bellow:

1) Merges the training and the test sets to create one data set.
```
DataTrain <- read.table("./train/X_train.txt")
LabelTrain <- read.table("./train/y_train.txt")
SubjectTrain <- read.table("./train/subject_train.txt")
DataTest <- read.table("./test/X_test.txt")
LabelTest <- read.table("./test/y_test.txt")
SubjectTest <- read.table("./test/subject_test.txt")
#All Data
Data <- rbind(DataTest, DataTrain)
Label <- rbind(LabelTest, LabelTrain)
Subject <- rbind(SubjectTest, SubjectTrain)
```


2. Extracts only the measurements on the mean and standard deviation for each measurement.
```
Features <- read.table("./features.txt")
Data <- Data[,grep(pattern =  "mean\\(\\)|std\\(\\)",x =  Features$V2)]
```

3. Uses descriptive activity names to name the activities in the data set
```
Activity <- read.table("./activity_labels.txt")
Activity[, 2] <- tolower(gsub("_", "", Activity[, 2]))
substr(Activity[2, 2], 8, 8) <- toupper(substr(Activity[2, 2], 8, 8))
substr(Activity[3, 2], 8, 8) <- toupper(substr(Activity[3, 2], 8, 8))
LabelActivity <- Activity[Label[, 1], 2]
Label[, 1] <- LabelActivity
names(Label) <- "Activity"
names(Data) <- gsub("\\(\\)", "", Features[grep(pattern =  "mean\\(\\)|std\\(\\)",x =  Features$V2), 2])
names(Data) <- gsub("mean", "Mean", names(Data))
names(Data) <- gsub("std", "Std", names(Data))
names(Data) <- gsub("-", "", names(Data))
```

4. Appropriately labels the data set with descriptive variable names.
```
names(Subject) <- "Subject"
Data <- cbind(Subject, Label, Data)
```

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
```
DataAverage <- ddply(Data, .(Subject, Activity), function(x) colMeans(x[, 3:68]))
write.table(x = DataAverage, file = "Data.txt", row.names = FALSE)
```

___
####Result
1. The result is a tidy data its contains the mean and standard deviation of each measurement.
2. The result is stored in a file named Data.txt in the working directory.

___
####Notes
1. The data must be in the working directory.
2. The library "plyr" is used.
