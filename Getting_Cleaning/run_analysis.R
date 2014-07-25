##This function opens the various datasets, then merges them into a single data set

run_analysis<-function()
{
  ##library(data.table)
  ##Set working directory
  basePath <- "C:\\Local\\My local Documents\\Training\\Data Analytics\\Getting and Cleaning Data\\Assignment\\UCI HAR Dataset"
  setwd(basePath)
  
  ##load description files - need stringsAsFactors
  features<-read.table("features.txt",stringsAsFactors=FALSE)
  activities<-read.table("activity_labels.txt")
  
  ######################################################
  ##load data from train directory and create dataframe
  ######################################################
  ##stringPath <- paste(basePath, "\\train\\", sep='')
  ##setwd(stringPath)
  mainTrain<-read.table(".\\train\\X_train.txt", header=FALSE)
  ##Add rownames to X_train
  colnames(mainTrain)<-features$V2
  
  yTrain<-read.table(".\\train\\y_train.txt", col.names=c("Activity"))

  subjectTrain<-read.table(".\\train\\subject_train.txt", col.names=c("Subject"))

  finalTrainData<-cbind(subjectTrain,yTrain,mainTrain)
  
 
  #####################################################
  ##load data from test directory and create dataframe
  #####################################################
  stringPath <- paste(basePath, "", sep='')
  setwd(stringPath)
  mainTest<-read.table(".\\test\\X_test.txt", header=FALSE)
  ##Add rownames to X_test
  colnames(mainTest)<-features$V2
  
  yTest<-read.table(".\\test\\y_test.txt", col.names=c("Activity"))

  subjectTest<-read.table(".\\test\\subject_test.txt", col.names=c("Subject"))

  finalTestData<-cbind(subjectTest,yTest,mainTest)

  ####################################
  ## Merge into one global DataFrame
  ####################################
  fullData <- rbind(finalTrainData,finalTestData)

  #######################################################################
  ## Replace Activity ID with corresponding textual description (factor)
  #######################################################################
  fullData[,2]<-factor(fullData[,2])
  levels(fullData[,2])<-activities$V2
  
  ##################################################################
  ## Find relevant columns - first two + those with std() and mean()
  ##################################################################
  retainColumns=vector<-grepl("Activ|Subj|std\\(|mean\\(", names(fullData))


  finalData<-fullData[retainColumns==TRUE]
  
  print(names(finalData))
  
  ##################################################################
  ## Recreate meaningful names
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
  nameVector<-gsub("f", "Frequency Domain Signals, ", nameVector)
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
  write.csv(finalData, file="TidyData.csv")
  
  
  ################################################################
  ##  Create an aggregate with Activity and Subject as ids
  ################################################################
  attach(finalData)
  
  aggFinal<-aggregate(finalData,by=list(Subject,Activity),FUN=mean)
  ################################################################
  ##  Remove columns 3 and 4 which are a repeat, rename Group.1 and .2
  ################################################################
  aggFinal<-aggFinal[c(1:2,5:70)]
  
  ################################################################
  ##  Write the (consolidated) tidy dataset to a new file
  ################################################################
  write.csv(finalData, file="ConsolidatedTidyData.csv")
}