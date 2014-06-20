Explanation of the code
===============
Code file - 'run_analysis.R'

###Main steps 
1. Download and unpack data
2. Assign filenames and paths to variables
3. Read file with activity labels
4. Read file with features
5. Bind data from train and learn
6. Make tidy date for future steps
7. Calculate mean for activity and subject 

#### Download and unpack data
* Here we, using download.file function download file and using 'unzip' function unpack it to our working directory
```R
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile="data.zip")
  unzip("data.zip")
```
#### Assign filenames and paths to variables
* just assign required filenames to shorter variables
```R
  subject_train <- "UCI HAR Dataset/train/subject_train.txt"
  subject_test <- "UCI HAR Dataset/test/subject_test.txt"
  X_train <- "UCI HAR Dataset/train/X_train.txt"
  X_test <- "UCI HAR Dataset/test/X_test.txt"
  y_train <- "UCI HAR Dataset/train/y_train.txt"
  y_test <- "UCI HAR Dataset/test/y_test.txt"
  features_file <- "UCI HAR Dataset/features.txt"
  labels_file <- "UCI HAR Dataset/activity_labels.txt"
```
#### Read file with activity labels
* here we create a vecor of activity types. Later we will replace activity codes by the values
```R
  labels <- read.table(labels_file,sep="")
  l <- as.vector(labels[[2]])
```
#### Read file with features
* using grepl we make a vector of columns for subsetting from data set and a vector of names for our columns
```R
  features <- read.table(features_file,sep="")
  columns <- c(c(1,2),features[grepl("mean|std",as.vector(features[,2])),1]+2)
  names <- c(c("subject","activity"),as.character(features[grepl("mean|std",as.vector(features[,2])),2]))
```
#### Bind data from train and learn
* we bind trained and test data using rbind(row bind) function
```R
  subject <- rbind(read.table(subject_train,sep=""),read.table(subject_test,sep=""))
  X <- rbind(read.table(X_train,sep=""),read.table(X_test,sep=""))
  y <- rbind(read.table(y_train,sep=""),read.table(y_test,sep=""))
```
#### Make tidy date for future steps
* and unite them into one by columns(cbind), after that subset mean and std columns, assign names
* and replace codes of activity by names of activity
```R
  bindedData <- cbind(subject,y,X)[,columns]
  names(bindedData) <- names
  bindedData$activity <- as.factor(l[bindedData$activity])
```
#### Calculate mean for activity and subject
we create new factor - activityPerSubject, by pasting activity and subject together
* using cbind function we change the order of colunms
* by melt function we select "factor" columns and variables columns
* by dcast we aggregate data for factor using mean function
* return the data frame for writing to file
```R
  dataForCasting <- bindedData
  dataForCasting$activityPerSubject <- paste(dataForCasting$subject,dataForCasting$activity,sep="-")
  dataForCasting <- cbind(dataForCasting[ncol(dataForCasting)],dataForCasting[1:ncol(dataForCasting)-1])
  actMelt <- melt(dataForCasting,id="activityPerSubject",measure.vars=names[3:length(names)])
  aggregation <- dcast(actMelt,activityPerSubject ~ variable,mean)
  aggregation
```