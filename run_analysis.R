# This is a code for Assignment 4 in Getting and Cleaning Data course
#
#
#The data set is found at: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# It contains the following files: 

        # 'README.txt'
        # 
        # - 'features_info.txt': Shows information about the variables used on the
        # feature vector.
        # 
        # - 'features.txt': List of all features.
        # 
        # - 'activity_labels.txt': Links the class labels with their activity name.
        # 
        # - 'train/X_train.txt': Training set.
        # 
        # - 'train/y_train.txt': Training labels.
        # 
        # - 'test/X_test.txt': Test set.
        # 
        # - 'test/y_test.txt': Test labels.
        # 
        # The following files are available for the train and test data. Their
        # descriptions are equivalent.
        # 
        # - 'train/subject_train.txt': Each row identifies the subject who performed the
        # activity for each window sample. Its range is from 1 to 30.
        # 
        # - 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from
        # the smartphone accelerometer X axis in standard gravity units 'g'. Every row
        # shows a 128 element vector. The same description applies for the
        # 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z
        # axis.
        # 
        # - 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal
        # obtained by subtracting the gravity from the total acceleration.
        # 
        # - 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector
        # measured by the gyroscope for each window sample. The units are
        # radians/second.
#More information about the data can be found in./UCI HAR Dataset/features_info.txt 


# 1. Merge the training and the test sets to create one data set.

X_train<-read.table("/Volumes/DataDrive/Dropbox/Coursera-DataScience/ProgrammingAssignment4/UCI HAR Dataset/train/X_train.txt")
Y_train<-read.table("/Volumes/DataDrive/Dropbox/Coursera-DataScience/ProgrammingAssignment4/UCI HAR Dataset/train/Y_train.txt")
subject_train<-read.table("/Volumes/DataDrive/Dropbox/Coursera-DataScience/ProgrammingAssignment4/UCI HAR Dataset/train/subject_train.txt")
train<-cbind(subject_train, Y_train, X_train)

X_test<-read.table("./UCI HAR Dataset/test/X_test.txt")
Y_test<-read.table("./UCI HAR Dataset/test/Y_test.txt")
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")
test<-cbind(subject_test, Y_test, X_test)

combined_set<-rbind(train,test)


# 2. Extract only the measurements on the mean and standard deviation for each measurement.
        #extract column names
col_names<-read.table("./UCI HAR Dataset/features.txt")
v2<-col_names$V2
v2<-as.character(v2)
col_names_new<-c("subject",'activity', v2 )

        #extract indices of measurements on mean and stdev for each measurement, then add the indices of col's 1 and 2 = subject and activity
m<-grep('-mean()', col_names_new, fixed=TRUE)
n<-grep('-std()', col_names_new, fixed=TRUE)
mean_and_stdev<-sort(union(m, n))
mean_and_stdev1<-c(1,2,mean_and_stdev)       
        
        #extract only measurements on the mean and stdev for each measurement
combined_set_mean_and_stdev<-combined_set[, mean_and_stdev1]
col_names_mean_and_stdev<-col_names_new[mean_and_stdev1]

        # insert variable names in the data set
colnames(combined_set_mean_and_stdev)<-col_names_mean_and_stdev
        

# 3. Change from numbers to descriptive activity names to name the activities in the data set
activities<-read.table("./UCI HAR Dataset/activity_labels.txt")
names(activities)<-c('activity', 'activity_label' )
descriptive_data_set<-merge(activities, combined_set_mean_and_stdev)

# 4. Appropriately label the data set with descriptive variable names.
#       accomplished above, under #2

# 5. From the data set in step 4, creates a second, independent tidy data set with
# the average of each variable for each activity and each subject.
        #extract only means for each subject
        #need to exclude the activity label to group the data by activity and subject 

new_m<-grep('-mean()', names(descriptive_data_set), fixed=TRUE)
new_m<-c(1,3, new_m) 
descriptive_data_set_average<-(descriptive_data_set)[new_m]


means_byActivty_bySubject <-
        aggregate(
                descriptive_data_set_average, by = list(
                        descriptive_data_set_average$activity, descriptive_data_set_average$subject
                ), FUN = mean
        )
        #trim and sort the data set
means_byActivty_bySubject<-means_byActivty_bySubject[, 3:length(means_byActivty_bySubject)]
means_byActivty_bySubject<-merge(activities, means_byActivty_bySubject)
attach(means_byActivty_bySubject)
means_byActivty_bySubject<-means_byActivty_bySubject[order(activity_label, subject), ]
detach(means_byActivty_bySubject)


#6. write out the result to a file

write.table(means_byActivty_bySubject, file = './data_set.txt', row.name = FALSE)