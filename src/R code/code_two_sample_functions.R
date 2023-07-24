
#=================================START=========================================

# README: This Rscript contains two parts. The first part is responsible
# for the H statistics calculation (two functions), and the second one is 
# for the other five stats: Q_{FG}, Q_{GF}, M, W and A.


#-------------------------------- H stat----------------------------------------

rtable=function(data1,data2,ref,type.depth){
  data_all=rbind(data1,data2)
  if(type.depth==1){ 
    depth_data1=depth.Mahalanobis(x=data1,data=ref)
    depth_data2=depth.Mahalanobis(x=data2,data=ref)
    depth_all=depth.Mahalanobis(x=data_all,data=ref)
  }
  if(type.depth==2){ 
    depth_data1=depth.spatial(x=data1,data=ref)
    depth_data2=depth.spatial(x=data2,data=ref)
    depth_all=depth.spatial(x=data_all,data=ref)
  }
  if(type.depth==3){ 
    depth_data1=depth.projection(x=data1,data=ref)
    depth_data2=depth.projection(x=data2,data=ref)
    depth_all=depth.projection(x=data_all,data=ref)
  }
  if(type.depth==4){ 
    depth_data1=depth.Mahalanobis(x=data1,data=ref)
    depth_data2=depth.Mahalanobis(x=data2,data=ref)
    depth_all=depth.Mahalanobis(x=data_all,data=ref)
  }
  if(type.depth==5){ 
    depth_data1=depth.betaSkeleton(x=data1,data=ref)
    depth_data2=depth.betaSkeleton(x=data2,data=ref)
    depth_all=depth.betaSkeleton(x=data_all,data=ref)
  }
  if(type.depth==6){ 
    depth_data1=depth.L2(x=data1,data=ref)
    depth_data2=depth.L2(x=data2,data=ref)
    depth_all=depth.L2(x=data_all,data=ref)
  }
  if(type.depth==7){ 
    depth_data1=depth.qhpeeling(x=data1,data=ref)
    depth_data2=depth.qhpeeling(x=data2,data=ref)
    depth_all=depth.qhpeeling(x=data_all,data=ref)
  }
  if(type.depth==8){ 
    depth_data1=depth.simplicial(x=data1,data=ref)
    depth_data2=depth.simplicial(x=data2,data=ref)
    depth_all=depth.simplicial(x=data_all,data=ref)
  }
  if(type.depth==9){ 
    depth_data1=depth.zonoid(x=data1,data=ref)
    depth_data2=depth.zonoid(x=data2,data=ref)
    depth_all=depth.zonoid(x=data_all,data=ref)
  }
  col_1=c()
  for (i in 1:length(depth_data1)) {
    col_1[i]=sum(depth_data1[i]>=depth_all)
  }
  col_2=c()
  for (i in 1:length(depth_data2)) {
    col_2[i]=sum(depth_data2[i]>=depth_all)
  }
  v_length <- max(length(col_1), length(col_2))
  length(col_1)=v_length
  length(col_2)=v_length
  output=cbind(col_1,col_2)
  return(output)
}


H_test<-function(data1,data2,type.depth){
  table_Rij=rtable(data1,data2,ref=data1,type.depth)
  R_3=sum(table_Rij[,1],na.rm=TRUE)
  R_4=sum(table_Rij[,2],na.rm=TRUE)
  
  n_3=sum(!is.na(table_Rij[,1]))
  n_4=sum(!is.na(table_Rij[,2]))
  
  table_Rij=rtable(data1,data2,ref=data2,type.depth)
  table_Rij
  R_5=sum(table_Rij[,1],na.rm=TRUE)
  R_6=sum(table_Rij[,2],na.rm=TRUE)
  
  n_5=sum(!is.na(table_Rij[,1]))
  n_6=sum(!is.na(table_Rij[,2]))
  n=n_5+n_6
  H=12/(n*(n+1)*2)*(R_3^2/n_3+R_4^2/n_4+R_5^2/n_5+R_6^2/n_6)-3*(n+1)
  return(H)
}


#-----------------------------Five Stats----------------------------------------

QQ_test=function(Fm,Gn,type.depth){ 
  if(type.depth==1){
    depth_Fm_F=depth.Mahalanobis(x=Fm,data=Fm) # ddalpha 
    depth_Gn_F=depth.Mahalanobis(x=Gn,data=Fm) 
    depth_Fm_G=depth.Mahalanobis(x=Fm,data=Gn)
    depth_Gn_G=depth.Mahalanobis(x=Gn,data=Gn) 
  }
  if(type.depth==2){
    depth_Fm_F=depth.spatial(x=Fm,data=Fm) # ddalpha 
    depth_Gn_F=depth.spatial(x=Gn,data=Fm) 
    depth_Fm_G=depth.spatial(x=Fm,data=Gn)
    depth_Gn_G=depth.spatial(x=Gn,data=Gn) 
  }
  if(type.depth==3){
    depth_Fm_F=depth.projection(x=Fm,data=Fm) # ddalpha 
    depth_Gn_F=depth.projection(x=Gn,data=Fm) 
    depth_Fm_G=depth.projection(x=Fm,data=Gn)
    depth_Gn_G=depth.projection(x=Gn,data=Gn) 
  }
  if(type.depth==4){
    depth_Fm_F=depth.Mahalanobis(x=Fm,data=Fm, mah.estimate = "MCD") # ddalpha 
    depth_Gn_F=depth.Mahalanobis(x=Gn,data=Fm, mah.estimate = "MCD") 
    depth_Fm_G=depth.Mahalanobis(x=Fm,data=Gn, mah.estimate = "MCD")
    depth_Gn_G=depth.Mahalanobis(x=Gn,data=Gn, mah.estimate = "MCD") 
  }
  if(type.depth==5){
    depth_Fm_F=depth.betaSkeleton(x=Fm,data=Fm) # ddalpha 
    depth_Gn_F=depth.betaSkeleton(x=Gn,data=Fm) 
    depth_Fm_G=depth.betaSkeleton(x=Fm,data=Gn)
    depth_Gn_G=depth.betaSkeleton(x=Gn,data=Gn) 
  }
  if(type.depth==6){
    depth_Fm_F=depth.L2(x=Fm,data=Fm) # ddalpha 
    depth_Gn_F=depth.L2(x=Gn,data=Fm) 
    depth_Fm_G=depth.L2(x=Fm,data=Gn)
    depth_Gn_G=depth.L2(x=Gn,data=Gn) 
  }
  if(type.depth==7){
    depth_Fm_F=depth.qhpeeling(x=Fm,data=Fm) # ddalpha 
    depth_Gn_F=depth.qhpeeling(x=Gn,data=Fm) 
    depth_Fm_G=depth.qhpeeling(x=Fm,data=Gn)
    depth_Gn_G=depth.qhpeeling(x=Gn,data=Gn) 
  }
  if(type.depth==8){
    depth_Fm_F=depth.simplicial(x=Fm,data=Fm) # ddalpha 
    depth_Gn_F=depth.simplicial(x=Gn,data=Fm) 
    depth_Fm_G=depth.simplicial(x=Fm,data=Gn)
    depth_Gn_G=depth.simplicial(x=Gn,data=Gn) 
  }
  if(type.depth==9){
    depth_Fm_F=depth.zonoid(x=Fm,data=Fm) # ddalpha 
    depth_Gn_F=depth.zonoid(x=Gn,data=Fm) 
    depth_Fm_G=depth.zonoid(x=Fm,data=Gn)
    depth_Gn_G=depth.zonoid(x=Gn,data=Gn) 
  }
  
  V_q=c()
  for (i in 1:length(depth_Gn_F)) {
    V_q[i]=(sum(depth_Gn_F[i]>=depth_Fm_F))/length(depth_Fm_F)
  }
  Q_test_rF=mean(V_q)
  
  V_q=c()
  for (i in 1:length(depth_Fm_G)) {
    V_q[i]=(sum(depth_Fm_G[i]>=depth_Gn_G))/length(depth_Gn_G)
  }
  Q_test_rG=mean(V_q)
  return(c(Q_test_rF,Q_test_rG))
}

five_in_all=function(Fm,Gn,type.depth){
  m=dim(Fm)[1]
  n=dim(Gn)[1]
  wn=n/(n+m)
  wm=m/(n+m)
  QQ=QQ_test(Fm,Gn,type.depth)
  Q_F=QQ[1]
  Q_G=QQ[2]
  Q_F_Chi=((1/n+1/m)*(1/12))^(-1)*(Q_F-1/2)^2 
  Q_G_Chi=((1/n+1/m)*(1/12))^(-1)*(Q_G-1/2)^2 
  A=0.5*(((1/n+1/m)*(1/12))^(-1))*((Q_G-0.5)^2+(Q_F-0.5)^2)
  M=(((1/n+1/m)*(1/12))^(-1))*max((Q_G-0.5)^2,(Q_F-0.5)^2)
  W=(1/(wn+wm))*(((1/n+1/m)*(1/12))^(-1))*(wn*(Q_G-0.5)^2+wm*(Q_F-0.5)^2)
  return(c(Q_F_Chi,Q_G_Chi,A,M,W))
}


#==================================END==========================================

