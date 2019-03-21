# Morans-I
Moran's I by R-language

## 莫兰指数
莫兰指数一般是用来度量空间相关性的一个重要指标。
莫兰指数是一个有理数，经过方差归一化之后，它的值会被归一化到-1.0——1.0之间。

## 判断依据
Moran's I > 0  表示空间正相关性，其值越大，空间相关性越明显，
Moran's I < 0  表示空间负相关性，其值越小，空间差异越大，
Moran's I = 0，空间呈随机性。

## 代码解析
建立网格，转换成空间点数据类型，通过导入数据，选择GPA大于设定值3.3的，记录坐标信息以及GPA</br>
**knearneigh**：返回的是最近的K个邻居</br>
**dnearneigh** ：是通过最近距离和最远距离来选取相应的邻居</br>
我们选取dnearneigh来选取邻居，再使用计算莫兰指数的代码

![img](https://github.com/cuit201608/Team1_coding/blob/master/2nd/screenshots/code.png)

## 结果
![img](https://github.com/cuit201608/Team1_coding/blob/master/2nd/screenshots/1.png)
![img](https://github.com/cuit201608/Team1_coding/blob/master/2nd/screenshots/moran.png)

## 结论
计算出来的莫兰指数为**0.04463434**，数据大于零，其值极其接近于零，我们认为它具有**随机性**，但有一丝的空间正相关，可能会存在一少部分相关的几率。

