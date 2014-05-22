GACDproject
===========

Description
---------------
Repository for the project assignment in Coursera's [Getting and Cleaning Data](https://www.coursera.org/course/getdata) course.

Content
-----------
### Raw data
Raw data is under the **UCI HAR Dataset** directory. It corresponds to the ["Human Activity Recognition Using Smartphones Data Set"](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) and has been downloaded from the [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/index.html).  It is divided in two datasets, named "train" and "test", separated in different directories under the parent **UCI HAR Dataset** directory.. Both datasets contains similar files in the same format. For more information about the structure of the raw data, check the **README.txt** file under the **UCI HAR Dataset** directory.

### R code to generate the tidy dataset
The **run_analysis.R** file is an R Script that, when executed, proccesses the raw data and generates the file **tidyDataSet.txt**. It has been developed and tested in R version 3.0.2 (2013-09-25) under [Ubuntu Linux](http://www.ubuntu.com/download) 14.04 (64 bits)

### Tidy dataset
The file **tidyDataSet.txt** is the final deliverable for this project. It is generated as the result of running the R **run_analysis.R** script. You can find details on the contained data, it's structure and how it is computed in the **CodeBook.md** file.