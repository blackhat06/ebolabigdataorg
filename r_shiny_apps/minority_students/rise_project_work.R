libray(gdata)
riseo = read.xls('~/Desktop/GA/qry_RISE_MidTerms_FALL2014_v2_sheet1.xlsx')
# level of grades Levels:  A A- ABF B B- B+ C C- C+ D D+ F P UW
riseA <- riseo[riseo$SFRSTCR_GRDE_CODE_MID=="A",]
riseAminus <- riseo[riseo$SFRSTCR_GRDE_CODE_MID=="A-",]
riseBplus <- riseo[riseo$SFRSTCR_GRDE_CODE_MID=="B+",] 
risegoodprofile <- rbind(riseA, riseAminus, riseBplus)
risena <- riseo[riseo$SFRSTCR_GRDE_CODE_MID=="",]
riseB <- riseo[riseo$SFRSTCR_GRDE_CODE_MID=="B",]
riseBminus <- riseo[riseo$SFRSTCR_GRDE_CODE_MID=="B-",]
riseCplus <- riseo[riseo$SFRSTCR_GRDE_CODE_MID=="C+",]
riseC <- riseo[riseo$SFRSTCR_GRDE_CODE_MID=="C",]
riseCminus <- riseo[riseo$SFRSTCR_GRDE_CODE_MID=="C-",]
riseDplus <- riseo[riseo$SFRSTCR_GRDE_CODE_MID=="D+",]
riseD <- riseo[riseo$SFRSTCR_GRDE_CODE_MID=="D",]
riseF <- riseo[riseo$SFRSTCR_GRDE_CODE_MID=="F",]
riseABF <- riseo[riseo$SFRSTCR_GRDE_CODE_MID=="ABF",]
riseUW <- riseo[riseo$SFRSTCR_GRDE_CODE_MID=="UW",]
riseP <- riseo[riseo$SFRSTCR_GRDE_CODE_MID=="P",]
grade <- riseo$SFRSTCR_GRDE_CODE_MID
unique(sort(grade))
risepoorprofile <- rbind(risena, riseB, riseBminus, riseCplus, riseC, riseCminus, riseD, riseDplus, riseF, riseABF, riseUW, riseP)
library(xlsx)
write.xlsx(risepoorprofile, "/home/sanjusir/Desktop/GA/risepoorprofile.xlsx")
ID <- riseo$ID
unique(sort(ID))
IDp <- risepoorprofile$ID
IDp <- risepoorprofile$ID
demo = read.xls("~/Desktop/GA/qry_RISESCHOLARS_DEMOGRAPHICS.xlsx")
demo -> demo1 # copying data frame
demo -> demo2 
risepoorprofile -> risepoorprofile1 
colnames(demo1)[1] <- "ID" #change name of data frame for column 1 for merging
finalrisepoorprofile <- merge(risepoorprofile1, demo1, by="ID") # merging two by ID 
write.xlsx(finalrisepoorprofile, "/home/sanjusir/Desktop/GA/finalrisepoorprofile.xlsx")