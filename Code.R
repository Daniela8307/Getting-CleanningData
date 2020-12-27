getwd()
#Se crean las tablas de Actividades (etiquetas)
Activitytest_datos<-read.table("./UCI_HAR_Dataset/test/y_test.txt",header=FALSE)
head(Activitytest_datos)
Activitytrain_datos<-read.table("./UCI_HAR_Dataset/train/y_train.txt",header=FALSE)
head(Activitytrain_datos)
#Se crean las tablas de Sujetos
Subjecttrain_datos<-read.table("./UCI_HAR_Dataset/train/subject_train.txt",header=FALSE)
Subjecttest_datos<-read.table("./UCI_HAR_Dataset/test/subject_test.txt",header=FALSE)
head(Subjecttrain_datos)
#Se crean las tablas de Características
Featurestrain_datos<-read.table("./UCI_HAR_Dataset/train/X_train.txt",header=FALSE)
Featurestest_datos<-read.table("./UCI_HAR_Dataset/test/X_test.txt",header=FALSE)
#Se unen las tablas de Activiades de entrenamiento y prueba
Activity_datos<-rbind(Activitytrain_datos,Activitytest_datos)
#Se unen las tablas de Sujetos
Subject_datos<-rbind(Subjecttrain_datos,Subjecttest_datos)
#Se unen las tablas de características
Feature_datos<-rbind(Featurestrain_datos,Featurestest_datos)
#Como son tablas de una sola variable, se nombran las columnas de Actividades y Sujetos
names(Activity_datos)<-c("Activity_Num")
names(Subject_datos)<-c("Subject")
Nombres_Feature<-read.table("./UCI_HAR_Dataset/features.txt")
head(Nombres_Feature)
names(Feature_datos)<-Nombres_Feature$V2
?rbind
#Se une las tablas anteriores de Sujetos y Actividades
Datos<-cbind(Subject_datos,Activity_datos)
#Se unen con la tabla de Características
Datos<-cbind(Feature_datos,Datos)
names(Datos)
# Nos quedamos solo con las variables que contienen la media y desviación
Datos_media_std<-Datos[,grepl("mean\\(\\)|std\\(\\)",colnames(Datos))]
names(Datos_media_std)
Datos_act_sub<-Datos[,grepl("Activity|Subject",colnames(Datos))]
names(Datos_act_sub)
names(Datos)
DatosF<-cbind(Datos_act_sub,Datos_media_std)
names(DatosF) #Se quedo Subject y Activity Num hasta arriba
#Se adiciona a la tabla la de "Activity" para poder ingresar una descripción del Activity_Num
str(DatosF$Activity)
Activity_labels<-read.table("./UCI_HAR_Dataset/activity_labels.txt",header=FALSE)
Activity_labels
names(Activity_labels)<- c("Activity_Num","Activity_Name")
?as.factor
DatosF <- merge(Activity_labels, DatosF, by="Activity_Num", all.x=TRUE)
names(DatosF)
head(DatosF)
tail(DatosF)
str(DatosF$Activity_Name)#Se comprueba que sea de tipo caracter
names(DatosF)<-gsub("std()", "SD", names(DatosF))
names(DatosF)<-gsub("mean()", "MEAN", names(DatosF))
names(DatosF)<-gsub("^t", "time", names(DatosF))
names(DatosF)<-gsub("^f", "frequency", names(DatosF))
names(DatosF)<-gsub("Acc", "Accelerometer", names(DatosF))
names(DatosF)<-gsub("Gyro", "Gyroscope", names(DatosF))
names(DatosF)<-gsub("Mag", "Magnitude", names(DatosF))
names(DatosF)<-gsub("BodyBody", "Body", names(DatosF))
head(str(DatosF),6)
#Se construye la tabla con las medias
FinalData <- DatosF %>%
        group_by(Subject, Activity_Name) %>%
        summarise_all(funs(mean))
write.table(FinalData, "tidydata.txt", row.name=FALSE)
head(str(FinalData,6))
