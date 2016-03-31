#Created by Austin Smith 2/7/16
#script will connect with database and get the total number of people
#the number infected and create a map of the sickness based on percentage
# mysql> describe input;
# +------------+-------------+------+-----+---------+-------+
# | Field      | Type        | Null | Key | Default | Extra |
# +------------+-------------+------+-----+---------+-------+
# | group_name | varchar(30) | NO   | PRI | NULL    |       |
# | vaccines   | int(11)     | YES  |     | NULL    |       |
# | school_off | int(11)     | YES  |     | NULL    |       |
# | days       | int(11)     | NO   | PRI | 0       |       |
# +------------+-------------+------+-----+---------+-------+
# 4 rows in set (0.04 sec)
# mysql> describe output;
# +----------------------+-------------+------+-----+---------+-------+
# | Field                | Type        | Null | Key | Default | Extra |
# +----------------------+-------------+------+-----+---------+-------+
# | group_name           | varchar(30) | NO   | PRI | NULL    |       |
# | money_left           | double      | YES  |     | NULL    |       |
# | money_spent_vaccines | double      | YES  |     | NULL    |       |
# | money_spent_ads      | double      | YES  |     | NULL    |       |
# | vaccs_left           | int(11)     | YES  |     | NULL    |       |
# | population           | int(11)     | YES  |     | NULL    |       |
# | sick                 | int(11)     | YES  |     | NULL    |       |
# | immune               | int(11)     | YES  |     | NULL    |       |
# | pop_age0             | int(11)     | YES  |     | NULL    |       |
# | sick_age0            | int(11)     | YES  |     | NULL    |       |
# | pop_age1             | int(11)     | YES  |     | NULL    |       |
# | sick_age1            | int(11)     | YES  |     | NULL    |       |
# | pop_age2             | int(11)     | YES  |     | NULL    |       |
# | sick_age2            | int(11)     | YES  |     | NULL    |       |
# | day                  | int(11)     | NO   | PRI | 0       |       |
# | cityID               | int(11)     | NO   | PRI | 0       |       |
# +----------------------+-------------+------+-----+---------+-------+
# 16 rows in set (0.07 sec)
cityToTen<-function(array)
{
##give it an array 250 long and it will spit out one that is
#100 long and ready to be put into a matrix that has a large
#population near the bottom right middle and left so
#Detroit lansing grand rapids
	result<-c()
	for(i in 1:42)
	  {result[i]<-array[i]}
	x<-0
	for(j in 43:57){x<-x+array[j]}
	result[43]<-x
	result[44]<-array[58]+array[59]
	x<-0
	for(j in 60:69){x<-x+array[j]}
	result[45]<-x
	x<-0
	for(j in 70:79){x<-x+array[j]}
	result[46]<-x
	result[47]<-array[80]+array[81]
	for(i in 82:86)
	  {result[i-34]<-array[i]}
	x<-0
	for(j in 87:91){x<-x+array[j]}
	result[53]<-x
	result[54]<-array[92]+array[93]
	x<-0
	for(j in 94:103){x<-x+array[j]}
	result[55]<-x
	x<-0
	for(j in 104:113){x<-x+array[j]}
	result[56]<-x
	result[57]<-array[114]+array[115]
	for(i in 116:124)
	  {result[i-58]<-array[i]}
	#three 2s in a row
	result[67]<-array[125]+array[126]
	result[68]<-array[127]+array[128]
	result[69]<-array[129]+array[130]
	for(i in 131:137)
	  {result[i-61]<-array[i]}
	result[77]<-array[138]+array[139]
	x<-0
	for(j in 140:144){x<-x+array[j]}
	result[78]<-x
	x<-0
	for(j in 145:149){x<-x+array[j]}
	result[79]<-x
	x<-0
	for(j in 150:154){x<-x+array[j]}
	result[80]<-x
#255

	for(i in 155:160)
	  {result[i-74]<-array[i]}
	result[87]<-array[161]+array[162]
	x<-0
	for(j in 163:167){x<-x+array[j]}
	result[88]<-x
	x<-0
	for(j in 168:182){x<-x+array[j]}
	result[89]<-x
	x<-0
	for(j in 183:197){x<-x+array[j]}
	result[90]<-x
	for(i in 198:203)
	  {result[i-107]<-array[i]}


	result[97]<-array[204]+array[205]
	x<-0
	for(j in 206:210){x<-x+array[j]}
	result[98]<-x
	x<-0
	for(j in 211:225){x<-x+array[j]}
	result[99]<-x
	x<-0
	for(j in 226:250){x<-x+array[j]}
	result[100]<-x
	return(result)
}

turnM<-function(m)
{
#turns a matrix to a normals persons way of thinking of it
  m <- t(m)[,nrow(m):1]
}


#requires DBI to be loaded and RMySQl
library(DBI)
groupName<-"Lions"
path<-paste("../../../public/assets/images/",groupName,sep="")

con<-dbConnect(RMySQL::MySQL(),user="root",password="beltforgetflewdarkness",dbname="flusim_development")
#connect to database
qry<-paste("select count(distinct day) as day from outputs where group_name like '",groupName,"';",sep="")

res<-dbSendQuery(con,qry)
totalDays<-fetch(res,n=-1)
totalDays<-c(totalDays$day)
totalDays

qry<-paste("select distinct day from outputs where group_name like '",groupName,"';",sep="")
res<-dbSendQuery(con,qry)
dayArray<-fetch(res,n=-1)
dayArray<-c(dayArray$day)
dayArray

for(days in 1:totalDays){
	qry<-paste("select population as total from outputs where group_name like '",
	groupName,"' and day = ",dayArray[days],";",sep="")

	qry
	res<-dbSendQuery(con,qry)
	#database results go to res
	total<-fetch(res,n=-1)
	total<-c(total$total)
	totalM<-cityToTen(total)
	populationMap<-matrix(totalM,ncol=10,nrow=10,byrow=TRUE)
  populationMap

	qry<-paste("select sick as infected from outputs where group_name like '"
	,groupName,"' and day=",dayArray[days],";",sep="")

	qry
	res<-dbSendQuery(con,qry)
	sick<-fetch(res, n=-1)
	sick<-c(sick$infected)
	sickM<-cityToTen(sick)
	sickMap<-matrix(sickM,ncol=10,nrow=10,byrow=TRUE)
	sickMap

	percMap<-matrix(sickM/totalM,ncol=10,nrow=10,byrow=TRUE)
  percMap[is.nan(percMap)]<-0

	path1<-paste(path,"/percentage",days,".jpg",sep="")
	jpeg(path1)
	par(mar=c(0,0,0,0))
	percMap<-turnM(percMap)
	image(percMap, col=terrain.colors(25), axes=FALSE)
	for(i in 0:9){
		for(j in 0:9){
		  text(x=j/9,y=i/9,labels=sprintf("%.2f%%",100*percMap[(i*10)+j+1]))
		}
	}
	dev.off()

	path1<-paste(path,"/sick",days,".jpg",sep="")
	jpeg(path1)
	par(mar=c(0,0,0,0))
	sickMap<-turnM(sickMap)
	image(sickMap, col=terrain.colors(25), axes=FALSE)
	for(i in 0:9){
		for(j in 0:9){
		  text(x=i/9,y=j/9,labels=sprintf("%d",sickMap[i+1,j+1]))
		}
	}
	dev.off()
}

#once all images are ready and in correct folder
path1<-paste(path,"/population.jpg",sep="")
jpeg(path1)
par(mar=c(0,0,0,0))
populationMap<-turnM(populationMap)

image(populationMap, col=terrain.colors(25), axes=FALSE)
for(i in 0:9){
	for(j in 0:9){
		text(x=i/9,y=j/9,labels=sprintf("%d",populationMap[i+1,j+1]))
	}
}
dev.off()

system("convert -delay 100 -loop 0 ../../../public/assets/images/Lions/percentage*.jpg ../../../public/assets/images/Lions/percentage.gif")
system("convert -delay 100 -loop 0 ../../../public/assets/images/Lions/sick*.jpg ../../../public/assets/images/Lions/sick.gif")
system("cp ../../../public/assets/images/Lions/*.jpg ../../../public/assets/images/Lions/small")
system("cp ../../../public/assets/images/Lions/*.gif ../../../public/assets/images/Lions/small")
system("mogrify ../../../public/assets/images/Lions/*.jpg -resize 230x230 ../../../public/assets/images/Lions/small/*")
system("mogrify ../../../public/assets/images/Lions/*.gif -resize 230x230 ../../../public/assets/images/Lions/small/*")

closeAllConnections()
