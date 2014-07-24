DataCleaningProject
===================
1.Read X_train.txt, y_train.txt, subject_train.txt into R as data frames.
2.cbind the above 3 data frames in R, yielding a new data frame called "train"
3.Do 1&2 again for the test sets, yielding a new data frame called "test"
4.rbind the above 2 data frames,"train" and "test"
5.Extract the columns associated with Mean, Standard Deviations, and the columns for labels and subjects.
6.Rename the columns
7.Use descriptive activity names to name the activities
8.Collapse the data frame, calculate the mean for each combination of activity+subject, yielding another dataset called "agg"
9.use write.table() to produce an output dataset with the "agg" data frame
