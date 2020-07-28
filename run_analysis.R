library(dplyr)

# Importing test data
x_test <- read.table("~/Desktop/Coursera/R/Course3/UCI HAR Dataset/X_test.txt", header = FALSE)
y_test <- read.table("~/Desktop/Coursera/R/Course3/UCI HAR Dataset/Y_test.txt", header = FALSE)
subject_test <- read.table("~/Desktop/Coursera/R/Course3/UCI HAR Dataset/subject_test.txt", header = FALSE)

# Importing train data
x_train <- read.table("~/Desktop/Coursera/R/Course3/UCI HAR Dataset/X_train.txt", header = FALSE)
y_train <- read.table("~/Desktop/Coursera/R/Course3/UCI HAR Dataset/Y_train.txt", header = FALSE)
subject_train <-  read.table("~/Desktop/Coursera/R/Course3/UCI HAR Dataset/subject_train.txt", header = FALSE)

# Importing variable names
variable_list <- read.table("~/Desktop/Coursera/R/Course3/UCI HAR Dataset/features.txt", header = FALSE)

# Importing activity lables
activity_labels <- read.table("~/Desktop/Coursera/R/Course3/UCI HAR Dataset/activity_labels.txt")

# Creating variables names in data 
colnames(x_test) <- variable_list[,2]
colnames(x_train) <- variable_list[,2]
colnames(y_test) <- "activity_id"
colnames(y_train) <- "activity_id"
colnames(subject_train) <- "subject_id"
colnames(subject_test) <- "subject_id"
colnames(activity_labels) <- c("activity_id", "activity_name")


# MERGING DATA 
# 1. Merging test data
merge_test <- cbind(y_test, subject_test, x_test)

# 2. Merging train data
merge_train <- cbind(y_train, subject_train, x_train)

# 3. Merging all data
merge_final <- rbind(merge_test, merge_train)


# Extracting data on mean and standard deviation
some <- colnames(merge_final)
var_list <- (grepl("activity_id", some) | grepl("subject_id", some) | grepl("std..", some) | grepl("mean..", some))
merge_final_1 <- merge_final[,var_list]

# Adding description to activities

merge_final_2 <- merge(merge_final_1,activity_labels, by= "activity_id", all = TRUE )

# Creating independent tidy data set with the average of each variable for each activity and each subject.
tidy_data <- merge_final_2 %>% group_by(activity_name, subject_id) %>% summarize_each(funs(mean))

# Writing file to local drive
write.table(tidy_data, "~/Desktop/Coursera/R/Course3/UCI HAR Dataset/tidy_data.txt", row.names = FALSE, col.names = TRUE)

