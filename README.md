# Assignment-Extraction
This is the assignment for the R coursera course

All the comments are directly reflected in the run_analysis.R file 

Logic applied

1. First reading out the labels and features from the respective files
2. Create the test data set out of the three databases labels, subhects and features
and add the the correct column names and replace the label numbers with the actual 
activitiy
3. Exactly the same procedure for the training dataset
4. As the train and test data set have the same variables, combine the two dataframes. Use a TEST/TRAIN 
indicator to label which observation was from which dataset
5. The tidy dataset was created by only selecting the variables with mean or std using grep 
and grouping this combined set by activity and subject, followed by summarizing the variables with mean
