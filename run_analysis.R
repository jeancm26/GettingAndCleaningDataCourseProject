rm(list = ls())
Features <- read.table(file = "./UCI HAR Dataset/features.txt")
#Leer registros Test
SubjectTest <- read.table(file = "./UCI HAR Dataset/test/subject_test.txt")
X_Test <- read.table(file = "./UCI HAR Dataset/test/X_test.txt")
Y_Test <- read.table(file = "./UCI HAR Dataset/test/Y_test.txt")
#Combinar todos los objetos a Test
Test <- X_Test
names(x = Test) <- paste(Features$V2, "_Test", sep = "")
Test<-subset(x = Test, select = grepl(pattern = "mean", x = names(Test)) | grepl(pattern = "std", x = names(Test)))
Test$Y_Test <- Y_Test$V1
Test$Subject_Test <- SubjectTest$V1

#Leer registros Train
SubjectTrain <- read.table(file = "./UCI HAR Dataset/train/subject_train.txt", nrows = 2947)
X_Train <- read.table(file = "./UCI HAR Dataset/train/X_train.txt", nrows = 2947)
Y_Train <- read.table(file = "./UCI HAR Dataset/train/Y_train.txt", nrows = 2947)
#Combinar todos los objetos a Test
Train <- X_Train
names(x = Train) <- paste(Features$V2, "_Train", sep = "")
Train<-subset(x = Train, select = grepl(pattern = "mean", x = names(Train)) | grepl(pattern = "std", x = names(Train)))
Train$Y_Train <- Y_Train$V1
Train$Subject_Train <- SubjectTrain$V1

Data <- cbind(Test, Train)

Subjects<-sapply(unique(Data$Subject_Train), function(x) Data[Data$Subject_Train == x,])
Subjects<-sapply(X = Subjects[,], FUN = mean, simplify = TRUE)
write.table(x = Subjects, file = "Train.txt", row.names = FALSE)

#Borrar Registros
rm(list = c("X_Test", "Y_Test", "Features", "SubjectTest", "X_Train", "Y_Train", "SubjectTrain"))

