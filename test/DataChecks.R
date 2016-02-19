#read "survey_new.csv"
survey <- read.csv("data/survey_new.csv")

#Experience with: R, data manipulation and modeling
#to order the facet grid values
survey$Programming.and.Analytical.Experiences..R..data.manipulation.and.modeling. <- factor(survey$Programming.and.Analytical.Experiences..R..data.manipulation.and.modeling., levels = c("Expert", "Confident", "A little", "None"))
#to draw the facet grid
png(filename="plots/datachecks1.png", width=900, height=589)
qplot(R, data=survey, fill=R, facets=Programming.and.Analytical.Experiences..R..data.manipulation.and.modeling.~., main="Experience with: R, data manipulation and modeling", xlab="Are you comfortable using R?", ylab="Count")
dev.off()

#Experience with: R, graphic basics
#to order the facet grid values
survey$Programming.and.Analytical.Experiences..R..graphic.basics..base..lattice..grid.etc.... <- factor(survey$Programming.and.Analytical.Experiences..R..graphic.basics..base..lattice..grid.etc...., levels = c("Expert", "Confident", "A little", "None"))
#to draw the facet grid
png(filename="plots/datachecks2.png", width=900, height=589)
qplot(R, data=survey, fill=R, facets=Programming.and.Analytical.Experiences..R..graphic.basics..base..lattice..grid.etc....~., main="Experience with: R, graphic basics", xlab="Are you comfortable using R?", ylab="Count")
dev.off()

#Experience with: R, advanced
#to order the facet grid values
survey$Programming.and.Analytical.Experiences..R..advanced..multivariate.data.analysis..e.g..spatiotemporal.data..visualization.and.modeling.. <- factor(survey$Programming.and.Analytical.Experiences..R..advanced..multivariate.data.analysis..e.g..spatiotemporal.data..visualization.and.modeling.., levels = c("Expert", "Confident", "A little", "None"))
#to draw the facet grid
png(filename="plots/datachecks3.png", width=900, height=589)
qplot(R, data=survey, fill=R, facets=Programming.and.Analytical.Experiences..R..advanced..multivariate.data.analysis..e.g..spatiotemporal.data..visualization.and.modeling..~., main="Experience with: R, advanced", xlab="Are you comfortable using R?", ylab="Count")
dev.off()

#Reproducible documentation with R
#to order the facet grid values
survey$Programming.and.Analytical.Experiences..Reproducible.documentation.with.R..e.g..R.Markdown.. <- factor(survey$Programming.and.Analytical.Experiences..Reproducible.documentation.with.R..e.g..R.Markdown.., levels = c("Expert", "Confident", "A little", "None"))
#to draw the facet grid
png(filename="plots/datachecks4.png", width=900, height=589)
qplot(R, data=survey, fill=R, facets=Programming.and.Analytical.Experiences..Reproducible.documentation.with.R..e.g..R.Markdown..~., main="Experience with: Reproducible documentation with R", xlab="Are you comfortable using R?", ylab="Count")
dev.off()

#Matlab, data manipulation, analysis, visualization and modeling
#to order the facet grid values
survey$Programming.and.Analytical.Experiences..Matlab..data.manipulation..analysis..visualization.and.modeling. <- factor(survey$Programming.and.Analytical.Experiences..Matlab..data.manipulation..analysis..visualization.and.modeling., levels = c("Expert", "Confident", "A little", "None"))
#to draw the facet grid
png(filename="plots/datachecks5.png", width=900, height=589)
qplot(Matlab, data=survey, fill=Matlab, facets=Programming.and.Analytical.Experiences..Matlab..data.manipulation..analysis..visualization.and.modeling.~., main="Experience with: Matlab", xlab="Are you comfortable using R?", ylab="Count")
dev.off()

#Github
#to order the facet grid values
survey$Programming.and.Analytical.Experiences..Github. <- factor(survey$Programming.and.Analytical.Experiences..Github., levels = c("Expert", "Confident", "A little", "None"))
#to draw the facet grid
png(filename="plots/datachecks6.png", width=900, height=589)
qplot(Github, data=survey, fill=Github, facets=Programming.and.Analytical.Experiences..Github.~., main="Experience with: Github", xlab="Are you comfortable using Github?", ylab="Count")
dev.off()
