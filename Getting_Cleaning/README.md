### run_analysis.R code
## by Francois Ragnet

##Experiment Drescription
One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

##Data/Study Design
The data can be downloaded from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

##Instruction list
1. Download the data from the link above, then unzip it to a directory.
2. Open Rstudio
3. Set your working Directory to the top directory (UCI HAR Dataset) of your local filesystem.
4. launch run_analysis.R
5. This will consolidate the input from the various raw files and produce two tidy files:
	a. TidyData.csv is the clean data, after merging and processing;
	b. CosolidatedTidyData.csv contains  the average of each variable for each activity and each subject.
	
See below (Code Book) for the variables and measurements

## Code Book

Subject - Experiment Subject ID (1 to 30)
Activity - Textual description of the activity performed
#Units: values below are raw sensor measurement units, between -1 and +1. 
#The name describes the measurement in more details
#Mean Value or Standard Deviation are Reported.
#X,Y,Z correspond to  3D axes
Body Acceleration- Mean Value X
Acceleration- Mean Value Y	
Body Acceleration- Mean Value Z
Body Acceleration- Standard Deviation -X
Body Acceleration- Standard Deviation -Y
Body Acceleration- Standard Deviation -Z
Gravity Acceleration- Mean Value X
Gravity Acceleration- Mean Value Y
Gravity Acceleration- Mean Value Z
Gravity Acceleration- Standard Deviation -X
Gravity Acceleration- Standard Deviation -Y
Gravity Acceleration- Standard Deviation -Z
Body Acceleration Jerk- Mean Value X
Body Acceleration Jerk- Mean Value Y
Body Acceleration Jerk- Mean Value Z
Body Acceleration Jerk- Standard Deviation -X
Body Acceleration Jerk- Standard Deviation -Y
Body Acceleration Jerk- Standard Deviation -Z
Body Gyroscopic- Mean Value X
Body Gyroscopic- Mean Value Y	
Body Gyroscopic- Mean Value Z
Body Gyroscopic- Standard Deviation -X	
Body Gyroscopic- Standard Deviation -Y
Body Gyroscopic- Standard Deviation -Z
Body Gyroscopic Jerk- Mean Value X
Body Gyroscopic Jerk- Mean Value Y
Body Gyroscopic Jerk- Mean Value Z
Body Gyroscopic Jerk- Standard Deviation -X
Body Gyroscopic Jerk- Standard Deviation -Y
Body Gyroscopic Jerk- Standard Deviation -Z
Body Acceleration Magnitude- Mean Value 
Body Acceleration Magnitude- Standard Deviation 
Gravity Acceleration Magnitude- Mean Value 
Gravity Acceleration Magnitude- Standard Deviation
Body Acceleration Jerk Magnitude- Mean Value
Body Acceleration Jerk Magnitude- Standard Deviation
Body Gyroscopic Magnitude- Mean Value
Body Gyroscopic Magnitude- Standard Deviation 
Body Gyroscopic Jerk Magnitude- Mean Value 	
Body Gyroscopic Jerk Magnitude- Standard Deviation 	
Frequency Domain Signals,  Body Acceleration- Mean Value X	
Frequency Domain Signals,  Body Acceleration- Mean Value Y	
Frequency Domain Signals,  Body Acceleration- Mean Value Z	
Frequency Domain Signals,  Body Acceleration- Standard Deviation -X	
Frequency Domain Signals,  Body Acceleration- Standard Deviation -Y	
Frequency Domain Signals,  Body Acceleration- Standard Deviation -Z	
Frequency Domain Signals,  Body Acceleration Jerk- Mean Value X	
Frequency Domain Signals,  Body Acceleration Jerk- Mean Value Y	
Frequency Domain Signals,  Body Acceleration Jerk- Mean Value Z	
Frequency Domain Signals,  Body Acceleration Jerk- Standard Deviation -X	
Frequency Domain Signals,  Body Acceleration Jerk- Standard Deviation -Y	
Frequency Domain Signals,  Body Acceleration Jerk- Standard Deviation -Z	
Frequency Domain Signals,  Body Gyroscopic- Mean Value X	
Frequency Domain Signals,  Body Gyroscopic- Mean Value Y	
Frequency Domain Signals,  Body Gyroscopic- Mean Value Z	
Frequency Domain Signals,  Body Gyroscopic- Standard Deviation -X	
Frequency Domain Signals,  Body Gyroscopic- Standard Deviation -Y	
Frequency Domain Signals,  Body Gyroscopic- Standard Deviation -Z	
Frequency Domain Signals,  Body Acceleration Magnitude- Mean Value 	
Frequency Domain Signals,  Body Acceleration Magnitude- Standard Deviation 	
Frequency Domain Signals,   Body Acceleration Jerk Magnitude- Mean Value 	
Frequency Domain Signals,   Body Acceleration Jerk Magnitude- Standard Deviation 	
Frequency Domain Signals,   Body Gyroscopic Magnitude- Mean Value 	
Frequency Domain Signals,   Body Gyroscopic Magnitude- Standard Deviation 	
Frequency Domain Signals,   Body Gyroscopic Jerk Magnitude- Mean Value 	
Frequency Domain Signals,   Body Gyroscopic Jerk Magnitude- Standard Deviation 

### 