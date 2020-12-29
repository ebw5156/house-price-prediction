library(data.table)


DT<-fread('./project/volume/data/raw/2008.csv')

pairs(Sale_Price~OverallQual+TotalBsmtSF+LotArea+YearBuilt,data=DT[1:1000,])

DT[is.na(DT$SalePrice)]$SalePrice<-0

sub_DT<-DT[,.(OverallQual,TotalBsmtSF,LotArea,YearBuilt,SalePrice)]


fwrite(train,'./project/volume/data/raw/Stat_380_train.csv')
fwrite(test,'./project/volume/data/raw/Stat_380_test.csv')
