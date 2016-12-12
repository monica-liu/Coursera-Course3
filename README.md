# Getting and Cleaning Data Course Project

The dataset originates from an experiment which measured six activities using the accelerometers in Samsung Galaxy S II smartphones.

The script assumes the dataset has already been downloaded and unzipped into a folder named "UCIHAR". The script then executes the following steps:

- Import dplyr library
- Reads in the test datasets
- Merges the test datasets
- Reads in the training datasets
- Merges the training datasets
- Merges the (merged) test and training datasets
- Reads in the measurement labels
- Applies the measurement labels as column headers to the merged test and training dataset
- Reads in the activity labels
- Updates the activity column in the  merged dataset with the activity label names
- Cleans the column names
- Removes duplicate columns
- Groups the data by subject and activity, and calculates the means
- Writes the results to a txt file
