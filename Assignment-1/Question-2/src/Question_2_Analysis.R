data=read.csv("C:/Users/Tata Rajesh Chowdary/Desktop/PDS/Assignments/Assignment-1/Question-2/Data_clean/StudentsPerformance_dataClean.csv")
View(data)

counts <- table(data$Gender, data$Race.Ethnicity)
mosaicplot(counts, main="Gender Vs Group")
#here we are analysing ratio of male & female in every group. In group C we can see Female are dominating male.

parents_education <- table(data$Parents.Education)
pie(parents_education,main="Parents Education")
#here we are accessing parents education 

labels=c('Math','Reading','Writing')
boxplot(data$Math.Score, data$Reading.Score, data$Writing.Score, names = labels)
#identifying min, max & average along with 25th & 75th percentile

preparation <- table(data$Test.Preparation.course)
preparation
barplot(preparation)
#this indicates us how many students taken the course before exam.

plot(data$Reading.Score, data$Writing.Score, xlab="Reading",ylab="Writing")