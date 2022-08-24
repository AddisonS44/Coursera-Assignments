## Begin by combining the raw data sets together. Based in the dimensions, subject_test, X_test, and Y_test should go into one set and the _train versions should go into another.

## First step is to load the data using read.table()
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("UCI HAR Dataset/train/Y_train.txt")

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("UCI HAR Dataset/test/Y_test.txt")

## The data for each set (train and test) shares the same number of rows, so combine them with cbind. Choosing subject|Y|X because the subject and Y are the overarching categories while X is the actual data. IDs first.
train_union <- cbind(subject_train, Y_train, X_train)
test_union <- cbind(subject_test, Y_test, X_test)

## So now we have to take only those columns which have mean or std in the label. First, going to apply those labels now rather than later. I am NOT dealing with that nonsense.
## features.txt has the column names in the second column (automatically labelled here as V2)
features <- read.table("UCI HAR Dataset/features.txt")
data_names <- features$V2
data_names <- append(c("Subject", "Activity"), data_names)
names(test_union) <- data_names
names(train_union) <- data_names
## I'd like to note here that while this solves criterion 4 of the assignment and I've yet to do 2, doing it now is just so much easier than having to filter down the list of column names to match what I'm 
## removing later and I'm going to need the Activity column name for the next section


## I appreciate the arbitrary numbers assigned to the activities in the Y files, but maybe let's not use nondescript values for a tidy data set?
activity_list <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")
for(i in 1:6) {
  test_union$Activity[test_union$Activity == i] <- activity_list[i]           ## Look ma, 5 lines!
  train_union$Activity[train_union$Activity == i] <- activity_list[i]
}

## If you're actually reading this, here's a joke: What's a bull's favorite fruit? A gourd!
## Now to filter down the data to only the average and standard deviation data, plus the important subject and activity columns
columns_to_keep <- grep("Subject|Activity|[Mm]ean|[Ss][Tt][Dd]",names(test_union))
test_union <- test_union[,columns_to_keep]
train_union <- train_union[,columns_to_keep]

## The resource provided in the discussion forums mentions having 180 entries per table. 30 subjects x 6 activities. I would agree with this assessment, but there are not entries for every subject!
## So what I want to do here is just look at each combination of subject and activity. For these pairs, if there is at least one row available, I want to take the mean of every column but the first 2
## and insert the means into a dataframe with these values.
test_final <- test_union[FALSE,]
train_final <- train_union[FALSE,]

for(subject in 1:30) {
  for(activity in activity_list) {
    temp_df <- test_union[test_union$Subject == subject,]
    temp_df <- temp_df[temp_df$Activity == activity,]
    if(dim(temp_df)[1] == 0) {
      next
    }
    means_set <- colMeans(temp_df[,-1:-2])
    
    sub_act <- data.frame(subject, activity)
    names(sub_act) <- c("Subject", "Activity")
    
    temp_df <- cbind(sub_act, t(means_set))
    
    test_final <- rbind(test_final, temp_df)
  }
}

for(subject in 1:30) {
  for(activity in activity_list) {
    temp_df <- train_union[train_union$Subject == subject,]
    temp_df <- temp_df[temp_df$Activity == activity,]
    if(dim(temp_df)[1] == 0) {
      next
    }
    means_set <- colMeans(temp_df[,-1:-2])
    
    sub_act <- data.frame(subject, activity)
    names(sub_act) <- c("Subject", "Activity")
    
    temp_df <- cbind(sub_act, t(means_set))
    
    train_final <- rbind(train_final, temp_df)
  }
}

write.csv(test_final, "Final Datasets\\test_final.csv", row.names = FALSE)
write.csv(train_final, "Final Datasets\\train_final.csv", row.names = FALSE)
