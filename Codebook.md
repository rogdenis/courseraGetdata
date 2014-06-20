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
```R
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile="data.zip")
  unzip("data.zip")
```
#### Assign filenames and paths to variables
```
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
```
```
#### Read file with features
```
```
#### Bind data from train and learn
```
```
#### Make tidy date for future steps
```
```
#### Calculate mean for activity and subject
```
```