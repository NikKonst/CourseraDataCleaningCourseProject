# This script is designed to getting and process data

# 0. Reading data from file
# Getting train data 
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("UCI HAR Dataset/train/Y_train.txt")

# Getting test data
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("UCI HAR Dataset/test/Y_test.txt")

# 1. Merges the training and the test sets to create one data set
# Firstly, setting names of columns for subject and activity datasets
names(subject_train) <- c("subject")
names(Y_train) <- c("activity")
names(subject_test) <- c("subject")
names(Y_test) <- c("activity")

# Merging datasets
df <- rbind(
     cbind(subject_train, Y_train, X_train),  # train dataset binding by columns
     cbind(subject_test, Y_test, X_test)  # test dataset binding by columns
)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# Getting variable names indexes, which have "mean()" or "std()" in its name
features <- read.table("UCI HAR Dataset/features.txt")  # Getting all variable names
clrVarIdx <- grep("mean()|std()", features$V2)  # Getting indexes of variable, which have "mean()" or "std()" in its name
