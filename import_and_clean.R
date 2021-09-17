library(tidyverse)
rm(list=ls())
df <- read_csv("./data_cleaning_challenge.csv")
df <- janitor::clean_names(df)
names(df)
df <- df %>% janitor::remove_empty(c("cols","rows"))
dat <- df %>% filter(row_type !="first name: Person")
dat1 <- dat %>% filter(row_type !="Row Type")
dat2 <- dat1 %>% filter(row_type !="Average" , row_type!="Maximum" ,
                          row_type !="Std.Dev." , row_type != "Total")
dat2$first_name <- "Bob"
dat2$last_name <- "Smith"
dat2$Ymd <- "1955-05-13"
dat2$Ymd <- as.Date(dat2$Ymd)
dat2$index1 <- row.names(dat2)
dat2$index1 <- as.numeric(dat2$index1)
summary(dat2$index1)
dat2$Date <- seq(as.Date("1959/8/2"), as.Date("2020/12/31"), "day")
## Rearrange Columns
db <- dat2 %>% select(index1,first_name,last_name,Date,row_type,iter_number,
                      power1,speed1,speed2,electricity:torque)

### Convert to numeric
db$iter_number <- as.numeric(db$iter_number)
db$power1 <- as.numeric(db$power1)
db$speed1 <- as.numeric(db$speed1)
db$speed2 <- as.numeric(db$speed2)
db$electricity <- as.numeric(db$electricity)
db$effort <- as.numeric(db$effort)
db$weight <- as.numeric(db$weight)
db$torque <- as.numeric(db$torque)

write.csv(db,file="cleaned-data.csv",row.names = FALSE)
