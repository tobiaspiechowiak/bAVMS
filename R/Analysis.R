

library('openxlsx')
library('dplyr')
library('ggplot2')
library('reshape2')
data.path <- '../data/'

raw.data <- read.xlsx(paste0(data.path,'AVM_DSA_Update_EPIE_DBER.xlsx'),sheet = 1)

#kick out Nan columns
clean.data <- raw.data[,-c(1,2,3,4,5,8,9,10,11,12,13,19,22,30,33,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,69,76,77)]


write.csv(clean.data, file = paste0(data.path,'Clean_data.csv'))


library('caret')
new.data <- read.csv(paste0(data.path,'Clean_data_from_Python.csv'))

data.cor <- cor(new.data,use = 'complete.obs')
png('CorPlot.png', width = 2000, height = 2000)
corrplot(data.cor,method = 'circle')
dev.off()

tmp <- findCorrelation(data.cor,cutoff = 0.8)

filtered.data <- new.data[,-tmp]



fit <- lm(`Volume.of.Hemorrhage..ml.` ~ ., data = filtered.data)

summary(fit)







