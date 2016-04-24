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
args = commandArgs(trailingOnly=TRUE)
groupName<-args[1]

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

sickTotal<-c()
immuneTotal<-c()

for(days in 1:totalDays){
#population
	qry<-paste("select population as total from outputs where group_name like '",
	groupName,"' and day = ",dayArray[days],";",sep="")
	res<-dbSendQuery(con,qry)
	total<-fetch(res,n=-1)
	total<-c(total$total)
	totalM<-cityToTen(total)
	populationMap<-matrix(totalM,ncol=10,nrow=10,byrow=TRUE)

#sick
	qry<-paste("select sick as infected from outputs where group_name like '"
	,groupName,"' and day=",dayArray[days],";",sep="")
	res<-dbSendQuery(con,qry)
	sick<-fetch(res, n=-1)
	sick<-c(sick$infected)
	sickM<-cityToTen(sick)
	sickMap<-matrix(sickM,ncol=10,nrow=10,byrow=TRUE)

	sickTotal<-c(sickTotal,sum(sick))#for line graph

#immunity array for final line graph
	qry<-paste("select immune from outputs where group_name like '"
	,groupName,"' and day=",dayArray[days],";",sep="")
  res<-dbSendQuery(con,qry)
  immune<-fetch(res, n=-1)
	immune<-c(immune$immune)
	immuneTotal<-c(immuneTotal,sum(immune))

########################## PERCENTAGE MAP #############################
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

########################## SICK MAP #############################
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
}#END FOR LOOP


########################## POPULATION MAP #############################
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

########################## Sick/Immune Chart #############################
immuneAsDays<-c()
sickAsDays<-c()

for(k in 1:length(dayArray)){
	immuneAsDays[(dayArray[k])]<-immuneTotal[k]
	sickAsDays[(dayArray[k])]<-sickTotal[k]
}

path1<-paste(path,"/siChart.jpg",sep="")
jpeg(path1)
ymax<-c(0,max(sickTotal, immuneTotal))
xmax<-c(0,max(dayArray))
plot(xmax,ymax, type="n",xlab="Days",ylab="People",main="Sick and Immune")
lines(na.omit(cbind(x=seq_along(sickAsDays),y=sickAsDays)), type="o", col="red")
lines(na.omit(cbind(x=seq_along(immuneAsDays),y=immuneAsDays)), type="o",col="blue")
legend(0,max(ymax),c("Sick","Immune"),
  lty=c(1,1),lwd=c(2.5,2.5),col=c("red","blue"))
dev.off()

########################## Age Pie #############################
popAge<-c()
sickAge<-c()

for(k in 0:2){
	column<-paste("pop_age",k,sep="")
	qry<-paste("select sum(",column,") as ",column," from outputs where group_name like '",groupName,"';",sep="")
	res<-dbSendQuery(con,qry)
	fetched<-fetch(res,n=-1)
	popAge<-c(popAge,eval(parse(text=paste("fetched$",column,sep=""))))

	column<-paste("sick_age",k,sep="")
	qry<-paste("select sum(",column,") as ",column," from outputs where group_name like '",groupName,"';",sep="")
	res<-dbSendQuery(con,qry)
	fetched<-fetch(res,n=-1)
	sickAge<-c(sickAge,eval(parse(text=paste("fetched$",column,sep=""))))
}

lbls<-c("0-18","19-65","65 and Older")
lbls<-paste(lbls," (",popAge,")",sep="")
path1<-paste(path,"/PopPieChart.jpg",sep="")
jpeg(path1)
pie(popAge,labels=lbls,col=rainbow(length(lbls)),main="Population of Each Age")
dev.off()

if(sum(sickAge)>0){
    lbls<-c("0-18","19-65","65 and Older")
    lbls<-paste(lbls," (",sickAge,")",sep="")
    path1<-paste(path,"/SicPieChart.jpg",sep="")
    jpeg(path1)
    pie(sickAge,labels=lbls,col=rainbow(length(lbls)),main="Sick at Each Age")
    dev.off()
}


#FIX IMAGES UP FOR SMALL AND BIG DISPLAY
system(paste("convert -delay 100 -loop 0 ../../../public/assets/images/",groupName,"/percentage*.jpg ../../../public/assets/images/",groupName,"/percentage.gif",sep=""))
system(paste("convert -delay 100 -loop 0 ../../../public/assets/images/",groupName,"/sick*.jpg ../../../public/assets/images/",groupName,"/sick.gif",sep=""))
# system(paste("cp ../../../public/assets/images/",groupName,"/*.jpg ../../../public/assets/images/",groupName,"/small",sep=""))
# system(paste("cp ../../../public/assets/images/",groupName,"/*.gif ../../../public/assets/images/",groupName,"/small",sep=""))
# system(paste("mogrify ../../../public/assets/images/",groupName,"/*.jpg -resize 230x230 ../../../public/assets/images/",groupName,"/small/*",sep=""))
# system(paste("mogrify ../../../public/assets/images/",groupName,"/*.gif -resize 230x230 ../../../public/assets/images/",groupName,"/small/*",sep=""))

closeAllConnections()
