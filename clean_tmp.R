library(gdata)


mydata <- as.data.frame(read.xls('Survey Response.xlsx', perl = perl))

#looks like there are several columns with NAs, some with more NAs than others
omits <-c()

# Remove empty columns
for (col in colnames(mydata)){
  if (length(mydata[which(is.na(mydata[,col])),col]) == dim(mydata)[1]){
    omits <- c(omits, col)
  }
}

mydata <- mydata[,!(colnames(mydata) %in% omits)]

# Add factor levels for each skill
temp = strsplit(as.character(mydata$Experiences.with.tools),split = ', ')
tool_name = unique(unlist(temp))

for (i in 1:dim(mydata)[1]){
  for (j in 1:length(tool_name)){
    if (tool_name[j] %in% strsplit(as.character(mydata$Experiences.with.tools),split = ', ')[[i]]){
      mydata[i,tool_name[j]] = 1
    }
    else{
      mydata[i,tool_name[j]] = 0
    }
  }
}

# Add a number of tools column
##for (i in 1:dim(mydata)[1]){
# mydata[i,'Number.Tools'] <- length(strsplit(as.character(mydata$Experiences.with.tools),split = ', ')[[i]])
#}

# Remove column hosting set of tools
mydata <-mydata[,!(colnames(mydata) %in% 'Experiences.with.tools')]
#Remove other columns
mydata <-mydata[,!(colnames(mydata) %in% 'Are.you.on.the.waiting.list.')]
mydata <-mydata[,!(colnames(mydata) %in% 'Program')]
mydata <-mydata[,!(colnames(mydata) %in% 'What.is.your.preferred.gender.pronoun.')]
mydata <-mydata[,!(colnames(mydata) %in% 'What.code.text.editor.do.you.use.most.')]
mydata <-mydata[,!(colnames(mydata) %in% 'Programming.and.Analytical.Experiences..R..graphic.basics..base..lattice..grid.etc....')]
mydata <-mydata[,!(colnames(mydata) %in% 'Programming.and.Analytical.Experiences..R..advanced..mult')]
mydata <-mydata[,!(colnames(mydata) %in% 'Programming.and.Analytical.Experiences..Reproducible.doc')]
mydata <-mydata[,!(colnames(mydata) %in% 'Programming.and.Analytical.Experiences..Matlab..data.mani')]
mydata <-mydata[,!(colnames(mydata) %in% 'Programming.and.Analytical.Experiences..Github.')]
mydata <-mydata[,!(colnames(mydata) %in% 'Programming.and.Analytical.Experiences..R..data.manipulation.and.modeling.')]
mydata <-mydata[,!(colnames(mydata) %in% 'Programming.and.Analytical.Experiences..R..advanced..multivariate.data.analysis..e.g..spatiotemporal.data..visualization.and.modeling..')]
mydata <-mydata[,!(colnames(mydata) %in% 'Programming.and.Analytical.Experiences..Reproducible.documentation.with.R..e.g..R.Markdown..')]
mydata <-mydata[,!(colnames(mydata) %in% 'Programming.and.Analytical.Experiences..Matlab..data.manipulation..analysis..visualization.and.modeling.')]
# Prepare Data

mydata <- na.omit(mydata) # listwise deletion of missing
mydata <- scale(mydata) # standardize variables

plot_kmeans = function(df, clusters, runs, standardize=F) {
  library(psych)
  library(ggplot2)
  
  #standardize
  if (standardize) df = std_df(df)
  
  #cluster
  tmp_k = kmeans(df, centers = clusters, nstart = 20)

  
  #factor
  tmp_f = fa(df, 2, rotate = "none")
  
  #collect data
  tmp_d = data.frame(matrix(ncol=0, nrow=nrow(df)))
  tmp_d$cluster = as.factor(tmp_k$cluster)
  tmp_d$Students = as.numeric(tmp_f$scores[, 1])
  tmp_d$Number.of.Tools.Used = as.numeric(tmp_f$scores[, 2])
  tmp_d$label = rownames(df)
  
  #plot
  g = ggplot(tmp_d, aes(Students, Number.of.Tools.Used, color = cluster)) + geom_point() + 
    scale_colour_manual(values=c("purple", "green","orange", "yellow", "blue", "red")) +
    annotate("point", x = tmp_k$centers[, 2], y = tmp_k$centers[, 1], size = tmp_k$size/2, colour = c("purple", "green","orange", "yellow", "blue", "red"))  
    return(g)
}

plot_kmeans(mydata, 6)
ggsave("toolsCorrelation.png")


