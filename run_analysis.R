make_average <- function(){
  subject_train <- "UCI HAR Dataset/train/subject_train.txt"
  subject_test <- "UCI HAR Dataset/test/subject_test.txt"

  X_train <- "UCI HAR Dataset/train/X_train.txt"
  X_test <- "UCI HAR Dataset/test/X_test.txt"

  y_train <- "UCI HAR Dataset/train/y_train.txt"
  y_test <- "UCI HAR Dataset/test/y_test.txt"

  features_file <- "UCI HAR Dataset/features.txt"

  labels_file <- "UCI HAR Dataset/activity_labels.txt"

  labels <- read.table(labels_file,sep="")
  l <- as.vector(labels[[2]])

  features <- read.table(features_file,sep="")
  columns <- c(c(1,2),features[grepl("mean|std",as.vector(features[,2])),1]+2)
  names <- c(c("subject","activity"),as.character(features[grepl("mean|std",as.vector(features[,2])),2]))

  subject <- rbind(read.table(subject_train,sep=""),read.table(subject_test,sep=""))
  X <- rbind(read.table(X_train,sep=""),read.table(X_test,sep=""))
  y <- rbind(read.table(y_train,sep=""),read.table(y_test,sep=""))

  bindedData <- cbind(subject,y,X)[,columns]
  names(bindedData) <- names
  bindedData$activity <- as.factor(l[bindedData$activity])

  dataForCasting <- bindedData
  dataForCasting$activityPerSubject <- paste(dataForCasting$subject,dataForCasting$activity,sep="-")
  dataForCasting <- cbind(dataForCasting[ncol(dataForCasting)],dataForCasting[1:ncol(dataForCasting)-1])
  actMelt <- melt(dataForCasting,id="activityPerSubject",measure.vars=names[3:length(names)])
  aggregation <- dcast(actMelt,activityPerSubject ~ variable,mean)
  aggregation
}