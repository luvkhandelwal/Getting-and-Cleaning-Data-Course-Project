##Initialization
rm(list = ls())
getwd()
library(dplyr)
library(tidyr)
library(data.table)
setwd("C:\\Users\\luv\\Desktop\\Online Courses\\DATA SCIENCE\\Data Cleaning\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset")

##Reading Test data files :X , y and subject 
test_data<-read.table("C:\\Users\\luv\\Desktop\\Online Courses\\DATA SCIENCE\\Data Cleaning\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\test\\X_test.txt")
ytest_data<-read.table("C:\\Users\\luv\\Desktop\\Online Courses\\DATA SCIENCE\\Data Cleaning\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\test\\y_test.txt",col.names = "label")
stest_data<-read.table("C:\\Users\\luv\\Desktop\\Online Courses\\DATA SCIENCE\\Data Cleaning\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\test\\subject_test.txt",col.names = "subject")

##Reading Train data files :X , y and subject 
train_data<-read.table("C:\\Users\\luv\\Desktop\\Online Courses\\DATA SCIENCE\\Data Cleaning\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\train\\X_train.txt")
ytrain_data<-read.table("C:\\Users\\luv\\Desktop\\Online Courses\\DATA SCIENCE\\Data Cleaning\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\train\\y_train.txt",col.names = "label")
strain_data<-read.table("C:\\Users\\luv\\Desktop\\Online Courses\\DATA SCIENCE\\Data Cleaning\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\train\\subject_train.txt",col.names = "subject")

##Column bindindg these files 
ctest_data<-cbind(stest_data,test_data,ytest_data)
ctrain_data<-cbind(strain_data,train_data,ytrain_data)

##Check if same number of columns before appending 
length(names(ctrain_data))==length(names(ctest_data))

##Appending two tables
completedata<-rbind(ctrain_data,ctest_data)

##Mean for each activity 
data_mean<-apply(completedata[,2:562],2,mean)
data_std<-apply(completedata[,2:562], 2,sd)

#Reading the names of each activity 
features<-read.table("C:\\Users\\luv\\Desktop\\Online Courses\\DATA SCIENCE\\Data Cleaning\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\features.txt")

#Tidy column names and assigning them to the data set 
feature<-as.vector(features$V2)
feature<-tolower(gsub("[()]","",feature)) 
setnames(completedata,old = c(paste('V',1:561,sep = "")),new = feature)

#Mean by subject and label
new_data<- aggregate(completedata[, 3:562],by=list(subject = completedata$subject, 
                                                   label = completedata$label),mean)

head(new_data)
write.table(new_data, "tidy_luv.txt",row.names=F, col.names=F, quote=2)
