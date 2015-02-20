##This function opens the various datasets, then merges them into a single data set
run_analysis<-function()
{

  ##Set working directory
  ##basePath <- "C:\\Local\\My local Documents\\Training\\Data Analytics\\Getting and Cleaning Data\\Assignment\\UCI HAR Dataset"
  ##setwd(basePath)
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile="Dataset.zip")
  unzip("Dataset.zip")  
  
  ##load description files - need stringsAsFactors
  features<-read.table("features.txt",stringsAsFactors=FALSE)
  activities<-read.table("activity_labels.txt")
  
  ######################################################
  ##load data from train directory and create dataframe
  ######################################################

  xTrain<-read.table(".\\train\\X_train.txt", header=FALSE)
  ##Add rownames to X_train
  colnames(xTrain)<-features$V2
  
  yTrain<-read.table(".\\train\\y_train.txt", col.names=c("Activity"))

  subjectTrain<-read.table(".\\train\\subject_train.txt", col.names=c("Subject"))

  finalTrainData<-cbind(subjectTrain,yTrain,xTrain)
  
 
  #####################################################
  ##load data from test directory and create dataframe
  #####################################################

  xTest<-read.table(".\\test\\X_test.txt", header=FALSE)
  ##Add rownames to X_test
  colnames(xTest)<-features$V2
  
  yTest<-read.table(".\\test\\y_test.txt", col.names=c("Activity"))

  subjectTest<-read.table(".\\test\\subject_test.txt", col.names=c("Subject"))

  finalTestData<-cbind(subjectTest,yTest,xTest)

  ####################################
  ## Merge into one global DataFrame
  ####################################
  fullData <- rbind(finalTrainData,finalTestData)

  #######################################################################
  ## Replace Activity ID with corresponding textual description (factor)
  #######################################################################
  #fullData[,2]<-factor(fullData[,2])
  fullData$Activity<-as.factor(fullData$Activity)
  levels(fullData$Activity)<-activities$V2
  
  ##################################################################
  ## Subset to relevant columns: first two + those with std() and mean()
  ##################################################################
  retainColumns=vector<-grepl("Activ|Subj|std\\(|mean\\(", names(fullData))

  finalData<-fullData[,retainColumns==TRUE]
  
  ##################################################################
  ## Recreate meaningful names - replacing letters by full words
  ##################################################################  
  nameVector<-names(finalData)
  
  nameVector<-gsub("std\\(\\)"," Standard Deviation ", nameVector)
  nameVector<-gsub("mean\\(\\)-?"," Mean Value ", nameVector)  
  nameVector<-gsub("BodyBody", " Body", nameVector)
  nameVector<-gsub("Body", " Body", nameVector)
  nameVector<-gsub("Gravity", " Gravity", nameVector)  
  nameVector<-gsub("Gyro", " Gyroscopic", nameVector)  
  nameVector<-gsub("Jerk", " Jerk", nameVector)
  nameVector<-gsub("Mag", " Magnitude", nameVector)
  nameVector<-gsub("Acc", " Acceleration", nameVector)
  nameVector<-gsub("f", "Frequency Domain Signals,", nameVector)
  nameVector<-gsub("t ", "", nameVector)
  ##nameVector<-gsub("tGravityAcc", "Gravity Acceleration signal, ", nameVector)
  ##nameVector<-gsub("tBodyGyroJerk", "Body Gyrospcopic Jerk signal, ", nameVector)
  ##nameVector<-gsub("tBodyGyro", "Body Gyrospcopic signal, ", nameVector)
  ##nameVector<-gsub("fBodyAcc", "Body Acceleration signal FFT, ", nameVector)
  ##nameVector<-gsub("fBodyGyro", "Body Gyrospcopic signal FFT, ", nameVector)
  ##nameVector<-gsub("fBodyGyroJerk", "Body Gyrospcopic Jerk signal FFT, ", nameVector)
  ##nameVector<-gsub("fBodyGyroJerkMag", "Body Gyrospcopic Jerk signal FFT, ", nameVector)

  colnames(finalData)<-nameVector
  ##print(nameVector)
  
  ################################################################
  ##  Write the (full) tidy dataset to a new file
  ################################################################
  write.table(finalData, row.name=FALSE, sep=",", file="TidyData.csv")
  
  
  ################################################################
  ##  Create an aggregate with Activity and Subject as ids
  ################################################################
  
  # might need to install reshape2 for merge and dcast
  library(reshape2)
  # merge: melt and cast dataframe for year vs Emissions  
  tidyDataMelt <- melt(finalData, id=c("Subject","Activity"))
  
  #dcast to generate resulting mean (average) value 
  consolidatedTidyData <- dcast(tidyDataMelt, Subject+Activity~variable, mean)

  # Change name of columns - add "Average of "...
  nameVector<-names(consolidatedTidyData)
  colnames(consolidatedTidyData)[3:length(nameVector)]<-paste("Average of",nameVector[3:length(nameVector)])
  
  
  ################################################################
  ##  Write the (consolidated) tidy dataset to a new file
  ################################################################
  write.table(consolidatedTidyData, row.name=FALSE, sep=",", file="ConsolidatedTidyData.csv")
}