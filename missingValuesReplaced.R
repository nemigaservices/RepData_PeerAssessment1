# Replace NaNs in mean steps per day with 0s
meanStepsPerDay[is.nan(meanStepsPerDay)]<-0
# To deal with NaNs we will replace them with means. To do that
# - create a vector with mean values for each day
meanValues <- rep(meanStepsPerDay, length(data$steps)/length(meanStepsPerDay))
# - Create new dataset.
dataNew<-data
# Now replace these values with their corresponding mean
dataNew$steps[is.na(data$steps)] <- meanValues[is.na(data$steps)]
stepsSplNew<-split(dataNew$steps, dataNew$dates$yday)
sumStepsPerDayNew<-sapply(stepsSplNew, sum, na.rm=TRUE)
library(ggplot2)
p<-ggplot(data=data.frame(uniqueDates, sumStepsPerDay), aes(x=uniqueDates, y=sumStepsPerDay))+geom_bar(stat="identity")+labs(y = "Steps per day", x="Dates", title="Steps per day including unknown values")
p2<-ggplot(data=data.frame(uniqueDates, sumStepsPerDayNew), aes(x=uniqueDates, y=sumStepsPerDayNew))+geom_bar(stat="identity")+labs(y = "Steps per day", x="Dates", title="Steps per day; unknown values replaced with mean")
install.packages("gridExtra")
library(gridExtra)
grid.arrange(p, p2, ncol=2)
meanStepsPerDayNew <- sapply(stepsSplNew, mean, na.rm=TRUE)
meanDataFrameNew <- data.frame(date=uniqueDates, meanStepsPerDay=meanStepsPerDayNew, row.names=NULL)
cat("Mean steps per day (with NaNs replaced with means):", "\n")
print(meanDataFrameNew)
medianStepsPerDayNew <- sapply(stepsSplNew, median, na.rm=TRUE)
medianDataFrameNew <- data.frame(date=uniqueDates, medianStepsPerDay=medianStepsPerDayNew, row.names=NULL)
cat("Median steps per day (with NaNs replaced with means):", "\n")
print(medianDataFrameNew)