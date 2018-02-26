# CourseraDataCleaningCourseProject
Getting and Cleaning Data Course Project on Coursera

The clearing process contains next steps:

0. Reading data
1. Merges the training and the test sets
2. Extracts only the measurements on the mean and standard deviation for each measurement
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
6. Write data to CSV

### 0. Reading data
We read data from "UCI HAR Dataset" folder. This folder contains next data:

* train/subject_train.txt: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
* train/X_train.txt: Training set
* train/y_train.txt: Training labels
* test/subject_test.txt: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
* test/X_test.txt: Test set
* test/y_test.txt: Test labels

We read it in six separate dataframes.

### 1. Merges the training and the test sets
On this step we bind test datasets and train datasets by columns, and after that bind this new two datasets together by rows.

### 2. Extracts only the measurements on the mean and standard deviation for each measurement
After merging we getting variable indexes and names from "UCI HAR Dataset/features.txt". From variable names we choose only those that contains "mean()" or "std()" in their names (to select needed variables).

### 3. Uses descriptive activity names to name the activities in the data set
Getting names of activity by ids from "UCI HAR Dataset/activity_labels.txt". Setting names of activity instead of ids.

### 4. Appropriately labels the data set with descriptive variable names
Removing special characters from variable names. Setting new variable names to dataset.

### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
Grouping by subject and activity and calculating mean of each variable for these groups.

### 6. Write data to CSV
Writing data to file.
