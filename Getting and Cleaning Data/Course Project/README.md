# Coursera-Getting-and-Cleaning-Data
For completion of the course project for Coursera's Getting and Cleaning Data course
Appologies, but the actual README is the Codebook.txt file. I have duplicated its contents here:


This data was collected from the UC Irvine Machine Learning repository and is located at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. It records accelerometer data from a set of 6 activities (walking, walking upstairs, walking downstairs, sitting, standing, laying) recorded on 30 subjects using the accelerometer of a smartphone worn at the waist.
  
The process for creating this final tidy dataset had the following steps:
  1. Using cbind() combine the subject_, Y_, and X_ datasets for both test and train in that order for each. This creates a single dataframe to manipulate
  2. Rename the columns using the "UCI HAR Dataset/features.txt" file which lists the column names, offsetting by 2 to include "Subject" and "Activity" first.
  3. Create a logical vector using grep() on the column names to filter only those columns which are either the first two columns or contain "mean" or "std" in some casing.
  4. After filtering the dataframe to only these columns, take the mean of all columns from the dataframe grouped by the unique pairs of (subject, activity).
  5. Load each of these mean rows into a new dataframe for each existing pair of (subject, activity), ignoring those pairs which were not present in the dataset
  
The dataset itself is essentially a single Subject column detailing which of the 30 numbered subjects gave that data, an activity for each record, and 86 other values which I frankly am not going to list out for a project like this. They are all the average of some mean or standard deviation for some specific acceleration.
  
The final data is lovated under "Final Datasets/" in the repository. Please peruse the endless decimal places to your heart's content.
