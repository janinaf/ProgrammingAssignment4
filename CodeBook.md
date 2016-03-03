---
title: "CodeBook for Assignment4"
author: "Janina F"
date: "March 3, 2016"
output: html_document
---

# The data set is found at: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
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

#More information about the data set can be found in features_info.txt. Please consult the above files for any further details regarding the original data set. 

#The data set collected from all 30 subjects was divided randomly into two unequal subsets, train and test, containing information about the subject, the activity type, and a serios of statistics computed based on the originally collected signals. For this subsequent analysis, these two subsets were reunited as a large data set, resulting in a data frame of 10299 rows of observations X 561 columns of variables, which were constituted of the statistics computed on the signals. 

#Two other variables were added to the 10299 X 561 data frame:  subject, from the subject_train/-test files, and activity, from the y-train/test files. These were the first and second, respectively, variables in the resulting data frame. 

#From the reconstituted 10299 X 563 data set, only the means and stdev of each measurement were selected for further processing. Each variable name has been inserted as the columm name of the corresponding data based on the information stored in features.txt file. An additional variable, activity_level, was created as a descriptive variable for the six levels of activity type included in the study.This processing resulted in a observationsXvariables 10299 X 69 data frame. 

#In the last step,only the means for each measurement were selected from the 10299X69 data frame, resulting in an 10299X35 data frame (first two columns are activity and subject, after which a series of 33 variables are listed:
# tBodyAcc-XYZ
# tGravityAcc-XYZ
# tBodyAccJerk-XYZ
# tBodyGyro-XYZ
# tBodyGyroJerk-XYZ
# tBodyAccMag
# tGravityAccMag
# tBodyAccJerkMag
# tBodyGyroMag
# tBodyGyroJerkMag
# fBodyAcc-XYZ
# fBodyAccJerk-XYZ
# fBodyGyro-XYZ
# fBodyAccMag
# fBodyAccJerkMag
# fBodyGyroMag
# fBodyGyroJerkMag
# )
#Here, 't' stands for time domain and 'f' for frequency domain data. Acceleration ('Acc') is measured in standard gravity units, g; Angular velocity ('Gyro') is measures in rad/sec. 


# The average of each variable for each activity and each data set were computed and stored in the means_byActivty_bySubject final data frame. 



