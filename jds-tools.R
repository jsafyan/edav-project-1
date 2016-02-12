df = read.csv("data/tools.csv")

round(cor(df[,2:length(df)]), 2)

pc <- princomp(df[,2:length(df)], cor=TRUE, scores=TRUE)

summary(pc)

plot(pc,type="lines")

library(rgl)
plot3d(pc$scores[,1:3], col=df$Program)
pc$scores
