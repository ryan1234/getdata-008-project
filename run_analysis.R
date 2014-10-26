library(LaF)
library(ffbase)
library(reshape2)

downloadAndExtract <- function() {
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile="data.zip", method="curl")
  unzip("data.zip")
}

getFeatureVector <- function() {
  featureFile <- paste(getwd(), "/uci har dataset/features.txt", sep="")
  features <- read.table(featureFile, header=FALSE, sep="")
  filtered <- subset(features, grepl("mean|std", features$V2) == 1, select=V1)
  as.vector(filtered$V1)
}

getTrainingData <- function() {
  train_X_file <- paste(getwd(), "/uci har dataset/train/X_train.txt", sep="")
  train_X <- laf_open_fwf(train_X_file, column_types=rep('numeric', 561), column_widths=rep(16, 561))
  train_X_df <- as.data.frame(laf_to_ffdf(train_X))
  close(train_X)
  
  train_Y_file <- paste(getwd(), "/uci har dataset/train/Y_train.txt", sep="")
  train_Y <- cbind(scan(train_Y_file))
  colnames(train_Y)[1] <- "Activity"
  train_Y <- updateActivityLabels(train_Y)
  
  train_subject_file <- paste(getwd(), "/uci har dataset/train/subject_train.txt", sep="")
  train_subject <- cbind(scan(train_subject_file))
  colnames(train_subject)[1] <- "Subject"
    
  cbind(train_X_df, cbind(train_Y), cbind(train_subject))
}

getTestData <- function() {
  test_X_file <- paste(getwd(), "/uci har dataset/test/X_test.txt", sep="")  
  test_X <- laf_open_fwf(test_X_file, column_types=rep('numeric', 561), column_widths=rep(16, 561))
  test_X_df <- as.data.frame(laf_to_ffdf(test_X))  
  close(test_X)

  test_Y_file <- paste(getwd(), "/uci har dataset/test/Y_test.txt", sep="")
  test_Y <- cbind(scan(test_Y_file))
  colnames(test_Y)[1] <- "Activity"
  test_Y <- updateActivityLabels(test_Y)  
  
  test_subject_file <- paste(getwd(), "/uci har dataset/test/subject_test.txt", sep="")
  test_subject <- cbind(scan(test_subject_file))
  colnames(test_subject)[1] <- "Subject"

  cbind(test_X_df, test_Y, test_subject)  
}

updateActivityLabels <- function(v) {
  v <- as.data.frame(v)
  v$Activity[v$Activity == 1] <- "WALKING"
  v$Activity[v$Activity == 2] <- "WALKING UPSTAIRS"
  v$Activity[v$Activity == 3] <- "WALKING DOWNSTAIRS"
  v$Activity[v$Activity == 4] <- "SITTING"
  v$Activity[v$Activity == 5] <- "STANDING"
  v$Activity[v$Activity == 6] <- "LAYING"
  v
}

getMergedDatasets <- function() {
  rbind(getTrainingData(), getTestData())  
}

addDescriptiveVariableNames <- function(df) {
  colnames(df)[1] <- "tBodyAccelerationMeanX"
  colnames(df)[2] <- "tBodyAccelerationMeanY"
  colnames(df)[3] <- "tBodyAccelerationMeanZ"
  
  colnames(df)[4] <- "tBodyAccelerationStandardDeviationX"
  colnames(df)[5] <- "tBodyAccelerationStandardDeviationY"
  colnames(df)[6] <- "tBodyAccelerationStandardDeviationZ"

  colnames(df)[7] <- "tGravityAccelerationMeanX"
  colnames(df)[8] <- "tGravityAccelerationMeanY"
  colnames(df)[9] <- "tGravityAccelerationMeanZ"

  colnames(df)[10] <- "tGravityAccelerationStandardDeviationX"
  colnames(df)[11] <- "tGravityAccelerationStandardDeviationY"
  colnames(df)[12] <- "tGravityAccelerationStandardDeviationZ"

  colnames(df)[13] <- "tBodyAccelerationJerkMeanX"
  colnames(df)[14] <- "tBodyAccelerationJerkMeanY"
  colnames(df)[15] <- "tBodyAccelerationJerkMeanZ"
  
  colnames(df)[16] <- "tBodyAccelerationJerkStandardDeviationX"
  colnames(df)[17] <- "tBodyAccelerationJerkStandardDeviationY"
  colnames(df)[18] <- "tBodyAccelerationJerkStandardDeviationZ"

  colnames(df)[19] <- "tBodyGyroMeanX"
  colnames(df)[20] <- "tBodyGyroMeanY"
  colnames(df)[21] <- "tBodyGyroMeanZ"
  
  colnames(df)[22] <- "tBodyGyroStandardDeviationX"
  colnames(df)[23] <- "tBodyGyroStandardDeviationY"
  colnames(df)[24] <- "tBodyGyroStandardDeviationZ"

  colnames(df)[25] <- "tBodyGyroJerkMeanX"
  colnames(df)[26] <- "tBodyGyroJerkMeanY"
  colnames(df)[27] <- "tBodyGyroJerkMeanZ"

  colnames(df)[28] <- "tBodyGyroJerkStandardDeviationX"
  colnames(df)[29] <- "tBodyGyroJerkStandardDeviationY"
  colnames(df)[30] <- "tBodyGyroJerkStandardDeviationZ"

  colnames(df)[31] <- "tBodyAccelerationMagnitudeMean"
  colnames(df)[32] <- "tBodyAccelerationMagnitudeStandardDeviation"

  colnames(df)[33] <- "tGravityAccelerationMagnitudeMean"
  colnames(df)[34] <- "tGravityAccelerationMagnitudeStandardDeviation"

  colnames(df)[35] <- "tBodyAccelerationJerkMagnitudeMean"
  colnames(df)[36] <- "tBodyAccelerationJerkMagnitudeStandardDeviation"

  colnames(df)[37] <- "tBodyGyroMagnitudeMean"
  colnames(df)[38] <- "tBodyGyroMagnitudeStandardDeviation"

  colnames(df)[39] <- "tBodyGyroJerkMagnitudeMean"
  colnames(df)[40] <- "tBodyGyroJerkMagnitudeStandardDeviation"

  colnames(df)[41] <- "fBodyAccelerationMeanX"
  colnames(df)[42] <- "fBodyAccelerationMeanY"
  colnames(df)[43] <- "fBodyAccelerationMeanZ"

  colnames(df)[44] <- "fBodyAccelerationStandardDeviationX"
  colnames(df)[45] <- "fBodyAccelerationStandardDeviationY"
  colnames(df)[46] <- "fBodyAccelerationStandardDeviationZ"

  colnames(df)[47] <- "fBodyAccelerationMeanFrequencyX"
  colnames(df)[48] <- "fBodyAccelerationMeanFrequencyY"
  colnames(df)[49] <- "fBodyAccelerationMeanFrequencyZ"

  colnames(df)[50] <- "fBodyAccelerationJerkMeanX"
  colnames(df)[51] <- "fBodyAccelerationJerkMeanY"
  colnames(df)[52] <- "fBodyAccelerationJerkMeanZ"

  colnames(df)[53] <- "fBodyAccelerationJerkStandardDeviationX"
  colnames(df)[54] <- "fBodyAccelerationJerkStandardDeviationY"
  colnames(df)[55] <- "fBodyAccelerationJerkStandardDeviationZ"

  colnames(df)[56] <- "fBodyAccelerationJerkMeanFrequencyX"
  colnames(df)[57] <- "fBodyAccelerationJerkMeanFrequencyY"
  colnames(df)[58] <- "fBodyAccelerationJerkMeanFrequencyZ"

  colnames(df)[59] <- "fBodyGyroMeanX"
  colnames(df)[60] <- "fBodyGyroMeanY"
  colnames(df)[61] <- "fBodyGyroMeanZ"

  colnames(df)[62] <- "fBodyGyroStandardDeviationX"
  colnames(df)[63] <- "fBodyGyroStandardDeviationY"
  colnames(df)[64] <- "fBodyGyroStandardDeviationZ"
  
  colnames(df)[65] <- "fBodyGyroMeanFrequencyX"
  colnames(df)[66] <- "fBodyGyroMeanFrequencyY"
  colnames(df)[67] <- "fBodyGyroMeanFrequencyZ"  

  colnames(df)[68] <- "fBodyAccelerationMagnitudeMean"
  colnames(df)[69] <- "fBodyAccelerationMagnitudeStandardDeviation"
  colnames(df)[70] <- "fBodyAccelerationMagnitudeMeanFrequency"

  colnames(df)[71] <- "fBodyBodyAccelerationJerkMagnitudeMean"
  colnames(df)[72] <- "fBodyBodyAccelerationJerkMagnitudeStandardDeviation"
  colnames(df)[73] <- "fBodyBodyAccelerationJerkMagnitudeMeanFrequency"
    
  colnames(df)[74] <- "fBodyBodyGyroMagnitudeMean"
  colnames(df)[75] <- "fBodyBodyGyroMagnitudeStandardDeviation"  
  colnames(df)[76] <- "fBodyBodyGyroMagnitudeMeanFrequency"

  colnames(df)[77] <- "fBodyBodyGyroJerkMagnitudeMean"
  colnames(df)[78] <- "fBodyBodyGyroJerkMagnitudeStandardDeviation"  
  colnames(df)[79] <- "fBodyBodyGyroJerkMagnitudeMeanFrequency"
    
  df
}

downloadAndExtract()
fv <- getFeatureVector()
df <- getMergedDatasets()
subsetted <- df[,c(fv,c(562,563))]
subsetted <- addDescriptiveVariableNames(subsetted)
subsetted <- melt(subsetted, id=c("Activity", "Subject"))
subsetted <- dcast(subsetted, Activity + Subject ~ variable, mean)
write.table(subsetted, file="output.txt", row.names=TRUE)