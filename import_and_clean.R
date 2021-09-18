library(tidyverse)
rm(list=ls())
df <- read_csv("./data_cleaning_challenge.csv")
df <- janitor::clean_names(df)
names(df)
df <- df %>% janitor::remove_empty(c("cols","rows"))
df <- df %>% filter(row_type !="first name: Person")
df <- df %>% filter(row_type !="Row Type")

df <- df %>% filter(!row_type %in% c("Average","Maximum",
                        "Std.Dev.","Total"))
                        
df$first_name <- "Bob"
df$last_name <- "Smith"
df$index1 <- row.names(df)
df$index1 <- as.numeric(df$index1)
summary(df$index1)

## Each set consist of 5 different sets (iter_numbers)
## Thanks to Burak Can Koc @ Slack for this code.
# dat2$Date <- seq(as.Date("1959/8/2"), as.Date("2020/12/31"), "day")

date_seq <- rep(seq(as.Date("2008/9/17"), as.Date("2020/12/30"), "day"), each = 5)
date_seq <- as.data.frame(date_seq)
date_seq$rowid <- row.names(date_seq)
date_seq$rowid <- as.numeric(date_seq$rowid)
row_boats <- date_seq %>% filter(rowid <=22433)

## Rearrange Columns
df <- df %>% select(index1,first_name,last_name,row_type,iter_number,
                      power1,speed1,speed2,electricity:torque)

boats <- cbind(row_boats,df)


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
