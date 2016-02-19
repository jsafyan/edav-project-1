if (!require("plyr")) {
    install.packages("plyr", repos="http://cran.rstudio.com/")
    library("plyr")
}
library(ggplot2)
library(reshape)
library(scales)
library(Rmisc)
library(gtable)
library(gridExtra)

#Load the data
data <- read.csv('data/survey_new.csv')
#remove all entries in which the student does not know R
data2 <- data[which(data$R != 'FALSE'),]
#Given a language, the number of people per program
data2_m <- melt(data2, id.vars="Program",measure.vars = c("SQL","Python","C.C..","Matlab","Web..html.css.js","Stata","shell..terminal...command.line.","Github"))
data2_m2 <- data2_m[which(data2_m$value!='FALSE'),]
data2_m3 <- data2_m2[order(data2_m2$Program,decreasing=TRUE),]
#in plot, x-axis contains different languages, and the bar contains the number of students
#comfortable in the given language and displays how many belong to each program
png('plots/rvsothers1.png')
ggplot(data2_m3,aes(x=data2_m3$variable,y=rep(1,279),fill=data2_m3$Program))+geom_bar( stat="identity")+xlab("Languages") +ylab("Number of Students") + theme(legend.title=element_blank())
dev.off()

data_m <- melt(data, id.vars=c("R","Python","C.C..","Matlab","Web..html.css.js"),measure.vars=c("Programming.and.Analytical.Experiences..R..graphic.basics..base..lattice..grid.etc....","Programming.and.Analytical.Experiences..R..advanced..multivariate.data.analysis..e.g..spatiotemporal.data..visualization.and.modeling..","Programming.and.Analytical.Experiences..Reproducible.documentation.with.R..e.g..R.Markdown..","Programming.and.Analytical.Experiences..Matlab..data.manipulation..analysis..visualization.and.modeling.","Programming.and.Analytical.Experiences..Github."))
#keep values in which people are confident in the skills
data_m2 <- data_m[which(data_m$value=='Confident'),]
names(data_m2)[names(data_m2)=="variable"] <- "Confident"
data_m3 <- melt(data_m2,id.vars="Confident",measure.vars=c("R","Python","C.C..","Matlab","Web..html.css.js"))
data_m4 <- data_m3[which(data_m3$value!='FALSE'),]
#Plot x-axis:skills and y-axis:number of students for each language
png('plots/rvsothers2.png')
ggplot(data_m4, aes(x=data_m4$Confident,fill=data_m4$variable))+ geom_bar( position="dodge")+xlab("Skills in Which Students are Confident") +ylab("Number of Students") + scale_x_discrete(breaks=NULL)+ theme(legend.title=element_blank())
dev.off()
