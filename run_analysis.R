# Function that builds and returns a single data frame with column names by combining the data in the 5 neccesary files
# Params:
# - dataFile: file containing the observations (for example, X_test.txt )
# - subjectFile: file containing the subject corresponding to each observation (for example, subject_test.txt )
# - labelFile: file containing the class (or "label" in a more machine learning context) corresponding to each observation (for example, y_test.txt)
# - labelDescFile: file containing the code and description of each label
# - vNamesFile: file containing the names of the variables in the observations (this should be the features.txt file)
readDataSet <- function(dataFile, subjectFile, labelFile, labelDescFile, vNamesFile,...){

    x<-read.table(dataFile,...)

    #read the rest of files
    y<-read.table(subjectFile,col.names=c("subject.id"),...)
    z<-read.table(labelFile,col.names=c("label.id"),...)
    n<-read.table(vNamesFile)
    l<-read.table(labelDescFile,col.names=c("label.id","label.description"),...)

    #Remove parentheses from column names and assign names to columns
    cleanNames<-gsub("\\(\\)","",n[,2])
    names(x)<-cleanNames
    
    #keep only columns with "std" or "mean" in their name
    selectedNames<-grep("mean|std",cleanNames)    
    x<-x[,selectedNames]    
    
    #combine the data in a single data frame, as required
    x<-cbind(x,y,z)
    x<-merge(l,x,by.x="label.id",by.y="label.id",all=TRUE)
    x
}

#Function that loads the data, performs the neccessary transformations/aggregations and returns
#a new data.frame as specified by the assignment requirements.
generateTidyDataSet <- function(){
    # Read and prepare both datasets: test and training
    ts<-readDataSet("./UCI HAR Dataset/test/X_test.txt",
                    "./UCI HAR Dataset/test/subject_test.txt",
                    "./UCI HAR Dataset/test/y_test.txt",
                    "./UCI HAR Dataset/activity_labels.txt",
                    "./UCI HAR Dataset/features.txt")
    tr<-readDataSet("./UCI HAR Dataset/train/X_train.txt",
                    "./UCI HAR Dataset/train/subject_train.txt",
                    "./UCI HAR Dataset/train/y_train.txt",
                    "./UCI HAR Dataset/activity_labels.txt",
                    "./UCI HAR Dataset/features.txt")
    
    #join them in the same data frame
    f<-rbind(tr,ts)
    
    #create the new dataset with the average of each variable for each activity and each subject
    l<-list(activity.id=f$label.id,activity.description=f$label.description,subject.number=f$subject.id)
    #the following call to "aggregate" generates several warnings that can be safely ignored.
    averaged<-aggregate(f,l,mean)
    
    #append the ".averaged" suffix to variables to differentiate them from the originals
    colNames<-names(averaged)
    colNames[6:84]<-paste(colNames[6:84],".Averaged",sep="")
    names(averaged)<-colNames
    
    #remove unnecesary columns
    averaged$subject.id<-NULL
    averaged$label.id<-NULL
    averaged$label.description<-NULL
    averaged
}

#Entry point: get the "tidy" data frame and write it to disk.
tidyData<-generateTidyDataSet()
write.csv(tidyData,"./tidyDataSet.txt",row.names=FALSE)
