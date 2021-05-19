# CODE BOOK

## LOAD LIBRARIES
### For this scrip we're using to the library "dplyr", this library is famous for the easy drive for the data bases.

## DOWNLOAD AND READ FILES
### 1. The download for the activity is a "zip" file, that once downloaded the file, we use the unzip funtion for decompress.

## NOTE: I recommend configured the work directory the setwd() funtions

### 2. Loading the "txt" files for the Test, Train, and the Features and Labels activity, with the read.table() funtion:
|Variable  | Code| Dimensions |
|-----------|-----|-------------------------------------------|
| features | <- read.table("features.txt",header = F) | 561,2
| labels_act | <- read.table("activity_labels.txt",header = F) | 6,2
| subject_test | <- read.table("test/subject_test.txt",header = F) | 2947,1
| x_test | <- read.table("test/X_test.txt",header = F) | 2947,561
| y_test | <- read.table("test/y_test.txt",header = F) | 2947,1
| subject_train | <- read.table("train/subject_train.txt",header = F) | 7352,1
| x_train | <- read.table("train/X_train.txt",header = F) | 7352,561
| y_train | <- read.table("train/y_train.txt",header= F) | 7352,1

## CREATING A GENERAL DATABASE
### Once the files are uploaded, creating two databases:
| Variable  | Compositions |
|-----------|-------------------------|
| test_data | data.frame(subject_test,x_test,y_test) |
| train_data| data.frame(subject_train,x_train,y_train)|

### How the databases hasn't the column names, we aplicated the next code:
#### names(test_data)<-c("subject",features$V2,"label_act")
#### names(train_data)<-c("subject",features$V2,"label_act")

### And finally, creating the general database, result the combined the test ans train tables in your rows:
#### general_data<- rbind(test_data,train_data)

## EXTRACS THE MEAN ANS STANDARD DESVIATION
### The "tidy_data" is create with only subject, label_act and columns with contain the mean and std.
### general_data %>% select(subject,label_act,contains("mean"),contains("std")) %>% arrange(subject)

## USES DESCRIPTIVE ACTIVITY NAMES TO NAME THE ACTIVITIES
### In this step, we will assign the categorical description according the labels_act table:
### tidy_data$id<-labels_act[tidy_data$label_act,2]

## APPROPRIATELY LABELS THE DATA SET

### Using the gsub() funtion in the next form: names(tidy_data) <-gsub("Gyro", "Gyroscope", names(tidy_data)).
### we substitute according to the following table:

| |to replace|
|-------|----------------|
| "Acc"| "Accelerometer"|
| "Gyro" | "Gyroscope"|
|"BodyBody" | "Body"|
|"Mag" | "Magnitude"|
|"^t" | "Time"|
|"^f" | "Frequency"|
|"tBody" | "TimeBody"|
|"-mean()" | "Mean"|
|"-std()"| "STD"|
|"-freq()" | "Frequency"|
|"angle",|"Angle"|
|"gravity" | "Gravity"|

## CREATES A SECOND TIDY DATA
###  To summarize completely, we group by subject and label_act, creating with thw average for each group.
last_data <- tidy_data %>% group_by(subject,label_act) %>% summarise_all(mean)

##EXPORT THE FINAL DATABASE
### For last exporting the last_data in format "txt":
### write.table(last_data,"final_database.txt",row.names = F)


