library(ggplot2)
library(reshape)
library(scales)
library(Rmisc)
library(gtable)
library(gridExtra)

data <- read.csv('data/survey_new.csv')

# Begin Gener Pronoun Section ---------------------------------------------
# Easiest question, how is the class divided by gender
data2 <- data[which(data$What.is.your.preferred.gender.pronoun. != ''),] #there is one entry without 
# preferred gender program, remove it for this portion of the analysis
t1 <- data2[order(data2$What.is.your.preferred.gender.pronoun.,decreasing = TRUE),]

png("Gender_Pronoun_Percentages.png",width=800,height=350, unit= 'px')
p1 <- ggplot(t1, aes(x = rep(1,length(t1$Program)), y = rep(1,length(t1$Program)),
                             fill = t1$What.is.your.preferred.gender.pronoun.)) +
  geom_bar(position = "fill",stat = "identity") +
  xlab('') + ylab('Percentage') + labs(fill = "Preferred \nGender\nPronoun") +
  ggtitle("Percentage of Students by Preferred Gender Pronoun") + 
  scale_y_continuous(labels = percent_format()) + coord_flip() +
  theme(plot.title = element_text(size = 16)) + scale_fill_manual(values = c('#777777','#b0c5e6','#e6b0c5')) +
  theme(axis.text.y=element_blank(), axis.ticks=element_blank(), axis.title.y=element_blank())

data2_DSI = data2[which(data2[,'Program']=='IDSE (master)' | data2[,'Program']=='Data Science Certification'),]
t1_DSI <- data2_DSI[order(data2_DSI$What.is.your.preferred.gender.pronoun.,decreasing = TRUE),]

p2 <-ggplot(t1_DSI, aes(x = rep(1,length(t1_DSI$Program)), y = rep(1,length(t1_DSI$Program)),
               fill = t1_DSI$What.is.your.preferred.gender.pronoun.)) +
  geom_bar(position = "fill",stat = "identity") +
  xlab('') + ylab('Percentage') + labs(fill = "Preferred \nGender\nPronoun") +
  ggtitle("Percentage of Data Science Students by Preferred Gender Pronoun") + theme(legend.margin =  unit(0.5, "cm")) +
  scale_y_continuous(labels = percent_format()) + coord_flip() + 
  theme(plot.title = element_text(size = 16)) + scale_fill_manual(values = c('#b0c5e6','#e6b0c5')) +
  theme(axis.text.y=element_blank(), axis.ticks=element_blank(), axis.title.y=element_blank())

# In industry, from Burtch Works 2015 Study
t1_ext <- data.frame(c(rep('Female',11),c(rep('Male',89))))
colnames(t1_ext) <- c('Gender')

p3 <-ggplot(t1_ext, aes(x = rep(1,length(t1_ext$Gender)), y = rep(1,length(t1_ext$Gender)),
                        fill = t1_ext$Gender)) +
  geom_bar(position = "fill",stat = "identity") +
  xlab('') + ylab('Percentage') + labs(fill = "Gender") +
  ggtitle("Percentage of Data Scientists by Gender") +
  scale_y_continuous(labels = percent_format()) + coord_flip() + theme(legend.margin =  unit(0.5, "cm")) +
  theme(plot.title = element_text(size = 16)) + 
  scale_fill_manual(guide = guide_legend(reverse=TRUE), values = c('#e6b0c5','#b0c5e6')) +
  theme(axis.text.y=element_blank(), axis.ticks=element_blank(), axis.title.y=element_blank())

p1 <- ggplotGrob(p1)
p2 <- ggplotGrob(p2)
p3 <- ggplotGrob(p3)

p2$grobs[[8]] <- gtable_add_cols(p2$grobs[[8]], unit(9, "mm")) #align legends
p3$grobs[[8]] <- gtable_add_cols(p3$grobs[[8]], unit(9, "mm"))

grid.newpage()
grid.arrange(p1, p2, p3, nrow = 3)
dev.off()

# Question, are there differences in the number of tools used by the different 
# gender pronoun associations?
#Remove "doesn't matter" gender pronoun as they have used both R and Python
data2 <- data2[which(data2$What.is.your.preferred.gender.pronoun. != 'doesn\'t matter'),] #there is one entry without 
png("Tool_Use_by_PGP.png",width=700,height=500, unit= 'px')
ggplot(data2, aes(x = data2$What.is.your.preferred.gender.pronoun., y = data2$Number.Tools)) +
  geom_boxplot(fill = "#b0c5e6") +
  xlab('Preferred Gender Pronoun') + ylab('# Analysis Tools') + 
  ggtitle("Average Number of Analysis Tools by Preferred Gender Pronoun") + 
  theme(plot.title = element_text(size = 22)) +
  theme(axis.text.x = element_text(size=18), axis.text.y = element_text(size=18),
        axis.title.x = element_text(size=20), axis.title.y = element_text(size=20))
dev.off()

# Confidence, look at all the confidence measures, divide by None, A little, Confident, Expert
t4 <- melt(data2,c('What.is.your.preferred.gender.pronoun.'), c(3,6,7,8,9,10))
t4[t4$value == "None","Numeric"] <- 0
t4[t4$value == "A little","Numeric"] <- 1
t4[t4$value == "Confident","Numeric"] <- 2
t4[t4$value == "Expert","Numeric"] <- 3
t4 <- t4[order(t4$Numeric),]
t4[,'Count'] <- 1

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
  ylab('Percentage') + labs(fill = "Preferred\nGender\nPronoun") +
  ggtitle("Analysis and Programming Confidence by Preferred Gender Pronoun") +
  theme(legend.text = element_text(size = 14), legend.title = element_text(size = 16)) +
  theme(plot.title = element_text(size = 16)) + scale_fill_manual(values = c('#b0c5e6','#e6b0c5')) +
  theme(plot.title = element_text(size = 20)) +
  theme(axis.text.x = element_text(size=18), axis.text.y = element_text(size=18),
        axis.title.x = element_text(size=19), axis.title.y = element_text(size=19))
dev.off()
