
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


#---------------------------Experiment setting----------------------------------

args <- commandArgs(trailingOnly=TRUE) 
depth_type = as.integer(args[1]) # Set depth type
m_value = as.integer(args[2]) # Set m sample size 
n_value = as.integer(args[3]) # Set n sample size

# Set parameters
set.seed(1)
mu1 <- c(0,0)
mu2 <- c(0,0)
sigma1 <- matrix(c(1,0,0,1), nc = 2)
sigma2 <- matrix(c(1,0,0,1), nc = 2) 
Loop=10000


#--------------------------------Main-------------------------------------------

num_cores <- parallel::detectCores() # Detect the number of usable cores

# Create a new folder to store the outputs
if (!dir.exists("data_two_sample_null")){
  dir.create("data_two_sample_null")
}
current_dir <- getwd()
dir_path <- file.path(current_dir, "data_two_sample_null")

get_H_value <- function(depth_type, m_value, n_value) {
  
  # Parallel
  h <- parallel::mclapply(1:Loop, mc.cores = num_cores, function(i) {
    print(paste("Iteration number:", i))
    Fm <- rbind(MASS::mvrnorm(m_value, mu1 ,sigma1))
    Gn <- rbind(MASS::mvrnorm(n_value, mu2 ,sigma2))
    return(H_test(Fm,Gn,depth_type))
  })
  
  # Combine results
  h <- do.call(rbind, h)  
  colnames(h)=c('H')
  
  # Save output
  file_name <- paste("null_H",depth_type, m_value, n_value, ".rds",sep = "-")
  complete_path <- file.path(dir_path, file_name)
  saveRDS(h, file = complete_path)
}

H_value <- get_H_value(depth_type, m_value, n_value)
 

#==================================END==========================================

  
