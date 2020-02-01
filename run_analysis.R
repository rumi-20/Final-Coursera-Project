library(dplyr)
file<-"UCI HAR Dataset.zip"
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(url,file)

if (!file.exists("UCI HAR Dataset")) { 
  unzip(file) 
}

#loading files
features <- read.table("UCI HAR Dataset//features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset//activity_labels.txt", col.names = c("code", "activity"))
subjectTest <- read.table("UCI HAR Dataset//test//subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset//test//X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset//test/y_test.txt", col.names = "code")
subjectTrain <- read.table("UCI HAR Dataset//train//subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset//train//X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset//train//y_train.txt", col.names = "code")



#Step 1

X1<-cbind(subjectTrain,y_train,x_train)
X2<-cbind(subjectTest,y_test,x_test)
Merged_D1<-rbind(X1,X2)

X#Step2
Data<-Merged_D1%>%select(subject,code,contains("mean"),contains("std"))

#Step3
Data$code[Data$code==1]<-"Walking"
Data$code[Data$code==2]<-"WALKING_UPSTAIRS"
Data$code[Data$code==3]<-"WALKING_DOWNSTAIRS"
Data$code[Data$code==4]<-"Sitting"
Data$code[Data$code==5]<-"Standing"
Data$code[Data$code==6]<-"Lying"

#Step4
colnames(Data)[2] = "activity"
names(Data)<-sub("Acc", "Accelerometer", names(Data))
names(Data)<-sub("Gyro", "Gyroscope", names(Data))
names(Data)<-sub("BodyBody", "body", names(Data))
names(Data)<-sub("Mag", "Magnitude", names(Data))
names(Data)<-sub("^t", "Time", names(Data))
names(Data)<-sub("^f", "Frequency", names(Data))
names(Data)<-sub("tBody", "TimeBody", names(Data))
names(Data)<-sub("-mean()", "Mean", names(Data), ignore.case = TRUE)
names(Data)<-sub("-std()", "Standard_deviation", names(Data), ignore.case = TRUE)
names(Data)<-sub("-freq()", "Frequency", names(Data), ignore.case = TRUE)
names(Data)<-sub("angle", "Angle", names(Data))
names(Data)<-sub("gravity", "Gravity", names(Data))


#Step4
Final_Data <- Data %>%
  group_by(subject,activity)%>%
summarize_all(funs(mean))%>%ungroup()
write.table(Final_Data, "Final_Data.txt", row.name=FALSE)

