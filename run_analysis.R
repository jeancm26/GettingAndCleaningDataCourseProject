library(plyr)

# 1.- Merges the training and the test sets to create one data set.
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

# 2.- Extracts only the measurements on the mean and standard deviation for each measurement. 
Features <- read.table("./features.txt")
Data <- Data[,grep(pattern =  "mean\\(\\)|std\\(\\)",x =  Features$V2)]

# 3.- Uses descriptive activity names to name the activities in the data set
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

# 4.- Appropriately labels the data set with descriptive activity names. 
names(Subject) <- "Subject"
Data <- cbind(Subject, Label, Data)

# 5.- Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
DataAverage <- ddply(Data, .(Subject, Activity), function(x) colMeans(x[, 3:68]))
write.table(x = DataAverage, file = "Data.txt", row.names = FALSE)

#Erase Test and Train Data
rm(list = c("DataTest","DataTrain","LabelTest","LabelTrain", "SubjectTest", "SubjectTrain", "Activity", "LabelActivity"))
