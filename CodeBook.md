CodeBook:

Script name=run_analysis.R
The run_analysis performs six steps and finally generate a tidy dataset after summarizing each variable of activity and subject.

1.	Download dataset

First download the dataset using download.file under folder called UCI HAR dataset and later unzip it using unzip()

2.	Read each .txt file and assign it to the variables
Features<-feactures.txt
Activities<-activity_lables
SubjectTest<-subject_test under test folder
x_test<-X_test under test folder
y_test<-Y_test under test folder

Similarly for subject_train.txt under train folder is read as table and assigned to SubjectTrain and X_train and Y_train to x_train 
and Y_train

3.	Merge training and testing datasets to one dataset.

All testing data tables subjectTest, x_test, y_test are column wise merged and assigned to X1.

X1<-cbind(subjectTrain,y_train,x_train)

Similalry, all training data tables subjectTrain, x_train , y_train are column wise merged and assigned to X2

X2<-cbind(subjectTest,y_test,x_test)

These are then merged row wise using rbind() function into one data set.
Merged_D1<-rbind(X1,X2)

4.	Uses descriptive activity names to name the activities in the data set 

Data is created by sub setting Merged_D1 and selecting only columns subject, code and measurements containing mean and std. 

5.	Uses descriptive activity names to name the activities in the data set
Numbers in column code of Data are replaced with activities stored in second column of activities table.

6.	Appropriately labels the data set with descriptive variable names.
Code column is renamed to activity. All column names containing Acc, Gyro, tbody, BodyBody and others are replaced to Accelerometer, 
Gyroscope, TimeBody and body etc.

7.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and 
each subject.
Lastly an independent dataset Final_Project is created which contains all the summarize data with respect to subject and activity 
variables. This data is then saved to Final_Project.txt using write.table() function.
