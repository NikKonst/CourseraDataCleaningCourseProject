# This script is designed to getting and process data
library(dplyr)
library(utils)

# 0. Reading data from file
# Getting train data 
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("UCI HAR Dataset/train/y_train.txt")

# Getting test data
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("UCI HAR Dataset/test/y_test.txt")

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

# Subsetting dataframe
clrVarIdxDF <- clrVarIdx + 2  # We add two columns to dataset (subject and activity), so adding 2 for true indexing
df <- df[c(1, 2, clrVarIdxDF)]  # Getting only subject, activity and columns with measurements on the mean and standard deviation 

# 3. Uses descriptive activity names to name the activities in the data set
activity <- read.table("UCI HAR Dataset/activity_labels.txt")  # Getting activity ids and names
df$activity <- activity$V2[df$activity]  # Setting name of activity instead of activity id

# 4. Appropriately labels the data set with descriptive variable names.
varNames <- gsub(",|-|\\(|\\)", "", features$V2)  # Creating new column names without especial characters
varOldNames <- paste("V", clrVarIdx, sep = "")  # Variable names in current data frame
colnames(df) <- c(colnames(df)[1], colnames(df)[2], varNames[clrVarIdx])  # Setting new variable names
colnames(df) <- sapply(colnames(df), tolower)  # Setting variable names to lowercase

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
# for each activity and each subject.

df <- tbl_df(df)  # Converting dataframe to tbl dataframe
tidyDF <- df %>% group_by(subject, activity) %>% summarise_all(mean)  # Grouping by subject and activity and calculating mean

# Write data to CSV
write.table(tidyDF, file = "res.txt", row.names = FALSE)
