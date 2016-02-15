## read data 
> dataActTest <- read.table("./test/Y_test.txt", header = TRUE)
> dataActTrain <- read.table("./train/Y_train.txt", header = TRUE)
> dataSubjTest <- read.table("./test/subject_test.txt", header = FALSE)
> dataSubjTrain <- read.table("./train/subject_train.txt", header = FALSE)
> dataActTest <- read.table("./test/Y_test.txt", header = FALSE)
> dataActTrain <- read.table("./train/Y_train.txt", header = FALSE)
> dataFeatTest <- read.table("./test/x_test.txt", header = FALSE)
> dataFeatTrain <- read.table("./train/x_train.txt", header = FALSE)
## combine data & assign column names
dataSubject <-rbind(dataSubjTrain, dataSubjTest)
> dataActivity <- rbind(dataActTrain,dataActTest)
> dataFeature <- rbind(dataFeatTrain, dataFeatTest)
> names(dataSubject) <- c("subject")
> names(dataActivity) <- c("activity")
> dataFeatureNames <- read.table("features.txt", header = FALSE)
> names(dataFeature) <- dataFeatureNames$V2
> ## merge column 
> dataCombo <- cbind(dataSubject,dataActivity)
> data <- cbind(dataFeature,dataCombo)
## extract mean and std
> subdataFeatNames <- dataFeatureNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeatureNames$V2)]
> selectedNames <- c(as.character(subdataFeatNames),"subject","activity")
> data <- subset(data, select = selectedNames)
> activityLabels <- read.table("activity_labels.txt", header = FALSE)
## replace names 
> names(data) <- gsub("^t","time", names(data))
> names(data) <- gsub("^f","frequency", names(data))
> names(data) <- gsub("Acc","Accelerometer", names(data))
> names(data) <- gsub("Gyro","Gyroscope", names(data))
> names(data) <- gsub("Mag","Magnitude", names(data))
> names(data) <- gsub("BodyBody","Body", names(data))
## create tidy data set 
> library(plyr)
> data2 <- aggregate(. ~subject + activity, data, mean)
> data2 <- data2[order(data2$subject,data2$activity),]
> write.table(data2, file = "tidydata.txt", row.names = FALSE)
