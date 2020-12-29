library(caret)
library(data.table)
library(Metrics)

#Read data
train<- fread('./project/volume/data/raw/Stat_380_train.csv')
test<- fread('./project/volume/data/raw/Stat_380_test.csv')
example_sub<-fread("./project/volume/data/raw/example_submission.csv")
#For hash purposes
train_y<-train$SalePrice
test_y<-test$SalePrice

test$SalePrice<-0

#creation of dummy variables+map
dummies<- dummyVars(SalePrice~.,data = train)#dummy creation
train<- predict(dummies,newdata = train)#
test$BldgType<-0
test$Heating<-0
test$CentralAir<-0
test<-predict(dummies,newdata = test)


train<-data.table(train)
train$SalePrice<-train_y
test<-data.table(test)

#model fitting and tunning
lm_model<-lm(SalePrice~TotalBsmtSF+YearBuilt+OverallQual+BedroomAbvGr+
               GrLivArea+FullBath+OverallCond+CentralAirN,data=train)

summary(lm_model)

#save
saveRDS(dummies,"./project/volume/models/SalePrice.dummies")
saveRDS(dummies,"./project/volume/models/SalePrice.models")

test$SalePrice<-predict.lm(lm_model,newdata =test )

#submission file
submit<-test[,c("Id","SalePrice")]


fwrite(submit,"./project/volume/data/processed/P1.csv")

rmse(train_y,test$SalePrice)#train_y
structure(submit)

