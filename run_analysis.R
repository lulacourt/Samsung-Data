## 1. Merges the training and the test sets to create one data set.

install.packages("plyr")
library(plyr)

# Downloaded unzipped data are in the folder 'Samsung' in the working directory.

# Read lists of features and activities.
features<-read.table("./Samsung/features.txt", header=FALSE, sep="", stringsAsFactors=FALSE)
activity<-read.table("./Samsung/activity_labels.txt", header=FALSE, sep="", stringsAsFactors=FALSE)

# Read test files (set, labels and subjects)
test_x<-read.table("./Samsung/test/X_test.txt", header=FALSE, sep="", stringsAsFactors=FALSE)

test_y<-read.table("./Samsung/test/y_test.txt", header=FALSE, sep="", stringsAsFactors=FALSE)
names(test_y)[1]<-"Activity" 

subject_test<-read.table("./Samsung/test/subject_test.txt", header=FALSE, sep="", stringsAsFactors=FALSE)
names(subject_test)[1]<-"Subject"

test<-cbind(subject_test,test_y,test_x)      # Get test group (combining by columns test_y and test_x)
test<-mutate(test,Group="test")     # Add a new variable to indicate group (test/training)


# Read training files (set, labels and subjects)
train_x<-read.table("./Samsung/train/X_train.txt", header=FALSE, sep="", stringsAsFactors=FALSE)

train_y<-read.table("./Samsung/train/y_train.txt", header=FALSE, sep="", stringsAsFactors=FALSE)
names(train_y)[1]<-"Activity" 

subject_train<-read.table("./Samsung/train/subject_train.txt", header=FALSE, sep="", stringsAsFactors=FALSE)
names(subject_train)[1]<-"Subject"

train<-cbind(subject_train,train_y,train_x)   # Get training group (combining by columns train_y and train_x)
train<-mutate(train,Group="training")       # Add a new variable to indicate group (test/training)
                                            

# Create one data set merging test and training sets.
data<-rbind(test,train)


# Assign variables names.
names(data)[3:563]<-make.names(as.character(features$V2),unique=TRUE)    # Take features labels from 'features' file
                                                                      # Resulting elements, features variables, are unique (avoid future problems with duplicated column names)

# Check that there's no duplicated column names.
sum(duplicated(names(data)))    # Returns 0 (unique column variables)



## 2. Extracts only the measurements on the mean and standard deviation for each measurement.

install.packages("dplyr")
library(dplyr)

# Select only the measurements which contains "mean()" and "std()".
strings<-c("mean","std")
pos<-c(which(grepl(paste(strings,collapse="|"),colnames(data))))    # Get indices of variables mean, std
 
data2<-select(data,Activity,Subject,Group,pos)      # Select columns activity, group (test/training) and those which measure mean or std
names(data2)        # Exclude 'meanFreq' variables
data2<-select(data2,1:49,53:58,62:67,71:72,74:75,77:78,80:81)
names(data2)        # Data set just contains measurements based on mean and std.



## 3. Uses descriptive activity names to name the activities in the data set.

data2$Activity<-factor(data2$Activity,levels=c(1,2,3,4,5,6),labels=c("WALKING","WALKING UPSTAIRS","WALKING DOWNSTAIRS","SITTING","STANDING","LAYING"))
table(data2$Activity)



## 4. Appropriately labels the data set with descriptive variable names.

names(data2)        # Examine variable names

# Replace variable names with descriptive labels.
names(data2) <- gsub("tBodyAcc.mean...", "Body acceleration time_mean_", names(data2))
names(data2) <- gsub("tBodyAcc.std...", "Body acceleration time_std_", names(data2))
names(data2) <- gsub("tGravityAcc.mean...", "Gravity acceleration time_mean_", names(data2))
names(data2) <- gsub("tGravityAcc.std...", "Gravity acceleration time_std_", names(data2))
names(data2) <- gsub("tBodyAccJerk.mean...", "Jerk body acceleration time_mean_", names(data2))
names(data2) <- gsub("tBodyAccJerk.std...", "Jerk body acceleration time_std_", names(data2))
names(data2) <- gsub("tBodyGyro.mean...", "Gyroscope time_mean_", names(data2))
names(data2) <- gsub("tBodyGyro.std...", "Gyroscope time_std_", names(data2))
names(data2) <- gsub("tBodyGyroJerk.mean...", "Jerk gyroscope time_mean_", names(data2))
names(data2) <- gsub("tBodyGyroJerk.std...", "Jerk gyroscope time_std_", names(data2))
names(data2) <- gsub("tBodyAccMag.mean..", "Euclidean body acceleration time_mean", names(data2))
names(data2) <- gsub("tBodyAccMag.std..", "Euclidean body acceleration time_std", names(data2))
names(data2) <- gsub("tGravityAccMag.mean..", "Euclidean gravity acceleration time_mean", names(data2))
names(data2) <- gsub("tGravityAccMag.std..", "Euclidean gravity acceleration time_std", names(data2))
names(data2) <- gsub("tBodyAccJerkMag.mean..", "Euclidean jerk body acceleration time_mean", names(data2))
names(data2) <- gsub("tBodyAccJerkMag.std..", "Euclidean jerk body acceleration time_std", names(data2))
names(data2) <- gsub("tBodyGyroMag.mean..", "Euclidean gyroscope time_mean", names(data2))
names(data2) <- gsub("tBodyGyroMag.std..", "Euclidean gyroscope time_std", names(data2))
names(data2) <- gsub("tBodyGyroJerkMag.mean..", "Euclidean jerk gyroscope time_mean", names(data2))
names(data2) <- gsub("tBodyGyroJerkMag.std..", "Euclidean jerk gyroscope time_std", names(data2))
names(data2) <- gsub("fBodyAcc.mean...", "Body acceleration frequency_mean_", names(data2))
names(data2) <- gsub("fBodyAcc.std...", "Body acceleration frequency_std_", names(data2))
names(data2) <- gsub("fBodyAccJerk.mean...", "Jerk body acceleration frequency_mean_", names(data2))
names(data2) <- gsub("fBodyAccJerk.std...", "Jerk body acceleration frequency_std_", names(data2))
names(data2) <- gsub("fBodyGyro.mean...", "Gyroscope frequency_mean_", names(data2))
names(data2) <- gsub("fBodyGyro.std...", "Gyroscope frequency_std_", names(data2))
names(data2) <- gsub("fBodyAccMag.mean..", "Euclidean body acceleration frequency_mean", names(data2))
names(data2) <- gsub("fBodyAccMag.std..", "Euclidean body acceleration frequency_std", names(data2))
names(data2) <- gsub("fBodyBodyAccJerkMag.mean..", "Euclidean jerk body acceleration frequency_mean", names(data2))
names(data2) <- gsub("fBodyBodyAccJerkMag.std..", "Euclidean jerk body acceleration frequency_std", names(data2))
names(data2) <- gsub("fBodyBodyGyroMag.mean..", "Euclidean gyroscope frequency_mean", names(data2))
names(data2) <- gsub("fBodyBodyGyroMag.std..", "Euclidean gyroscope frequency_std", names(data2))
names(data2) <- gsub("fBodyBodyGyroJerkMag.mean..", "Euclidean jerk gyroscope frequency_mean", names(data2))
names(data2) <- gsub("fBodyBodyGyroJerkMag.std..", "Euclidean jerk gyroscope frequency_std", names(data2))

names(data2)        # Check new variable names



## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Check for missing values.
colSums(is.na(data2))       # There's no missing values in our data set

# Generate means by stratum (activity and subject).
output<-ddply(data2,.(Activity,Subject),numcolwise(mean))

# Write a text file.
write.table(output,file="./tidy_data.txt",row.name=FALSE,quote=FALSE)
    
