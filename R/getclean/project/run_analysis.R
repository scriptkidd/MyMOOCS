print("Checking for the existance of required packages")
#This script uses matchcols() function from gdata package and assumes that gdata package is already
#installed. 
if (!"gdata" %in% rownames(installed.packages())) { 
    print ("Installing 'gdata' package. If necessary, re-run the script after installation.")
    suppressMessages(suppressWarnings(install.packages("gdata")))
}
print ("Loading required packages")
suppressPackageStartupMessages(expr = require(package = gdata))
print ("Reading x_test data")
xtest = read.table("./test/X_test.txt", nrows = 2947,colClasses = "numeric") #Reading test data
print ("Reading x_train data")
xtrain = read.table("./train//X_train.txt",nrows = 7352,colClasses = "numeric") #Reading train data
#Reading activities done by subjects in test and train data
ytest = read.table("./test//y_test.txt")
ytrain = read.table("./train//y_train.txt")
print ("Reading features")
#Reading list of variables
features = read.table("features.txt",stringsAsFactors = FALSE)
print ("Reading test subjects")
#Reading subjects who performed activities for both test and train data
subjects = read.table("./test/subject_test.txt")
print ("Reading train subjects")
subjects_train = read.table("./train/subject_train.txt")
#adding respective activities to test data and train data
xtest = cbind(ytest,xtest)
xtrain_with_act_num = cbind(ytrain,xtrain)
#assigning column names to test and train data
names(xtrain_with_act_num) = c("activity",features[,2])
names(xtest) = c("activity",features[,2])
#adding respective subjects to test and train data, setting its column name as "subjects"
xtest= cbind("subjects"=subjects[,1],xtest)
xtrain_with_act_num= cbind("subjects"=subjects_train[,1],xtrain_with_act_num)
print("Merging test and train")
#merging test and train data
tt_merged_1 = rbind(xtest,xtrain_with_act_num)
#adding descriptive activity labels by replacing activity number
tt_merged_1[tt_merged_1$activity == 1,2] = "WALKING"
tt_merged_1[tt_merged_1$activity == 2,2] = "WALKING_UPSTAIRS"
tt_merged_1[tt_merged_1$activity == 3,2] = "WALKING_DOWNSTAIRS"
tt_merged_1[tt_merged_1$activity == 4,2] = "SITTING"
tt_merged_1[tt_merged_1$activity == 5,2] = "STANDING"
tt_merged_1[tt_merged_1$activity == 6,2] = "LAYING"
#extracting only column names that contain either mean or std in their name
cols = (matchcols(tt_merged_1, with=c("mean","std"), method="or"))
#initialize a df that will contain 'raw' data for mean and std columns
sample = data.frame(length=1)
#extracting columns that contain data on mean and std
for (i in cols[1]) { sample = cbind(sample,tt_merged_1[i])} #extracting mean columns
for (i in cols[2]) { sample = cbind(sample,tt_merged_1[i])} #extracting std columns
sample = sample[,-1]
#adding respective subjects and activity associated with the data
sample = cbind("subjects"=tt_merged_1[,1],"activity"=tt_merged_1[,2],sample)
print("Finding mean averages")
#split data into subjects and activities and compute mean 
meancomb = aggregate(sample[,3:ncol(sample)],by=list("subjects" =sample$subjects,"activity"=sample$activity), mean)
#Rename columns to indicate that the data is represented as 'average'
colnames(meancomb)[3:ncol(sample)] = paste(colnames(meancomb)[3:ncol(sample)],"MAvg",sep = "_")
print("Finding sd averages")
#split data into subjects and activities and compute sd
sdcomb = aggregate(sample[,3:ncol(sample)],by=list("subjects" =sample$subjects,"activity"=sample$activity), sd)
#Rename columns to indicate that the data is represented as 'average'
colnames(sdcomb)[3:ncol(sample)] = paste(colnames(sdcomb)[3:ncol(sample)],"SDAvg",sep = "_")
print("Making tidy data")
#combind both 'average' mean and sd columns,retain'subject' and 
#'activity' columns from only meancomb
tidy_data = cbind(meancomb,sdcomb[,-c(1:2)])  
write.table(x = tidy_data,file = "tidy_data.txt",row.names=FALSE)
print ("Done!")
