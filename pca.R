if (!require("ggplot2")) {
    install.packages("ggplot2", repos="http://cran.rstudio.com/")
    library("ggplot2")
}
library(ggplot2)
df <- read.csv('data/tools.csv')

pc <- princomp(df[,2:length(df)], cor=FALSE, scores=TRUE)

summary(pc)

png(filename="plots/scree.png", width=900, height=589)
plot(main="Scree plot: Principal Components of Tool Use", pc,type="lines")
dev.off()

if (!require("ggfortify")) {
    install.packages("ggfortify", repos="http://cran.rstudio.com/")
    library("ggplot2")
}
library(ggfortify)
features <- df[,2:length(df)]
png(filename="plots/pca1vspca2.png", width=900, height=589)
autoplot(prcomp(features), data=df, colour = 'Program', main="Students by Program, first two principal components of tool use")
dev.off()
