library(tidyr)
library(dplyr)
library(skimr)
library(janitor)
library(skimr)
library(tidyverse)


library(readr)
DailyActivity <- read_csv("Wellness-Company/dailyActivity_merged.csv")
SleepDay <- read_csv("Wellness-Company/sleepDay_merged.csv")

head(DailyActivity)
colnames(DailyActivity)
view(DailyActivity)

head(SleepDay)
colnames(SleepDay)
view(SleepDay)

unique(DailyActivity$Id)
unique(SleepDay$Id)

n_distinct(DailyActivity$Id)
n_distinct(SleepDay$Id)

nrow(DailyActivity)
nrow(SleepDay)

Daily_Activity <- subset(DailyActivity, Calories>1000 & TotalSteps>0)
Daily_Activity <- subset(Daily_Activity, select = - SedentaryActiveDistance)
Daily_Activity <- subset(Daily_Activity, select = - TotalDistance)
Daily_Activity$ActiveMinutes = (Daily_Activity$VeryActiveMinutes + 
                                    Daily_Activity$FairlyActiveMinutes + 
                                    Daily_Activity$LightlyActiveMinutes)
view(Daily_Activity)

Sleep_Day <- subset(SleepDay, TotalMinutesAsleep >= 240)
view(Sleep_Day)

Daily_Activity %>%
  select(TotalSteps, TotalDistance, SedentaryMinutes) %>%
  summary()

Sleep_Day %>%  
  select(TotalSleepRecords, TotalMinutesAsleep, TotalTimeInBed) %>%
  summary()

ggplot(data=Daily_Activity, aes(x=TotalSteps, y=SedentaryMinutes)) + geom_point()

ggplot(data=Sleep_Day, aes(x=TotalMinutesAsleep, y=TotalTimeInBed)) + geom_point()

ggplot(data=Daily_Activity, aes(x=Calories, y=TotalSteps)) + geom_point()

Daily_Sleep <- setNames(Daily_Sleep, c('Id', 'Day', 'Sleep_Records', 'Mins_Asleep', 'Mins_In_Bed'))

write.csv(Daily_Activity,"C:\\SPB_Data\\Wellness-Company\\Daily_Activity.csv", row.names = FALSE)
write.csv(Sleep_Day,"C:\\SPB_Data\\Wellness-Company\\Daily_Sleep.csv", row.names = FALSE)


High_Daily_Activity <- subset(Daily_Activity, TotalSteps>=10000)
Low_Daily_Activity <- subset(Daily_Activity, TotalSteps<10000)
view(High_Daily_Activity)
view(Low_Daily_Activity)
write.csv(High_Daily_Activity,"C:\\SPB_Data\\Wellness-Company\\High_Daily_Activity.csv", row.names = FALSE)
write.csv(Low_Daily_Activity,"C:\\SPB_Data\\Wellness-Company\\Low_Daily_Activity.csv", row.names = FALSE)

High_Daily_Sleep <- subset(Daily_Sleep, Mins_Asleep>=540)
Daily_Sleep <- subset(Daily_Sleep, Mins_Asleep<540)
write.csv(High_Daily_Sleep,"C:\\SPB_Data\\Wellness-Company\\High_Daily_Sleep.csv", row.names = FALSE)
write.csv(Daily_Sleep,"C:\\SPB_Data\\Wellness-Company\\Low_Daily_Sleep.csv", row.names = FALSE)
view(High_Daily_Sleep)
view(Low_Daily_Sleep)



summary(Low_Daily_Activity$TotalSteps)
summary(High_Daily_Activity$TotalSteps)
summary(Low_Daily_Activity$Calories)
summary(High_Daily_Activity$Calories)

activity <- c("Low", "High")
num_of_records <- c(555, 303)
steps <- c(5641, 13337)
calories <- c(2170, 2744)

Activity_Summary <- data.frame(activity, num_of_records, steps, calories)
view(Activity_Summary)

write.csv(Activity_Summary,"C:\\SPB_Data\\Wellness-Company\\Activity_Summary.csv", row.names = FALSE)



summary(Low_Daily_Sleep$Mins_Asleep)
summary(High_Daily_Sleep$Mins_Asleep)
summary(Low_Daily_Sleep$Mins_In_Bed)
summary(High_Daily_Sleep$Mins_In_Bed)

sleep <- c("Low", "High")
num_of_records <- c(344, 39)
mins_asleep <- c(422.5, 610.3)
mins_in_bed <- c(458.5, 674.3)

Sleep_Summary <- data.frame(sleep, num_of_records, mins_asleep, mins_in_bed)
view(Sleep_Summary)

write.csv(Sleep_Summary,"C:\\SPB_Data\\Wellness-Company\\Sleep_Summary.csv", row.names = FALSE)
