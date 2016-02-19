######################
# This part of code is about skill comparison between DS students and non-DS students
# It include the following 4 graphs:
# 1. Composition of Students in the Class
# 2. Number of Skills DS Students and Non-DS Students Can Use Respectively
# 3. Proportion of DS and non-DS  Students with Matlab, Python, R and SQL Skills
# 4. Self-evaluation on R, Github and Matlab for DS and non-DS Students
# 02/10/2016
#######################

# load data
Data = read.csv("data/survey_new.csv")
library(ggplot2)

### Figure 1: Pi graph for different programs in the class ###
temp = as.character(Data$Program)
c = c("QMSS","Ph.D.","Applied Math","PhD Biomedical Informatics","Other masters")
for (i in 1:length(temp)){
        if (temp[i] %in% c){
                temp[i] = "Others"
        }
}
temp = as.factor(temp)

png(filename="plots/DS_NonDS0.png", width=900, height=589)
pie(table(temp),main = "Composition of Students in the Class",col=rainbow(4))
dev.off()

### Figure 2: Number of Skills DS Students and Non-DS Students Can Use Respectively ###
is_DS = (Data$Program == "IDSE (master)") | (Data$Program == "Data Science Certification")
non_DS = !is_DS
DS_num = Data$Number.Tools[is_DS]
nonDS_num = Data$Number.Tools[non_DS]
Program = c(rep("DS",sum(is_DS)),rep("non-DS",sum(non_DS)))
y = c(DS_num,nonDS_num)
Skill_number = data.frame(cbind(Program,y))
Skill_number$Program = as.factor(Skill_number$Program)
Skill_number$y = as.numeric(as.character(Skill_number$y))
png(filename="plots/DS_NonDS1.png", width=900, height=589)
ggplot(Skill_number, aes(x=y, fill=Program)) + geom_histogram(aes(y=..density..),position="identity",alpha = .3,binwidth=1) + xlab("Number of Skills") + ggtitle("Number of Skills DS Students and Non-DS Students Can Use Respectively")
dev.off()

#### Figure 3: Proportion of DS and non-DS  Students with Matlab, Python, R and SQL Skills ###
Skills = rep(colnames(Data)[11:30],2)
Program = c(rep("DS",20),rep("non-DS",20))
Proportion = rep(0,40)
for (i in 1:20){
        Proportion[i] = sum(is_DS & Data[,i+10])
        Proportion[i+20] =  sum(non_DS & Data[,i+10])
}
Program_Skill = data.frame(cbind(Program, Skills, Proportion))
Program_Skill$Proportion = as.numeric(as.character(Program_Skill$Proportion))
Program_Skill$Proportion[1:20] = Program_Skill$Proportion[1:20]/sum(is_DS)
Program_Skill$Proportion[21:40] = Program_Skill$Proportion[21:40]/sum(non_DS)
temp = c(1,3,6,18)
Program_Skill1 = Program_Skill[c(temp,temp+20),]
png(filename="plots/DS_nonDS2.png", width=900, height=589)
ggplot(Program_Skill1, aes(x=Skills, y=Proportion, fill=Program)) + geom_bar(stat="identity", width=0.8, position="dodge")+ ggtitle("Proportion of DS and non-DS  Students with Matlab, Python, R and SQL Skills") + ylim(0,1)
dev.off()

### Figure 4: Self-evaluation on R, Github and Matlab for DS and non-DS Students ###
Skill = c("R","Matlab","Github")
Skill = rep(Skill,8)
Evaluate = c(rep("Expert",3),rep("Confident",3),rep("A little",3),rep("None",3))
Evaluate = rep(Evaluate,2)
Program = c(rep("DS",12),rep("non_DS",12))
Evaluate_Program = cbind(Skill, Evaluate, Program)
Proportion = rep(0,24)
temp = c("Expert","Confident","A little","None")
temp2 = c(3,6:8)
for (i in 1:4){
        for (j in 1:4){
                Proportion[3*j-2] = Proportion[3*j-2] + sum((Data[,temp2[i]]==temp[j]) & is_DS)
                Proportion[3*j-2+12] = Proportion[3*j-2+12] + sum((Data[,temp2[i]]==temp[j]) & non_DS)
        }
}
temp2 = c(9,10)
for (i in 1:2){
        for (j in 1:4){
                Proportion[3*(j-1)+i+1] = sum((Data[,temp2[i]]==temp[j]) & is_DS)
                Proportion[3*(j-1)+i+13] = sum((Data[,temp2[i]]==temp[j]) & non_DS)
        }
}
Evaluate_Program = data.frame(cbind(Evaluate_Program,Proportion))
Evaluate_Program$Proportion = as.numeric(as.character(Evaluate_Program$Proportion))
Evaluate_Program$Evaluate <- factor(Evaluate_Program$Evaluate, levels = temp[4:1])
Evaluate_Program$Proportion[1:12] = Evaluate_Program$Proportion[1:12]/sum(is_DS)
Evaluate_Program$Proportion[13:24] = Evaluate_Program$Proportion[13:24]/sum(non_DS)
for (i in 1:8){
        Evaluate_Program$Proportion[i*3-2] = Evaluate_Program$Proportion[i*3-2]/4
}
png(filename="plots/DS_NonDS3.png", width=900, height=589)
ggplot(Evaluate_Program,aes(x=Program, y=Proportion, fill=Evaluate)) + geom_bar(stat='identity',position ='stack') + facet_grid(~ Skill) + xlab("Program(DS, non-DS)")+ scale_fill_brewer(palette = "RdBu")+ ggtitle("Self-evaluation on R, Github and Matlab for DS and non-DS Students")
dev.off()
