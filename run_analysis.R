library("dplyr")

merge_files <- function(feature_file = "UCI HAR Dataset//features.txt",
                        activity_labels_file = "UCI HAR Dataset//activity_labels.txt",
                        
                        subject_train_file = "UCI HAR Dataset//train//subject_train.txt",
                        y_train_file = "UCI HAR Dataset//train//y_train.txt",
                        x_train_file = "UCI HAR Dataset//train//x_train.txt",
                        
                        subject_test_file = "UCI HAR Dataset//test//subject_test.txt",
                        y_test_file = "UCI HAR Dataset//test//y_test.txt",
                        x_test_file = "UCI HAR Dataset//test//x_test.txt",
                        
                        lines = -1,
                        vars = c(1:6,
                                 41:46,
                                 81:86,
                                 121:126,
                                 161:166,
                                 201:202,
                                 214:215,
                                 227:228,
                                 240:241,
                                 253:254,
                                 266:271,
                                 345:350,
                                 424:429,
                                 503:504,
                                 516:517,
                                 529:530,
                                 542:543))
{
    ## generate data frame from train data, using clean_data function.
    
    print("--Generating Tidy Train Data--")
    train = clean_data(feature_file=feature_file,
               activity_labels_file=activity_labels_file,
               subject_file=subject_train_file,
               y_file=y_train_file,
               x_file=x_train_file,
               lines=lines,
               vars=vars)

    ## generate data frame from test data, using clean_data function.
    print("--Generating Tidy Test Data--")
    test = clean_data(feature_file=feature_file,
                       activity_labels_file=activity_labels_file,
                       subject_file=subject_test_file,
                       y_file=y_test_file,
                       x_file=x_test_file,
                       lines=lines,
                       vars=vars)
    
    print("--Generating final data--")
    
    ##Merge train + test data
    final <- rbind(train,test)
    
    ##Calculate mean() group by Subject and Activity    
    
    final <- {final %>%
        group_by(Subject, Activity) %>%
        summarise_each(funs(mean))}
    
    
    ##Generate result file
    write.table(final, file="output.txt",row.name=FALSE)

}






clean_data <- function(feature_file, activity_labels_file, subject_file,
                       y_file,x_file,lines,vars)
{
## -Reading Files
    print(paste("  reading file:",feature_file))
    feature_data <- read.table(feature_file,col.names = c("ID","Feature"))
    x_column_name = feature_data[vars,]
    x_column_name = x_column_name[,"Feature"]
    
    print(paste("  reading file:",activity_labels_file))
    activity_labels_data <- read.table(activity_labels_file, col.names = c("y","Activity"))
    
    print(paste("  reading file:",subject_file))
    data <- read.table(subject_file, nrows = lines, col.names = "Subject")
    
    print(paste("  reading file:",y_file))
    y_data <- read.table(y_file, col.names= "y", nrows = lines)
        
    print(paste("  reading file:",x_file))
    x_data <- read.table(x_file,nrows = lines)
    x_data <- x_data[,paste("V",vars,sep = "")]
    colnames(x_data) <- x_column_name
   
print("  Add Activity Label")
    data <- cbind(data,y_data)
    data <- merge(data,activity_labels_data,by="y",sort = FALSE)
    data <- data[,c("Subject","Activity")]
    
    data <- cbind(data,x_data)
   
   return(data)
}

