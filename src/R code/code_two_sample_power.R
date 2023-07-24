
#=================================START=========================================

#-------------------------------Resources---------------------------------------

packages <- c("ddalpha", "MASS", "matrixStats", "mvtnorm","parallel")
for(pkg in packages){
  if(!require(pkg, character.only = TRUE)) {
    install.packages(pkg)
  }
}
for(pkg in packages){
  library(pkg, character.only = TRUE)
}
source("code_two_sample_functions.R") # Refer to the functions we need


#---------------------------Experiment settings---------------------------------

args <- commandArgs(trailingOnly=TRUE) # Initialize command line argument

# Set depth type
Type.Depth <- as.integer(args[1]) 

# Set sample size for both m and n
m=c(1:6)*100 
if (args[2] == "same") { # Same or different sample size
  n = m
} else if (args[2] == "different") {
  n = m/2
} else {
  stop(paste("Invalid argument for sample size:", args[2]))
}

# Set the parameters
if (args[3] == "location") {
  set.seed(1)
  mu1 <- c(0,0)
  mu2 <- c(0,0) + c(0.35,0.35)
  sigma1 <- matrix(c(1,0,0,1), nc = 2)
  sigma2 <- matrix(c(1,0,0,1), nc = 2)
} else if (args[3] == "variance") {
  set.seed(1)
  mu1 <- c(0,0)
  mu2 <- c(0,0)
  sigma1 <- matrix(c(1,0,0,1), nc = 2)
  sigma2 <- matrix(c(1,0.5,0.5,1), nc = 2)
} else if (args[3] == "both") {
  set.seed(1)
  mu1 <- c(0,0)
  mu2 <- c(0,0) + c(0.3,0.3)
  sigma1 <- matrix(c(1,0,0,1), nc = 2)
  sigma2 <- matrix(c(1,0.4,0.4,1), nc = 2)
} else {
  stop(paste("Invalid argument for parameters:", args[3]))
}


#--------------------------------Main-------------------------------------------

Loop=500
Q=powers=array(NA,dim=c(length(Type.Depth),length(m),6))
num_cores <- parallel::detectCores() # Detect the number of usable cores
for(iT in 1:length(Type.Depth)){
  for(im in 1:length(m)){
  print(paste("Current m sample size:",im*100))
  
  # Load the data for both five_Q and H
  current_dir <- getwd()
  dir_path <- file.path(current_dir, "data_two_sample_null")
  file_name  <- paste("null_Q",Type.Depth[iT],m[im],n[im], ".rds",sep = "-")
  complete_path <- file.path(dir_path, file_name)
  five_table=readRDS(file = complete_path)
  five_table=five_table[1:10000,]
  file_name <- paste("null_H",Type.Depth[iT],m[im],n[im], ".rds",sep = "-")
  complete_path <- file.path(dir_path, file_name)
  DbR_table=readRDS(file = complete_path)
  DbR_table=DbR_table[1:10000,]

  # Set the 0.95 threshold for both five_Q and H
  Q[iT,im,] <- c(apply(five_table,2,function (x) quantile(x,probs = 0.95)),
                 quantile(DbR_table,probs = 0.95))
  
  # Gather 500 data points for the six stats each
  h_list <- parallel::mclapply(1:Loop, mc.cores = num_cores, function(i) {
    print(paste("Iteration number:", i))
    Fm <- rbind(mvrnorm(m[im], mu1 ,sigma1))
    Gn <- rbind(mvrnorm(n[im], mu2 ,sigma2))
    c(five_in_all(Fm,Gn,Type.Depth[iT]),H_test(Fm,Gn,Type.Depth[iT]))
  })
  h <- do.call(rbind, h_list)
  
  # Power comparison
  for(j in 1:6)
    powers[iT,im,j]=mean(h[,j]>=Q[iT,im,j])
  }
}


#------------------------------Save output--------------------------------------

# Create a new folder "data-two-sample-power"
if (!dir.exists("data_two_sample_power")){
  dir.create("data_two_sample_power")
}
current_dir <- getwd()
dir_path <- file.path(current_dir, "data_two_sample_power")
file_name <- paste("powers-two-sample",Type.Depth[iT],
                   args[2],args[3],".rds",sep = "-")
complete_path <- file.path(dir_path, file_name)
saveRDS(powers, file = complete_path)


#==================================END==========================================
