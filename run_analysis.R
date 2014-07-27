# Script to process the Human Activity Recognition Using Smartphones Data Set.
# Assignment for Coursera's "Getting and Cleaning Data".

# Load required libraries
library(plyr)

# This variable stores the location of the data set.
DATA_PATH='/home/javi/coursera/gcd_assignment/UCI HAR Dataset'

setwd(DATA_PATH)

# Merging of training and test sets.

OUTPUT_DIR="merged"
if(!file.exists(OUTPUT_DIR)){
  dir.create(file.path('./',OUTPUT_DIR))
}
files=dir('train/')
files2=dir('test/')

for(i in 1:length(files)){
  if(substring(files[i],nchar(files[i])-3,nchar(files[i]))==".txt")
  {    
    outfile<-paste(strsplit(files[i],"_train")[[1]][1],'.txt',sep='')
    cat(readLines(file.path('train/',files[i])),file=file.path(OUTPUT_DIR,outfile),sep='\n')
    cat(readLines(file.path('test/',files2[i])),file=file.path(OUTPUT_DIR,outfile),sep='\n',append=T)
  }
}

OUTPUT_DIR2="merged/Inertial Signals/"
if(!file.exists(OUTPUT_DIR2)){
  dir.create(file.path('./',OUTPUT_DIR2))
}

files=dir('train/Inertial Signals/')
files2=dir('test/Inertial Signals/')
for(i in 1:length(files)){
  if(substring(files[i],nchar(files[i])-3,nchar(files[i]))==".txt")
  {    
    outfile<-paste(strsplit(files[i],"_train")[[1]][1],'.txt',sep='')
    cat(readLines(file.path('train/Inertial Signals/',files[i])),file=file.path(OUTPUT_DIR2,outfile),sep='\n')
    cat(readLines(file.path('test/Inertial Signals/',files2[i])),file=file.path(OUTPUT_DIR2,outfile),sep='\n',append=T)
  }
}

# End of merging

# Extracting data.
tidy_data<-data.frame(readLines('merged/subject.txt'),readLines('merged/y.txt'))
features<-readLines('features.txt')
idx_mean<-grep("mean",features)
idx_std<-grep("std",features)

# Temporary data frame to store the values from X.txt

conn<-file('merged/X.txt')
open(conn)
xtmp<-read.table(conn,colClasses='numeric')
close(conn)
xtmp<-xtmp[c(idx_mean,idx_std)]

# Adding to the tidy_data data frame.

tidy_data<-cbind(tidy_data,xtmp)
rm(xtmp)
features<-sapply(1:length(c(idx_mean,idx_std)),f<-function(i) strsplit(features," ")[[i]][2])
names(tidy_data)<-c("subject","activity",features)

# Set activity names.
act_labels<-readLines("activity_labels.txt")
act_labels<-sapply(1:length(act_labels),f<-function(i) strsplit(act_labels," ")[[i]][2])
tidy_data$activity<-act_labels[tidy_data$activity]

# Second data frame
tidy_data2<-data.frame(matrix(NA,ncol=length(tidy_data)-1,nrow=1))
# Calculate the average per subject.
for(i in 1:30)
{
  tidy_data2[i,]<-c(paste("subject",1,sep="_"),sapply(3:81,function(x) mean(tidy_data[tidy_data$subject==i,x])))
}
# Calculate the average per activity.
for(i in 1:length(act_labels))
{
  tidy_data2[i+30,]<-c(paste("activity",act_labels[i],sep="_"),sapply(3:81,function(x) mean(tidy_data[tidy_data$activity==act_labels[i],x])))
}

names(tidy_data2)<-c("grouping_variable",names(tidy_data[,3:length(tidy_data)]))