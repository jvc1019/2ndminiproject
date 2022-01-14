# CMSC 197 (Introduction to Data Science)
# SECOND MINI PROJECT
#
# Submitted by: JAYVEE B. CASTAÑEDA
# B.S. in Computer Science - IV, UPV

# Problem 1

# Change working directory
directory <- "./UCI HAR Dataset"
setwd(directory)

# If package "dplyr" is not already installed, this installs the package
if (!require("dplyr")) {
  install.packages("dplyr")
}
require("dplyr")

# Get all existing data and save them in corresponding variables

# Activity labels and Features
activity_labels <- read.table("./activity_labels.txt", col.names = c("ID", "Description"))
features <- read.table("./features.txt",col.names = c("Name","Signals"))

# Test data
subject_test <- read.table("./test/subject_test.txt", col.names = "Subject")
X_test <- read.table("./test/X_test.txt", col.names = features$Signals)
Y_test <- read.table("./test/y_test.txt", col.names = "ID")

# Train data
subject_train <- read.table("./train/subject_train.txt", col.names = "Subject")
X_train <- read.table("./train/x_train.txt", col.names = features$Signals)
Y_train <- read.table("./train/y_train.txt", col.names = "ID")

# 1. Merges the training and the test sets to create one data set

# Bind subject, test and train data
X_data <- rbind(X_train, X_test)
Y_data <- rbind(Y_train, Y_test)
subject <- rbind(subject_train, subject_test)

# Merge subject, test and train data
merged_data <- cbind(subject, Y_data, X_data)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement

extracted_data <- merged_data %>% select(Subject, ID, contains("mean"), contains("std"))

# 3. Uses descriptive activity names to name the activities in the dataset

extracted_data$ID <- activity_labels[extracted_data$ID, 2]

# 4. Appropriately labels the data set with descriptive variable names

names(extracted_data)[2] = "Activity"
names(extracted_data)<-gsub("Acc", "Accelerometer", names(extracted_data))
names(extracted_data)<-gsub("Gyro", "Gyroscope", names(extracted_data))
names(extracted_data)<-gsub("BodyBody", "Body", names(extracted_data))
names(extracted_data)<-gsub("Mag", "Magnitude", names(extracted_data))
names(extracted_data)<-gsub("^t", "Time", names(extracted_data))
names(extracted_data)<-gsub("^f", "Frequency", names(extracted_data))
names(extracted_data)<-gsub("tBody", "TimeBody", names(extracted_data))
names(extracted_data)<-gsub("-mean()", "Mean", names(extracted_data), ignore.case = TRUE)
names(extracted_data)<-gsub("-std()", "STD", names(extracted_data), ignore.case = TRUE)
names(extracted_data)<-gsub("-freq()", "Frequency", names(extracted_data), ignore.case = TRUE)
names(extracted_data)<-gsub("angle", "Angle", names(extracted_data))
names(extracted_data)<-gsub("gravity", "Gravity", names(extracted_data))

# Write table data in a text file
write.table(extracted_data, "Mean_And_StdDev.txt", row.name=FALSE)

# 5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.

tidy_data <- extracted_data %>%
  group_by(Subject, Activity) %>%
  summarise_all(list(mean))

# Write table data in a text file
write.table(tidy_data, "IndependentTidyData.txt", row.name=FALSE)