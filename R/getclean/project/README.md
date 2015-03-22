How the script works?

1. Read test and train data
2. Read activities and subjects data
3. Read names of variables measured in test and train data
4. Label test and train data columns with descriptive variable names
5. Label activities with descriptive names
6. Combine test and train data
7. Extract only those columns with mean and standard deviation in the name
8. Compute average of each variable for each activity and each subject and write to a csv file

Note:

1. This script works as long as you are in the Samsung data is in your working directory.
2. This script uses matchcols() function from gdata package and assumes that gdata package is already
installed. I am checking for the existance of the package even though  it is not a 'rubrics' for evaluation.
If the script throws some unexpected error:
	a. Use intall.packages("gdata") to install gdata
	b. Make sure you are in "UCI HAR Dataset" folder
