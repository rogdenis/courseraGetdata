Project explanations
===============

In the repo you will find four files:
* run_analysis.R
* data.txt
* README.md
* Codebook.md

__run_analysis.R__ file includes function "make_average" that returns data frame tidy data set with the average of each variable for each activity and each subject.

the __data.txt__ is the result of this code in console:
```R
source("run_analysis.R")
write.table(make_average(), file="data.txt",sep="\t")
```
Note that the required packages are:
* _scales_
* _reshape_
* _reshape2_

__Codebook.md__ is markdown file explaining the code in make_average function