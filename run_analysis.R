#-----------------------Final Activity ----------------------------
#......................Load the libraries -------------------------
library(dplyr)

#----------------------Download and read files--------------------------------
setwd("/Users/jorgelimas/Documents/MOOCs/COURSERA/Data Science (Specialized) -The John Hopkins University/3. Getting and cleaning data/")
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,"uci_hard.zip",mode='wb')
unzip("uci_hard.zip")

setwd("/Users/jorgelimas/Documents/MOOCs/COURSERA/Data Science (Specialized) -The John Hopkins University/3. Getting and cleaning data/UCI HAR Dataset/")

features<-read.table("features.txt",header = F)
labels_act<-read.table("activity_labels.txt",header = F)

subject_test<-read.table("test/subject_test.txt",header = F)
x_test<-read.table("test/X_test.txt",header = F)
y_test<-read.table("test/y_test.txt",header = F)

subject_train<-read.table("train/subject_train.txt",header = F)
x_train<-read.table("train/X_train.txt",header = F)
y_train<-read.table("train/y_train.txt",header= F)

#-------------- Creating a general data base ----------------------- 
test_data<-data.frame(subject_test,x_test,y_test)
names(test_data)<-c("subject",features$V2,"label_act")
train_data<-data.frame(subject_train,x_train,y_train)
names(train_data)<-c("subject",features$V2,"label_act")

general_data<- rbind(test_data,train_data)

#---------------Extracts only the measurements on the mean and standard deviation for each measurement---------------------
tidy_data<-general_data %>% select(subject,label_act,contains("mean"),contains("std")) %>% arrange(subject)
View(tidy_data)

#--------------- Uses descriptive activity names to name the activities in the data set----------------------
tidy_data$id<-labels_act[tidy_data$label_act,2]

#-------------- Appropriately labels the data set with descriptive variable names------------------------
names(tidy_data) <-gsub("Acc", "Accelerometer", names(tidy_data))
names(tidy_data) <-gsub("Gyro", "Gyroscope", names(tidy_data))
names(tidy_data) <-gsub("BodyBody", "Body", names(tidy_data))
names(tidy_data) <-gsub("Mag", "Magnitude", names(tidy_data))
names(tidy_data) <-gsub("^t", "Time", names(tidy_data))
names(tidy_data) <-gsub("^f", "Frequency", names(tidy_data))
names(tidy_data) <-gsub("tBody", "TimeBody", names(tidy_data))
names(tidy_data) <-gsub("-mean()", "Mean", names(tidy_data), ignore.case = TRUE)
names(tidy_data) <-gsub("-std()", "STD", names(tidy_data), ignore.case = TRUE)
names(tidy_data) <-gsub("-freq()", "Frequency", names(tidy_data), ignore.case = TRUE)
names(tidy_data) <-gsub("angle", "Angle", names(tidy_data))
names(tidy_data) <-gsub("gravity", "Gravity", names(tidy_data))

#-------------- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject-------------
last_data <- tidy_data %>% group_by(subject,id) %>% summarise_all(mean)
View(last_data)

#--------------- Export the last_data---------------------
write.table(last_data,"final_database.txt",row.names = F)


