# CodeBook
## Transformation steps
* Download the file
```sh
   download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "./zipped_data") 
```
* Unzip the file
```sh
    unzip("./zipped_data")
```
* Read the feature names. These need to set as column names while reading the measurements.
```sh
    feature_variables <- read.table(paste(folder,"/features.txt", sep=""), stringsAsFactors = FALSE, col.names = c("feature_id","feature_name"))
```
* Make the feature names unique, so that we don't get duplicate column names.
```sh
    variable_names <- make.names(feature_variables$feature_name, unique=TRUE)
```
* Read the training data sets. While reading the measurements, set column names using the feature names read before.
```sh
    training_set_subjects <- read.table(paste(folder,"/train/subject_train.txt", sep=""), stringsAsFactors = FALSE, col.names = c("subject_id"))
    training_set_features <- read.table(paste(folder,"/train/X_train.txt", sep=""), stringsAsFactors = FALSE, col.names = variable_names)
    training_set_activities <- read.table(paste(folder,"/train/y_train.txt", sep=""), stringsAsFactors = FALSE, col.names = c("activity_id"))
```
* Combine the different data sets under training data into one.
```sh
    training_set <- cbind(training_set_subjects, training_set_activities, training_set_features)
```
* Read the test data sets. While reading the measurements, sey columns names using the features names read before.
```sh
    test_set_subjects <- read.table(paste(folder,"/test/subject_test.txt", sep=""), stringsAsFactors = FALSE, col.names = c("subject_id"))
    test_set_features <- read.table(paste(folder,"/test/X_test.txt", sep=""), stringsAsFactors = FALSE, col.names = variable_names)
    test_set_activities <- read.table(paste(folder,"/test/y_test.txt", sep=""), stringsAsFactors = FALSE, col.names = c("activity_id"))
```
* Combine the different data sets under test data into one.
```sh
   test_set <- cbind(test_set_subjects, test_set_activities, test_set_features)
```
* Read the activity names.
```sh
   activity_labels <- read.table(paste(folder,"/activity_labels.txt", sep=""), stringsAsFactors = FALSE, col.names = c("activity_id","activity_name"))
```
* Merge the training and test data into one data set.
```sh
    merged_data_set <- rbind(training_set, test_set)
```
* Format column names, removing multiple instances of "." and replacing with one instance of "_".
```sh
   colnames(merged_data_set) <- gsub("(\\.)+$", "", colnames(merged_data_set))
   colnames(merged_data_set) <- gsub("(\\.)+","_", colnames(merged_data_set))
```
* Extract the tidy data. A pipeline is used to avoid intermediate variables. 
    * subject_id, activity_id and columns representing mean and std are selected.
      ```sh
         select(subject_id, activity_id, matches("_(mean|std)_*[XYZ]*$"))
      ```
    * The selected data is merged by activity_id, thereby adding the column called activity_name.
      ```sh
         merge(activity_labels, by="activity_id")
      ```
    * All columns except activity_id is selected.
      ```sh
         select(-activity_id)
      ```
    * The data set is grouped by subject_id and then by activity_name.
    ```sh
      group_by(subject_id, activity_name)
    ```
    * Each column is summarised by calculating the mean.
    ```sh
      summarize_each(c("mean"))
    ```
* Create a file called tidy_data.txt if it does not exist.
```sh
   if(!file.exists("tidy_data.txt")){
            file.create("tidy_data.txt")
   } 
```
* Write the tidy data set into the file created.
```sh
   write.table(tidy_data, "tidy_data.txt", row.names = FALSE)
```
## Tidy Data Set Variables
* #### subject_id
    A number that identifies the subject who took part int he experiment. Values range from 1 to 30.
* #### activity_name
    A string that indicates the name of the activity that the subject did. 
    Values are :
    * LAYING
    * SITTING
    * STANDING
    * WALKING
    * WALKING_DOWNSTAIRS
    * WALKING_UPSTAIRS
* #### tBodyAcc_mean_X
    Mean of all body acceleration mean measurements in the X-axis. It is measured in seconds.
* #### tBodyAcc_mean_Y
    Mean of all body acceleration mean measurements in the Y-axis. It is measured in seconds.
* #### tBodyAcc_mean_Z
    Mean of all body acceleration mean measurements in the Z-axis. It is measured in seconds.
* #### tBodyAcc_std_X
    Mean of all body acceleration standard deviation measurements in the X-axis. It is measured in seconds.
* #### tBodyAcc_std_Y
    Mean of all body acceleration standard deviation measurements in the Y-axis. It is measured in seconds.
* #### tBodyAcc_std_Z
    Mean of all body acceleration standard deviation measurements in the Z-axis. It is measured in seconds.
* #### tGravityAcc_mean_X
    Mean of all gravity acceleration mean measurements in the X-axis. It is measured in time units. It is measured in seconds.
* #### tGravityAcc_mean_Y
    Mean of all gravity acceleration mean measurements in the Y-axis. It is measured in time units. It is measured in seconds.
* #### tGravityAcc_mean_Z
    Mean of all gravity acceleration mean measurements in the Z-axis. It is measured in time units. It is measured in seconds.
* #### tGravityAcc_std_X
    Mean of all gravity acceleration standard deviation measurements in the X-axis. It is measured in time units. It is measured in seconds.
* #### tGravityAcc_std_Y
    Mean of all gravity acceleration standard deviation measurements in the Y-axis. It is measured in seconds.
* #### tGravityAcc_std_Z
    Mean of all gravity acceleration standard deviation measurements in the Z-axis. It is measured in seconds.
* #### tBodyAccJerk_mean_X
    Mean of all mean measurements of jerk signals derived from body acceleration in the X-axis. It is measured in seconds.
* #### tBodyAccJerk_mean_Y
    Mean of all mean measurements of jerk signals derived from body acceleration in the Y-axis. It is measured in seconds.
* #### tBodyAccJerk_mean_Z
    Mean of all mean measurements of jerk signals derived from body acceleration in the Z-axis. It is measured in seconds.
* #### tBodyAccJerk_std_X
    Mean of all standard deviation measurements of jerk signals derived from body acceleration in the X-axis. It is measured in seconds.
* #### tBodyAccJerk_std_Y
    Mean of all standard deviation measurements of jerk signals derived from body acceleration in the Y-axis. It is measured in seconds.
* #### tBodyAccJerk_std_Z
    Mean of all standard deviation measurements of jerk signals derived from body acceleration in the Z-axis. It is measured in seconds.
* #### tBodyGyro_mean_X
     Mean of all mean measurements from gyroscope in the X-axis. It is measured in seconds.
* #### tBodyGyro_mean_Y
    Mean of all mean measurements ofrom gyroscope in the Y-axis. It is measured in seconds.
* #### tBodyGyro_mean_Z
    Mean of all mean measurements from gyroscope in the Z-axis. It is measured in seconds.
* #### tBodyGyro_std_X
    Mean of all standard deviations measurements from gyroscope in the X-axis. It is measured in seconds.
* #### tBodyGyro_std_Y
     Mean of all standard deviations measurements from gyroscope in the Y-axis. It is measured in seconds.
* #### tBodyGyro_std_Z
     Mean of all standard deviations measurements from gyroscope in the Z-axis. It is measured in seconds.
* #### tBodyGyroJerk_mean_X
    Mean of all mean measurements of jerk signals from gyroscope in the X-axis. It is measured in seconds.
* #### tBodyGyroJerk_mean_Y
    Mean of all mean measurements of jerk signals from gyroscope in the Y-axis. It is measured in seconds.
* #### tBodyGyroJerk_mean_Z
    Mean of all mean measurements of jerk signals from gyroscope in the Z-axis. It is measured in seconds.
* #### tBodyGyroJerk_std_X
    Mean of all standard deviation measurements of jerk signals from gyroscope in the X-axis. It is measured in seconds.
* #### tBodyGyroJerk_std_Y
    Mean of all standard deviation measurements of jerk signals from gyroscope in the Y-axis. It is measured in seconds.
* #### tBodyGyroJerk_std_Z
    Mean of all standard deviation measurements of jerk signals from gyroscope in the Z-axis. It is measured in seconds.
* #### tBodyAccMag_mean
    Mean of all mean measurements of body acceleration magnitude. It is measured in seconds.
* #### tBodyAccMag_std
    Mean of all standard deviation measurements of body acceleration magnitude. It is measured in seconds.
* #### tGravityAccMag_mean
    Mean of all mean measurements of gravity acceleration magnitude. It is measured in seconds.
* #### tGravityAccMag_std
    Mean of all standard deviation measurements of gravity acceleration magnitude. It is measured in seconds.
* #### tBodyAccJerkMag_mean
    Mean of all mean measurements of body acceleration jerk signal magnitude. It is measured in seconds.
* #### tBodyAccJerkMag_std
    Mean of all standard deviation measurements of body acceleration jerk signal magnitude. It is measured in seconds.
* #### tBodyGyroMag_mean
    Mean of all mean measurements of gyroscope signal magnitude. It is measured in seconds.
* #### tBodyGyroMag_std
    Mean of all standard deviation measurements of gyroscope signal magnitude. It is measured in seconds.
* #### tBodyGyroJerkMag_mean
    Mean of all mean measurements of gyroscope jerk signal magnitude. It is measured in seconds.
* #### tBodyGyroJerkMag_std
    Mean of all standard deviation measurements of gyroscope jerk signal magnitude. It is measured in seconds.
* #### fBodyAcc_mean_X
    Mean of all mean measurements of body acceleration frequency in X-axis. It is measured in Hertz.
* #### fBodyAcc_mean_Y
    Mean of all mean measurements of body acceleration frequency in Y-axis. It is measured in Hertz.
* #### fBodyAcc_mean_Z
    Mean of all mean measurements of body acceleration frequency in Z-axis. It is measured in Hertz.
* #### fBodyAcc_std_X
    Mean of all standard deviation measurements of body acceleration frequency in X-axis. It is measured in Hertz.
* #### fBodyAcc_std_Y
    Mean of all standard deviation measurements of body acceleration frequency in Y-axis. It is measured in Hertz.
* #### fBodyAcc_std_Z
    Mean of all standard deviation measurements of body acceleration frequency in Z-axis. It is measured in Hertz.
* #### fBodyAccJerk_mean_X
    Mean of all mean measurements of body acceleration jerk frequency in X-axis. It is measured in Hertz.
* #### fBodyAccJerk_mean_Y
    Mean of all mean measurements of body acceleration jerk frequency in Y-axis. It is measured in Hertz.
* #### fBodyAccJerk_mean_Z
    Mean of all mean measurements of body acceleration jerk frequency in Z-axis. It is measured in Hertz.
* #### fBodyAccJerk_std_X
    Mean of all standard deviation measurements of body acceleration jerk frequency in X-axis. It is measured in Hertz.
* #### fBodyAccJerk_std_Y
    Mean of all standard deviation measurements of body acceleration jerk frequency in Y-axis. It is measured in Hertz.
* #### fBodyAccJerk_std_Z
    Mean of all standard deviation measurements of body acceleration jerk frequency in Z-axis.  It is measured in Hertz.
* #### fBodyGyro_mean_X
    Mean of all mean measurements of gyroscope frequency in X-axis. It is measured in Hertz.
* #### fBodyGyro_mean_Y
    Mean of all mean measurements of gyroscope frequency in Y-axis. It is measured in Hertz.
* #### fBodyGyro_mean_Z
    Mean of all mean measurements of gyroscope frequency in Z-axis. It is measured in Hertz.
* #### fBodyGyro_std_X
    Mean of all standard deviation measurements of gyroscope frequency in X-axis. It is measured in Hertz.
* #### fBodyGyro_std_Y
    Mean of all standard deviation measurements of gyroscope frequency in Y-axis. It is measured in Hertz.
* #### fBodyGyro_std_Z
    Mean of all standard deviation measurements of gyroscope frequency in Z-axis. It is measured in Hertz.
* #### fBodyAccMag_mean
    Mean of all mean measurements of body acceleration frequency magnitude. It is measured in Hertz.
* #### fBodyAccMag_std
    Mean of all standard deviation measurements of body acceleration frequency magnitude. It is measured in Hertz.
* #### fBodyBodyAccJerkMag_mean
    Mean of all mean measurements of body acceleration jerk frequency magnitude. It is measured in Hertz.
* #### fBodyBodyAccJerkMag_std
    Mean of all standard deviation measurements of body acceleration jerk frequency magnitude. It is measured in Hertz.
* #### fBodyBodyGyroMag_mean
    Mean of all mean measurements of gyroscope frequency magnitude. It is measured in Hertz.
* #### fBodyBodyGyroMag_std
    Mean of all standard deviation measurements of gyroscope frequency magnitude. It is measured in Hertz.
* #### fBodyBodyGyroJerkMag_mean
    Mean of all mean measurements of gyroscope jerk frequency magnitude. It is measured in Hertz.
* #### fBodyBodyGyroJerkMag_std
    Mean of all standard deviation measurements of gyroscope jerk frequency magnitude. It is measured in Hertz.
