# 1.Merges the training and the test sets to create one data set

# set working directory

# read in data
features <- read.table("features.txt") 
activity <- read.table("activity_labels.txt") 

# train sets
train.x <- read.table("./train/X_train.txt") 
train.y <- read.table("./train/y_train.txt") 
train.subject <- read.table("./train/subject_train.txt")

# assign column names
colnames(train.subject)  = "Subject"; 
colnames(train.x)        = features[,2];  
colnames(train.y)        = "Activity"; 

# merge train data
train.all <- cbind(train.x, train.y, train.subject)

# test sets
test.x <- read.table("./test/X_test.txt") 
test.y <- read.table("./test/y_test.txt")  
test.subject <- read.table("./test/subject_test.txt") 

# assign column names
colnames(test.subject)  = "Subject"; 
colnames(test.x)        = features[,2];  
colnames(test.y)        = "Activity"; 

# merge test data
test.all <- cbind(test.x, test.y, test.subject)

# merge train and test data sets
train.test.data <- rbind(train.all, test.all) 

# get dimension
dim(train.test.data)
# [1] 10299   563


# 2.Extracts only the measurements on the mean and standard deviation for each measurement


# get column names
train.test.data.colnam <- colnames(train.test.data) 

# filter to mean and standard deviations (columns 'Activity' and 'Subject' have to be included as well)
getcolnames <- (grepl("mean\\(\\).",train.test.data.colnam) | +
                  grepl("std\\(\\)",train.test.data.colnam) | +
                  grepl("Activity",train.test.data.colnam) | +
                  grepl("Subject",train.test.data.colnam))

# filter table train.test.data
train.test.data.mean.std = train.test.data[getcolnames==TRUE] 

# get dimension
dim(train.test.data.mean.std)
# [1] 10299    59


# 3.Uses descriptive activity names to name the activities in the data set


# get names of activities
activity 
# V1                V2
# 1            WALKING
# 2   WALKING_UPSTAIRS
# 3 WALKING_DOWNSTAIRS
# 4            SITTING
# 5           STANDING
# 6             LAYING

# get descriptive activity names
activity[, 2] <- tolower(gsub("_", "", activity[, 2])) # remove '_' and convert string to its lower case
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8)) # convert 'walkingupstairs' to 'walkingUpstairs'
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8)) # convert 'walkingdownstairs' to 'walkingDownstairs'

# get changed activity names
activity
# activity
#   standing
#   sitting
#   laying
#   walking
#   walkingDownstairs
#   walkingUpstairs

# change column names of table 'activity'
names(activity)[1]<-paste("Activity")
names(activity)[2]<-paste("ActivityLabels")

# merge train.test.data.mean.std with the activity labels
train.test.data.mean.std.act <- merge(train.test.data.mean.std, activity, by='Activity',all.x=TRUE)

# get dimension
dim(train.test.data.mean.std.act)
# [1] 10299    60


# 4.Appropriately labels the data set with descriptive variable names. 


# get column names 
colnames(train.test.data.mean.std.act)

# remove '()'
names(train.test.data.mean.std.act) <- gsub("\\()","",names(train.test.data.mean.std.act))

# change 'std' to 'StdDev'
names(train.test.data.mean.std.act) <- gsub("-std","StdDev", names(train.test.data.mean.std.act))

# change 'mean' to 'Mean'
names(train.test.data.mean.std.act) <- gsub("-mean","Mean", names(train.test.data.mean.std.act)) 

# replace 't' in the first place with 'Time'
names(train.test.data.mean.std.act) <- gsub("^(t)","Time", names(train.test.data.mean.std.act))

# replace 'f' in the first place with 'Freq'
names(train.test.data.mean.std.act) <- gsub("^(f)","Freq", names(train.test.data.mean.std.act))

# get column names after clean up
colnames(train.test.data.mean.std.act)


# 5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject


# create copy of table train.test.data.mean.std.act  
train.test.data.act.mean <- (train.test.data.mean.std.act)

# aggregate data by Activity and Subject
train.test.data.act.mean.agg <- with(train.test.data.act.mean, aggregate(train.test.data.act.mean[,names(train.test.data.act.mean) != c('Activity', 'Subject', 'ActivityLabels')], by = list(Activity=train.test.data.act.mean$Activity, Subject=train.test.data.act.mean$Subject), mean))

# join Activity labels
train.test.data.act.mean.agg <- merge(train.test.data.act.mean.agg, activity, by='Activity',all.x=TRUE)

# get dimension
dim(train.test.data.act.mean.agg)
# [1] 180  60

# save data in text file
write.table(train.test.data.act.mean.agg, './tidyData.txt', row.names=FALSE, sep='\t')