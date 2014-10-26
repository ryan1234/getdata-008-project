Coursera Getting and Cleaning Data (getdata-008) Project
===================

All the code required for generating the required tidy set is in run_analysis.R

#### Requirements
The script uses the following packages:

`LaF` (for reading large data files quickly)
`ffbase` (a requirement of LaF)
`reshape2`

Commands to install these packages before running the script:

```
install.packages("LaF")
install.packages("ffbase")
install.packages("reshape2")
```

#### run_analysis.R
The script is meant to be read from the top down.

Function by function:

downloadAndExtract: Meant to download the data file and unzip it.
getFeatureVector: Go through the list of features and find the indexes of any variable with the name "mean" or "std" in it.
getTrainingData: Load all training data (X_train.txt, Y_train.txt, subject_train.txt), assign column names and merge horizontally.
getTestData: Load all test data (X_test.txt, Y_test.txt, subject_test.txt), assign column names and merge horizontally.
updateActivityLabels: Turn activity labels from integers to their textual representation.
getMergedDatasets: Merge the training and test data.
addDescriptiveVariableNames: Go through a hard coded list of column indexes and assign new column names to the merged data.

The rest of the script runs the functions above and then produces a final data set.

Line 182: Take the merged data and append subject and activity columns
Line 183: Add descriptive variable names
Line 184: Melt the merged data based on activity and subject.
Line 185: Dcast the result of line 184 and apply the mean function to each variable.
Line 186: Output the data into a text file.
