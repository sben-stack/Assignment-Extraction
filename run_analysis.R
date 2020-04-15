# libraries
library(dplyr)
library(tidyr)

# Overarching variables needed 
# Activities stored in factor "labels"
        labels <- read.csv("data/activity_labels.txt", sep=" ", header = FALSE)
        names(labels)=c("label","activity")
# Features stored in factor "features"
        features <- as.vector(read.csv("data/features.txt", sep =" ", header=FALSE)[,2])
        
## Create the test data set ##
# read subjects, separator ="" to take into account multiple spaces in a row
        test_subjects <- read.table("data/test/subject_test.txt", sep="", header = FALSE)
#read labels
        test_labels <- read.table("data/test/y_test.txt", sep=" ", header = FALSE)
#read feature data
        test_features <- read.table("data/test/X_test.txt", sep="", header = FALSE)
# add the correct column names
        colnames(test_features) <- features
# add the subjects and labels to the dataframe
        test <- as.data.frame(c(test_features, test_labels, test_subjects))
        colnames(test) <- c(colnames(test_features), "label", "subject")
# replace label numbers by actual activity
        test <- merge(test, labels, by="label")
        
        
## Create the training data set ##
# read subjects, separator ="" to take into account multiple spaces in a row
        train_subjects <- read.table("data/train/subject_train.txt", sep="", header = FALSE)
#read labels
        train_labels <- read.table("data/train/y_train.txt", sep=" ", header = FALSE)
#read feature data
        train_features <- read.table("data/train/X_train.txt", sep="", header = FALSE)
# add the correct column names
        colnames(train_features) <- features
# add the subjects and labels to the dataframe
        train <- as.data.frame(c(train_features, train_labels, train_subjects))
        colnames(train) <- c(colnames(train_features), "label", "subject")
# Uses descriptive activity names to name the activities in the data set
# replace label numbers by actual activity
        train <- merge(train, labels, by="label")

## merge the tables
        # add an indicator to each data set 
        train$set <- "TRAIN"
        test$set  <- "TEST"
        # combine two datasets by adding test rows to train
        combo=rbind(train, test)
        combo$label <- NULL 
        # needed such that in next step selected mean/std features 
        # can be matched to variables in same order

# Extracts only the measurements on the mean and standard deviation for each measurement.
        features_selected <- grep("mean|std", features)
        combo_selected <- combo[,features_selected]
        combo_selected <- combo_selected %>% mutate(subject = combo$subject
                                                    , activity = combo$activity)
# create independent tidy data set with the average of each variable for 
# each activity and each subject
# lecture tidying a dataset anschauen 
        grouped_dataset <- combo_selected %>% group_by(activity, subject) %>%
                summarize_all(mean)
        write.table(grouped_dataset, "tidydata.txt", row.names = FALSE)
                
                
        
        
        

