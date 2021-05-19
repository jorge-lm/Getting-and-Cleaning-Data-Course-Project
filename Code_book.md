# CODE BOOK

## LOAD LIBRARIES
### For this scrip we're using to the library "dplyr", this library is famous for the easy drive for the data bases.

## DOWNLOAD AND READ FILES
### 1. The download for the activity is a "zip" file, that once downloaded the file, we use the unzip funtion for decompress.

## NOTE: I recommend configured the work directory the setwd() funtions

### 2. Loading the "txt" files for the Test, Train, and the Features and Labels activity, with the read.table() funtion:
|Variable  | Code| Dimensions |
-----------|-----|-------------------------------------------|
| features | <- read.table("features.txt",header = F) |
| labels_act | <- read.table("activity_labels.txt",header = F) |

| subject_test | <- read.table("test/subject_test.txt",header = F) |
| x_test | <- read.table("test/X_test.txt",header = F) |
| y_test | <- read.table("test/y_test.txt",header = F) |

| subject_train | <- read.table("train/subject_train.txt",header = F) |
| x_train | <- read.table("train/X_train.txt",header = F) | 
| y_train | <- read.table("train/y_train.txt",header= F) |

## CREATING A GENERAL BASE
### Once 

