# SAMSUNG DATA.

## 1. Merges the training and the test sets to create one data set.
* First of all we load ‘plyr’ package in order to be able to use ‘select’, ‘mutate’, ‘summarize’… 
* We’ve downloaded and unzipped data in our working directory, in a folder called ‘Samsung’.
* Read list of features (from ‘features.txt’) and activities (from ‘activity_labels.txt’), using read.table.
* In the ‘test’ folder we find ‘X_test.txt’ (set), ‘y_test.txt’ (labels) and ‘subject_test.txt’ (subjects). Read them using read.table.
* Combining by columns these three data frames we get test group data. 
* Optionally we create a variable called ‘Group’ with two categories (test/training) to identify the subject group.
* Idem reading and merging training data from ‘train’ folder.
* Create one data set merging ‘test ‘and’ train’ sets (combining by rows).
* Assign variables names. Previously read ‘features.txt’ gives name to variables with measurements. To avoid future problems with duplicated column names we use ‘make.names’ with option ‘unique=TRUE’ and check that there’s no duplicates.

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
* Load ‘dplyr’ package.
* To select the measurements which contains ‘mean’ or ‘std’ we create a character vector with these strings.
* We pass as argument this vector to function ‘grepl’ to get a vector with position of those measurements which contain in their    column name one of the strings (mean or std).
* Select those variables in addition to ‘Activity’ and ‘Subject’ from our data frame.
* Checking variables names we find ‘meanFreq’ measurements. Get their position and exclude them from our data frame.

## 3. Uses descriptive activity names to name the activities in the data set.
* ‘Activity’ values take their labels from ‘activity_labels.txt’ previously read. By using ‘factor’ we assign labels to each level.

## 4. Appropriately labels the data set with descriptive variable names.
* Examine variable names and rename them with function gsub (passing as arguments the old and new names).

## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
* Check for missing values in our data set.
* Generate means by stratum (Activity and Subject), by using ddply.
* Write a text file with ‘row.name=FALSE’ as option in ‘write.table’, getting our tidy data set.
