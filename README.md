# CMSC 197 (Introduction to Data Science)
## SECOND MINI PROJECT
### Submitted by: JAYVEE B. CASTAÑEDA
### B.S. in Computer Science - IV, UPV

## Problem 1 README.md File

The R script is called `run_analysis.R` is created to perform the following tasks:
. Merge the training and the test sets to create one data set.
. Extract only the measurements on the mean and standard deviation for each measurement
. Use descriptive activity names to name the activities in the dataset
. Appropriately label the data set with descriptive variable names
. Create a second, independent tidy data set with the average of each variable
for each activity and each subject.

# Dataset

The data set is about Human Activity Recognition Using Smartphones which can be found after downloading the zipped file `UCI_HAR_Dataset.zip`.

# How To Use

1. Download the zipped file `UCI_HAR_Dataset.zip`. Unzip the file and extract it with the folder name `UCI HAR Dataset`. Make sure that the `run_analysis.R` script file is located in the same directory. The script installs the `dplyr` package in case you haven't yet.

# Step-By-Step Procedure

1. Assign each of the following data to corresponding variables
- Features: `features <- features.txt`
- Activities: `activity_labels <- activity_labels.txt`
- Test Subjects: `subject_test <- test/subject_test.txt`
- Test Set: `X_test <- test/X_test.txt`
- Test Labels: `Y_test <- test/y_test.txt`
- Train Subjects: `subject_train <- test/subject_train.txt`
- Train Set: `X_train <- test/X_train.txt`
- Train Labels: `Y_train <- test/y_train.txt`

2. Merges the training and the test sets to create one data set

- The variable X_data is created by merging x_train and x_test using the rbind() function
`X_data <- rbind(X_train, X_test)`

- The variable Y_data is created by merging y_train and y_test using the rbind() function
`Y_data <- rbind(Y_train, Y_test)`

- The variable Subject is created by merging subject_train and subject_test using the rbind() function
`subject <- rbind(subject_train, subject_test)`

- The variable merged_data is created by merging Subject, Y_data and X_data using the cbind() function
`merged_data <- cbind(subject, Y_data, X_data)`

3. Extract only the measurements on the mean and standard deviation for each measurement

- The variable extracted_data is created by making a subset of `merged_data`. Using the `dplyr` function Select, we can select only the columns `Subject`, `ID` and the measurements on the mean and standard deviation denoted by `mean` and `std` respectively.
`extracted_data <- merged_data %>% select(Subject, ID, contains("mean"), contains("std"))`

4. Use descriptive activity names to name the activities in the data set

- Activities in the data are written by numbered ID codes which correspond to their names found in the second column of `activity_labels`. These numbers are also found in the `ID` column of the `extracted_data`. Then, we will replace these values with its corresponding activity.
`extracted_data$ID <- activity_labels[extracted_data$ID, 2]`

5. Appropriately label the data set with descriptive variable names

In this part, we will be renaming some labels/names for clarity

- `ID` column in `extracted_data` renamed into `Activities`
- The `Acc` in any part of a column's name is replaced by `Accelerometer`
- The `Gyro` in any part of a column's name is replaced by `Gyroscope`
- The `Mag` in any part of a column's name is replaced by `Magnitude`
- The `BodyBody` in any part of a column's name is reduced to simply `Body`
- The `t` in any part of a column's name is replaced by `Time`
- The `f` and `-freq()` in any part of a column's name is replaced by `Frequency`
- The `-mean()` in any part of a column's name is replaced by `Mean`
- The `-std()` in any part of a column's name is replaced by `STD`
- The `angle` in any part of a column's name is replaced by `Angle` for consistency
- The `gravity` in any part of a column's name is replaced by `Gravity` for consistency

6. To see the data after this point, we will export `extracted_data` into the `Mean_And_StdDev.txt` file located in the directory.

7. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject

- `tidy_data` is created started with grouping the data in `extracted_data` by subject and activity denoted by `group_by(Subject, Activity)`, then, using the list of the means of each variable for each activity and each subject denoted by `list(mean)`, we summarize it by using the `summarise_all` function.

8. To see the cleaner data after grouping and taking the average, we will export `tidy_data` into the `IndependentTidyData.txt` file located in the directory.