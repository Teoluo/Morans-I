library(lctools)
library(maptools)
library(spdep)
library(sp)
library(spatstat)

## row col values
## �������е�ֵ
rowValues = 1:5
colValues<- 1:14

## draw the polygons
## ��������ζ���
tepList<- c()
for(rowValue in rowValues){
  for(colValue in colValues){
    ## ����ÿһ������ε���ֵ
    seatNum <- (rowValue-1)*14+colValue
    ## paste str and number   
    ## ��ʽ����Sr1��Sr2...
    seatNum = paste("Sr",seatNum,sep="") 
    ## draw island
    ## ͨ��polygons����������island
    Sr = Polygon(cbind(c(rowValue,rowValue,rowValue+1,rowValue+1,rowValue),c(colValue,colValue+1,colValue+1,colValue,colValue)))
    ## ��ÿһ��island���϶�Ӧ��id
    Srs = Polygons(list(Sr),seatNum)
    ## cun
    tepList<-c(tepList,Srs)
  }
}
SpP=SpatialPolygons(tepList,70:1)

## from SpatialPolygons  to  ��owin��  object (window)
## ��SpatialPolygonsת����owin����
cityOwin <- as.owin(SpP)
class(cityOwin)

plot(SpP, border="grey60")



mydata1 <- read.table( file = "D:/seat.csv", header = TRUE, sep = "," )

goodGap<-3.3
great<-c()
for (i in 1:length(mydata1[,2])){
  if(mydata1[i,2]>=goodGap  && !is.na(mydata1[i,3]) ){
    great<-c(great,paste("Sr",mydata1[i,3],sep="") )
  }
}

name<-c()
for(value in 1:70){
  seatNum = paste("Sr",value,sep="")
  name<-c(name,seatNum)
}

df <- data.frame(gpa=1:70,row.names =name )

SrDf = SpatialPolygonsDataFrame(SpP,df)
as(SrDf, "data.frame")

pts <- coordinates(SrDf)


test<-c()
for( i in great){
  test<-c(test,pts[i,])
}

ptss<-matrix(data = test, nrow = length(test)/2, ncol = 2,byrow=T)


spoint<-data.frame( cbind(ptss[,1],ptss[,2]) )

sptest <- SpatialPoints(spoint)
plot(sptest)

nbk1 <- knn2nb(knearneigh(sptest, k = 3, longlat = TRUE))

#nbk1 <- poly2nb(knearneigh(sptest, k = 5, longlat = TRUE))
snbk1 <- make.sym.nb(nbk1)
plot(nb2listw(snbk1), cbind(spoint$X1 , spoint$X2))