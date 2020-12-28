# Getting-CleanningData
The first thing I did was download the data. 
Then create the Train and Test Activities table ("./UCI_HAR_Dataset/test/y_test.txt" and the same with /train/y_train.txt), 
same case for Subject ("./UCI_HAR_Dataset/train/subject_train.txt" and test / subject_test.txt) 
and Feature ("./UCI_HAR_Dataset/train/X_train.txt" with test / X_test.txt) 
and later names were placed, the Activity and Subject tables only one word, while Feature was took the values from the table "features". 
These three tables are taken and joined into one.
Subsequently, the variables that represent the mean and standard deviation are selected using "grepl". 
Later, the "Activity_name" variable is added to the debugged table with the "merge" function.
Later the variables are renamed to make them identifiable (Std (), mean (), t, f, Acc, Gyro, Mag, BodyBody)
Y por último, se crea una tabla con la media de los datos.
