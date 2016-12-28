clwdays<-rep(2, length(data$dates))
clwdays[data$dates$wday>=1 & data$dates$wday<=5]<-1
dataNew$dateType<-factor(clwdays, levels=c(1,2), labels=c("Weekdays", "Weekends"))
dataNewWeekdays <- dataNew[dataNew$dateType == "Weekdays", ]
dataNewWeekends <- dataNew[dataNew$dateType == "Weekends", ]

dataNewSplitWeekdays <- split(dataNewWeekdays$steps, dataNewWeekdays$interval)
dataNewSplitWeekends <- split(dataNewWeekends$steps, dataNewWeekends$interval)

# Find the average for each interval
meanStepsPerWeekdayInterval <- sapply(dataNewSplitWeekdays, mean)
meanStepsPerWeekendInterval <- sapply(dataNewSplitWeekends, mean)

par(mfcol=c(2,1))
plot(uniqueIntervals, meanStepsPerWeekdayInterval, type="l",
     main="Average number of steps - weekdays", 
     xlab="Interval", ylab="Average # of steps", 
     lwd=2, col="blue")
plot(uniqueIntervals, meanStepsPerWeekendInterval, type="l",
     main="Average number of steps - weekends", 
     xlab="Interval", ylab="Average # of steps", 
     lwd=2, col="red")

