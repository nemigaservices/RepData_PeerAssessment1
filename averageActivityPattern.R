intervalSplit <- split(data$steps, data$interval)
averageStepsPerInterval <- sapply(intervalSplit, mean, na.rm=TRUE)
plot(uniqueIntervals, averageStepsPerInterval, type="l",main="Average number of steps per interval", xlab="Interval", ylab="Average # of steps ", lwd=2, col="red")
maxIntervalDays <- max(averageStepsPerInterval, na.rm=TRUE)
maxIndex <- as.numeric(which(averageStepsPerInterval == maxIntervalDays))
maxInterval <- uniqueIntervals[maxIndex]
abline(v=maxInterval, col="blue", lwd=3)