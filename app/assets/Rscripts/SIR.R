library("mosaic")
diff<-integrateODE(dS~-b*S*I,dI~b*S*I-k*I,dR~k*I,k=1/7,b=1/3,S=1,I=.005,R=0,tdur=list(from=0, to=80));

jpeg("SIRModel.jpg")
plotFun(diff$S(t)~t,t.lim=range(0,80),xlab="Time",ylab="Percent of Population", main="THE SIR MODEL")
plotFun(diff$I(t)~t,t.lim=range(0,80),add=TRUE,col="red")
plotFun(diff$R(t)~t,t.lim=range(0,80),add=TRUE,col="green")
dev.off()

#video for how to implement this in R
#https://www.youtube.com/watch?v=lW2IQ0_I3mQ
#where the formulas came from
#http://www.maa.org/press/periodicals/loci/joma/the-sir-model-for-spread-of-disease-the-differential-equation-model
