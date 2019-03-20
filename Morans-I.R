library(lctools)
library(maptools)
library(spdep)
library(sp)
library(spatstat)

## row col values
## 设置行列的值
rowValues = 1:5
colValues<- 1:14

## draw the polygons
## 创建多边形对象
tepList<- c()
for(rowValue in rowValues){
  for(colValue in colValues){
    ## 设置每一个多边形的数值
    seatNum <- (rowValue-1)*14+colValue
    
    ## draw island
    ## 通过polygons函数来画出island
    Sr = Polygon(cbind(c(rowValue,rowValue,rowValue+1,rowValue+1,rowValue),c(colValue,colValue+1,colValue+1,colValue,colValue)))
    ## 给每一个island标上对应的id
    Srs = Polygons(list(Sr),seatNum)
    
    tepList<-c(tepList,Srs)
  }
}
SpP=SpatialPolygons(tepList,70:1)

## from SpatialPolygons  to  “owin”  object (window)
## 将SpatialPolygons转换成owin对象
cityOwin <- as.owin(SpP)
class(cityOwin)
# 读取数据
mydata1 <- read.table( file = "D:/seat.csv", header = TRUE, sep = "," )

# 筛选大于设定值的座位号
goodGap<-3.3
great<-c()
goodgrade<-c()
for (i in 1:length(mydata1[,2])){
  if(mydata1[i,2]>=goodGap  && !is.na(mydata1[i,3]) ){
    great<-c(great,mydata1[i,3] )
    goodgrade<-c(goodgrade,mydata1[i,2])
  }
}

df <- data.frame(gpa=1:70,row.names =1:70 )
SrDf = SpatialPolygonsDataFrame(SpP,df)
as(SrDf, "data.frame")

# 检索或建立坐标
pts <- coordinates(SrDf)

# 找到符合要求的成绩的人的坐标
test<-c()
for( i in great){
  test<-c(test,pts[i,])
}
# 从向量建立矩阵
ptss<-matrix(data = test, nrow = length(test)/2, ncol = 2,byrow=T)
# 从矩阵建立数据帧
spoint<-data.frame( cbind(ptss[,1],ptss[,2]) )
# 画出点坐标
sptest <- SpatialPoints(spoint)
plot(sptest)

#nbk1 <- knn2nb(knearneigh(sptest, k = 3, longlat = TRUE))
#snbk1 <- make.sym.nb(nbk1)
#plot(nb2listw(snbk1), cbind(spoint$X1 , spoint$X2))
#moran.test(goodgrade, nb2listw(snbk1))

neib=dnearneigh(ptss,0,2.5)
snbk1 <- make.sym.nb(neib)
plot(nb2listw(neib), cbind(spoint$X1 , spoint$X2))
moran.test(goodgrade, nb2listw(neib))