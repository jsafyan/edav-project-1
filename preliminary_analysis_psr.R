library(ggplot2)
library(reshape)
library(scales)
library(Rmisc)

data <- read.csv('data/survey_new.csv')

# Question, who is in the class? How familiar are they with R?
ggplot(data, aes(data$Program, fill = data$R)) + geom_bar() +
  xlab('Program') + ylab('Count') + labs(fill = "Proficient with R") +
  ggtitle("R Programming Proficiency by Program") +
  theme(plot.title = element_text(size = 16)) + scale_fill_manual(values = c('#e6b0c5','#b0c5e6'))

# Question, are there differences in the number of tools used by DSI MS students,
# DSI Certificate students, and everyone else. Look at mean and standard deviation.
ggplot(data, aes(x = data$Program, y = data$Number.Tools)) + geom_boxplot(fill = "#b0c5e6") +
  xlab('Program') + ylab('# Analysis Tools') + 
  ggtitle("Average Number of Analysis Tools by Program") + 
  theme(plot.title = element_text(size = 16)) 

# Question, what are the most popular tools?
temp <- melt(data, c(colnames(data[,c(1:10,31)])))
temp <- temp[which(temp[,13] == TRUE),]
ggplot(temp, aes(temp$variable)) + geom_bar() +
  xlab('Program') + ylab('Count') + 
  ggtitle("Program Use Frequency") 

# Begin Gener Pronoun Section ---------------------------------------------
# Easiest question, how is the class divided by gender
data2 <- data[which(data$What.is.your.preferred.gender.pronoun. != ''),] #there is one entry without 
# preferred gender program, remove it for this portion of the analysis
t1 <- data2[order(data2$What.is.your.preferred.gender.pronoun.,decreasing = TRUE),]

png("Gender_Pronoun_Percentages.png",width=800,height=200, unit= 'px')
ggplot(t1, aes(x = rep(1,length(t1$Program)), y = rep(1,length(t1$Program)),
                             fill = t1$What.is.your.preferred.gender.pronoun.)) +
  geom_bar(position = "fill",stat = "identity") +
  xlab('') + ylab('Percentage') + labs(fill = "Preferred Gender Pronoun") +
  ggtitle("Percentage of Students by Preferred Gender Pronoun") +
  scale_y_continuous(labels = percent_format()) + coord_flip() +
  theme(plot.title = element_text(size = 16)) + scale_fill_manual(values = c('#777777','#b0c5e6','#e6b0c5')) +
  theme(axis.text.y=element_blank(), axis.ticks=element_blank(), axis.title.y=element_blank())
dev.off()

# Question, are there differences in the number of tools used by the different 
# gender pronoun associations?
png("Tool_Use_by_PGP.png",width=700,height=500, unit= 'px')
ggplot(data2, aes(x = data2$What.is.your.preferred.gender.pronoun., y = data2$Number.Tools)) +
  geom_boxplot(fill = "#b0c5e6") +
  xlab('Preferred Gender Pronoun') + ylab('# Analysis Tools') + 
  ggtitle("Average Number of Analysis Tools by Preferred Gender Pronoun") + 
  theme(plot.title = element_text(size = 16)) 
dev.off()

# Question, do the genders have different experiences with R/Python use?
p1 <- ggplot(data2, aes(data2$What.is.your.preferred.gender.pronoun., fill = data2$R)) + geom_bar() +
  xlab('Preferred Gender Pronoun') + ylab('Count') + labs(fill = "Experience with R") +
  ggtitle("R Programming Experience by Preferred Gender Pronoun") +
  theme(plot.title = element_text(size = 16)) + scale_fill_manual(values = c('#e6b0c5','#b0c5e6'))

p2<- ggplot(data2, aes(data2$What.is.your.preferred.gender.pronoun., fill = data2$Python)) + geom_bar() +
  xlab('Preferred Gender Pronoun') + ylab('Count') + labs(fill = "Experience with Python") +
  ggtitle("Python Programming Experience by Preferred Gender Pronoun") +
  theme(plot.title = element_text(size = 16)) + scale_fill_manual(values = c('#e6b0c5','#b0c5e6'))

multiplot(p1,p2, cols =2)

# Not very informative, replot by percentage. Remove "doesn't matter" gender pronoun as they have used both R and Python
data2 <- data2[which(data2$What.is.your.preferred.gender.pronoun. != 'doesn\'t matter'),] #there is one entry without 
# preferred gender program, remove it for this portion of the analysis
png("R_and_Python_by_PGP.png",width=1000,height=700, unit= 'px')

t2 <- melt(data2,c('What.is.your.preferred.gender.pronoun.'), c('R'))
t2 <- t2[order(t2$value),]
p1 <- ggplot(t2, aes(x = t2$What.is.your.preferred.gender.pronoun., y = rep(1,length(t2$value)), fill = t2$value)) +
  geom_bar(position = "fill",stat = "identity") +
  xlab('Preferred Gender Pronoun') + ylab('Percentage') + labs(fill = "Experience with R") +
  ggtitle("R Programming Experience by Preferred Gender Pronoun") +
  scale_y_continuous(labels = percent_format()) +
  theme(plot.title = element_text(size = 14)) + scale_fill_manual(values = c('#B22222','#5F9EA0'))

t3 <- melt(data2,c('What.is.your.preferred.gender.pronoun.'), c('Python'))
t3 <- t3[order(t3$value),]
p2 <- ggplot(t3, aes(x = t3$What.is.your.preferred.gender.pronoun., y = rep(1,length(t3$value)), fill = t3$value)) +
  geom_bar(position = "fill",stat = "identity") +
  xlab('Preferred Gender Pronoun') + ylab('Percentage') + labs(fill = "Experience with Python") +
  ggtitle("Python Programming Experience by Preferred Gender Pronoun") +
  scale_y_continuous(labels = percent_format()) +
  theme(plot.title = element_text(size = 14)) + scale_fill_manual(values = c('#B22222','#5F9EA0'))

multiplot(p1,p2, cols =2)
dev.off()

# Compare the two skills within genders
t2 <- data2[which(data2[,'What.is.your.preferred.gender.pronoun.'] == 'he/him'),]
t2 <- melt(t2,c('What.is.your.preferred.gender.pronoun.'),c('R','Python'))
t2 <- t2[order(t2$value),]
p1 <- ggplot(t2, aes(x = t2$variable, y = rep(1,length(t2$variable)), fill = t2$value)) +
  geom_bar(position = "fill",stat = "identity") +
  xlab('Preferred Gender Pronoun') + ylab('Percentage') + labs(fill = "Experience with Language") +
  ggtitle("R and Python Programming Experience by Gender Pronoun he/him") +
  scale_y_continuous(labels = percent_format()) +
  theme(plot.title = element_text(size = 16)) + scale_fill_manual(values = c('#e6b0c5','#b0c5e6'))

t3 <- data2[which(data2[,'What.is.your.preferred.gender.pronoun.'] == 'she/her'),]
t3 <- melt(t3,c('What.is.your.preferred.gender.pronoun.'),c('R','Python'))
t3 <- t3[order(t3$value),]
p2 <- ggplot(t3, aes(x = t3$variable, y = rep(1,length(t3$variable)), fill = t3$value)) +
  geom_bar(position = "fill",stat = "identity") +
  xlab('Preferred Gender Pronoun') + ylab('Percentage') + labs(fill = "Experience with Language") +
  ggtitle("R and Python Programming Experience by Gender Pronoun she/her") +
  scale_y_continuous(labels = percent_format()) +
  theme(plot.title = element_text(size = 16)) + scale_fill_manual(values = c('#e6b0c5','#b0c5e6'))

multiplot(p1,p2, cols =2)

# Confidence, look at all the confidence measures, divide by None, A little, Confident, Expert
t4 <- melt(data2,c('What.is.your.preferred.gender.pronoun.'), c(3,6,7,8,9,10))
t4[t4$value == "None","Numeric"] <- 0
t4[t4$value == "A little","Numeric"] <- 1
t4[t4$value == "Confident","Numeric"] <- 2
t4[t4$value == "Expert","Numeric"] <- 3
t4 <- t4[order(t4$Numeric),]
t4[,'Count'] <- 1

ggplot(t4, aes(x = t4$What.is.your.preferred.gender.pronoun., y = rep(1,length(t4$value)), fill = t4$value)) +
  geom_bar(position = "fill",stat = "identity") +
  xlab('Preferred Gender Pronoun') + ylab('Percentage') + labs(fill = "Confidence Level") +
  ggtitle("Programming Confidence by Preferred Gender Pronoun") +
  scale_y_continuous(labels = percent_format()) +
  theme(plot.title = element_text(size = 16)) 

t5 <- data.frame(rep(0,4),rep(0,4),c(0,1,2,3))
colnames(t5) <- c('he/him','she/her','level')
for (i in 0:3){
  t5[i+1,'he/him'] <- length(which(t4[which(t4$What.is.your.preferred.gender.pronoun. == 'he/him'),4] == i))/
    length(which(t4$What.is.your.preferred.gender.pronoun. == 'he/him'))
  t5[i+1,'she/her'] <- length(which(t4[which(t4$What.is.your.preferred.gender.pronoun. == 'she/her'),4] == i))/
    length(which(t4$What.is.your.preferred.gender.pronoun. == 'she/her'))
}
t5 <- melt(t5,'level')

png("Tool_Confidence_by_PGP.png",width=700,height=500, unit= 'px')
ggplot(t5) + geom_bar(aes(x = as.factor(t5$level), y = t5$value, fill = t5$variable),stat = 'identity', position = 'dodge' ) +
  scale_y_continuous(labels = percent_format()) + xlab('Confidence Level') +
  scale_x_discrete(breaks=c(0,1,2,3),labels=c("None", "A little", "Confident","Expert")) +
  ylab('Percentage') + labs(fill = "Preferred Gender Pronoun") +
  ggtitle("Programming Confidence by Preferred Gender Pronoun") +
  theme(plot.title = element_text(size = 16)) + scale_fill_manual(values = c('#b0c5e6','#e6b0c5'))
dev.off()