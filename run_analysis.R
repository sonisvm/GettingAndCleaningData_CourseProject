library(dplyr)

run_analysis <- function() {
  
    #Download and unzip data
    #download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "./zipped_data")
    #unzip("./zipped_data")
    if(file.exists("UCI HAR Dataset")){
        folder <- "UCI HAR Dataset"
        
        #Read the feature variable names
        feature_variables <- read.table(paste(folder,"/features.txt", sep=""), stringsAsFactors = FALSE, col.names = c("feature_id","feature_name"))
        
        #Make the names unique, so that we don't run into duplicate column name issue
        variable_names <- make.names(feature_variables$feature_name, unique=TRUE )
        
        print("Reading Training Data...")
        
        #Read all the data from training set
        training_set_subjects <- read.table(paste(folder,"/train/subject_train.txt", sep=""), stringsAsFactors = FALSE, col.names = c("subject_id"))
        training_set_features <- read.table(paste(folder,"/train/X_train.txt", sep=""), stringsAsFactors = FALSE, col.names = variable_names)
        training_set_activities <- read.table(paste(folder,"/train/y_train.txt", sep=""), stringsAsFactors = FALSE, col.names = c("activity_id"))
        
        #Merge the data into one data set
        training_set <- cbind(training_set_subjects, training_set_activities, training_set_features)
        
        print("Reading Test Data...")
        
        #Read all the data from test set
        test_set_subjects <- read.table(paste(folder,"/test/subject_test.txt", sep=""), stringsAsFactors = FALSE, col.names = c("subject_id"))
        test_set_features <- read.table(paste(folder,"/test/X_test.txt", sep=""), stringsAsFactors = FALSE, col.names = variable_names)
        test_set_activities <- read.table(paste(folder,"/test/y_test.txt", sep=""), stringsAsFactors = FALSE, col.names = c("activity_id"))
        
        #Merge the data into one data set
        test_set <- cbind(test_set_subjects, test_set_activities, test_set_features)
        
        #Read the activity labels 
        activity_labels <- read.table(paste(folder,"/activity_labels.txt", sep=""), stringsAsFactors = FALSE, col.names = c("activity_id","activity_name"))
        
        print("Merging Data...")
        
        #Merge training and test data sets
        merged_data_set <- rbind(training_set, test_set)
        
        #Make the columns names descriptive
        colnames(merged_data_set) <- gsub("(\\.)+$", "", colnames(merged_data_set))
        colnames(merged_data_set) <- gsub("(\\.)+","_", colnames(merged_data_set))
        
        print("Tidying Data...")
        
        #Extract the tidy data
        tidy_data <-  merged_data_set %>% select(subject_id, activity_id, matches("_(mean|std)_*[XYZ]*$")) %>% merge(activity_labels, by="activity_id") %>% select(-activity_id) %>% group_by(subject_id, activity_name) %>% summarize_each(c("mean"))
        
        #Create the file to store the data              
        if(!file.exists("tidy_data.txt")){
            file.create("tidy_data.txt")
        }               
        
        print("Writing Data into File...")
        
        #Write into file
        write.table(tidy_data, "tidy_data.txt", row.names = FALSE)
        
        print("Analysis Completed.")
        
    } else {
        print("Required folder missing!")
    }
}
