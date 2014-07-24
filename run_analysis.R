setwd("C:/Users/lthroy/Dropbox/Data Science Signature Track/Getting and Cleaning Data/week3")

#Read in datasets X_train.txt,y_train.txt and subject_train.txt

xTrain <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
yTrain <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subTrain <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

#Do the same for the test datasets
xTest <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
yTest <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subTest <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

#Column-bind the training data
train <- cbind(xTrain,yTrain,subTrain)

#Column-bind the test data
test <- cbind(xTest,yTest,subTest)

#Row-bind the training and test data
complete <- rbind(train,test)


#Find out the columns which are measures of Mean
mean.cols <- c(1:3,41:43,81:83,121:123,161:163,201,214,227,240,253,266:268,345:347,424:426,503,516,529,542)

#Extract them to form a data frame called "mean.frame"
mean.frame <- complete[,mean.cols]

#Modify the column names
names(mean.frame) <- c("tBodyAcc.mean.X", "tBodyAcc.mean.Y", "tBodyAcc.mean.Z","tGravityAcc.mean.X","tGravityAcc.mean.Y","tGravityAcc.mean.Z",
                       "tBodyAccJerk.mean.X","tBodyAccJerk.mean.Y","tBodyAccJerk.mean.Z","tBodyGyro.mean.X","tBodyGyro.mean.Y","tBodyGyro.mean.Z",
                       "tBodyGyroJerk.mean.X","tBodyGyroJerk.mean.Y","tBodyGyroJerk.mean.Z","tBodyAccMag.mean","tGravityAccMag.mean",
                       "tBodyAccJerkMag.mean","tBodyGyroMag.mean","tBodyGyroJerkMag.mean","fBodyAcc.mean.X","fBodyAcc.mean.Y","fBodyAcc.mean.Z",
                       "fBodyAccJerk.mean.X","fBodyAccJerk.mean.Y","fBodyAccJerk.mean.Z","fBodyGyro.mean.X","fBodyGyro.mean.Y","fBodyGyro.mean.Z",
                       "fBodyAccMag.mean","fBodyBodyAccJerkMag.mean","fBodyBodyGyroMag.mean","fBodyBodyGyroJerkMag.mean")

#Do the same for the standard deviation measures
std.cols <- c(4:6,44:46,84:86,124:126,164:166,202,215,228,241,254,269:271,348:350,427:429,504,517,530,543)
std.frame <- complete[,std.cols]
names(std.frame) <- c("tBodyAcc.std.X","tBodyAcc.std.Y","tBodyAcc.std.Z","tGravityAcc.std.X","tGravityAcc.std.Y","tGravityAcc.std.Z",
  "tBodyAccJerk.std.X","tBodyAccJerk.std.Y","tBodyAccJerk.std.Z","tBodyGyro.std.X","tBodyGyro.std.Y","tBodyGyro.std.Z",
  "tBodyGyroJerk.std.X","tBodyGyroJerk.std.Y","tBodyGyroJerk.std.Z","tBodyAccMag.std","tGravityAccMag.std","tBodyAccJerkMag.std",
  "tBodyGyroMag.std","tBodyGyroJerkMag.std","fBodyAcc.std.X","fBodyAcc.std.Y","fBodyAcc.std.Z","fBodyAccJerk.std.X",
  "fBodyAccJerk.std.Y","fBodyAccJerk.std.Z","fBodyGyro.std.X","fBodyGyro.std.Y","fBodyGyro.std.Z","fBodyAccMag.std","fBodyBodyAccJerkMag.std",
  "fBodyBodyGyroMag.std","fBodyBodyGyroJerkMag.std")

#Column-bind the mean.frame,std.frame as well as the activity column and the subject column together
output <- cbind(mean.frame,std.frame,activity=complete[,562],subject=complete[,563])

#Use descriptive activity names to name the activities

output$activity <- as.character(output$activity)
output[output$activity=="1","activity"] <- "walking"
output[output$activity=="2","activity"] <- "walkingUp"
output[output$activity=="3","activity"] <- "walkingDown"
output[output$activity=="4","activity"] <- "sitting"
output[output$activity=="5","activity"] <- "standing"
output[output$activity=="6","activity"] <- "laying"
unique(output$activity)

output$activity <- as.factor(output$activity)

#Collapse the data frame, calculate the mean for each combination of activity+subject
agg <- aggregate(. ~ activity+subject,data=output,FUN=mean,na.rm=TRUE)

#write the table
write.table(agg,"./data/UCI HAR Dataset/agg.txt")

