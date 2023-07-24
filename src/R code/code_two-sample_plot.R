
#=================================START=========================================

#-------------------------------Preparation-------------------------------------

# All the depth name
depths_name <- c("Mahalanobis", "spatial", "projection", "Mahalanobis_Robust", 
                 "betaSkeleton", "L2", "qhpeeling", "simplicial", "zonoid")

# Set command line arguments
args <- commandArgs(trailingOnly=TRUE)
Type.Depth <- as.integer(args[1])
m=c(1:6)*100 

# Locate the power data
current_dir <- getwd()
dir_path <- file.path(current_dir, "data_two_sample_power")
file_name <- paste("powers-two-sample",
                   Type.Depth,args[2],args[3],".rds",sep = "-")
complete_path <- file.path(dir_path, file_name)
my_data=paste(complete_path)
six_table=readRDS(file =my_data)
a=0.06   


#-------------------------------Plot setting------------------------------------

add_legend <- function(...) {
  opar <- par(fig=c(0, 1, 0, 1), oma=c(0, 0, 0, 0), 
              mar=c(0, 0, 0, 0), new=TRUE)
  on.exit(par(opar))
  plot(0, 0, type='n', bty='n', xaxt='n', yaxt='n')
  legend(...)
}

plotchar=c(18,8,3,12,4,7) 
COL=c( "brown","black",  "blue", "purple", "red","darkgreen")
yrange=c(0,1)
if (args[2] == "same") {
  xlab_text <- "m (n=m)"
} else if (args[2] == "different") {
  xlab_text <- "m (n=m/2)"
}

# Create folders to store plots
if (!dir.exists("plots_two_sample_power")){
  dir.create("plots_two_sample_power")
}
if (!dir.exists(paste("plots_two_sample_power",args[3],sep = "/"))){
  dir.create(paste("plots_two_sample_power",args[3],sep = "/"))
}
current_dir <- getwd()
dir_path <- file.path(current_dir, "plots_two_sample_power", args[3])
file_name <- paste("plot",Type.Depth,args[2],args[3],".eps",sep = "-")
complete_path <- file.path(dir_path, file_name)


#----------------------------------Main-----------------------------------------

postscript(complete_path, width = 8, height = 5)
par(cex = 1.5)
plot(m,six_table[1,,1],ylim=yrange,type='b',pch=plotchar[1],col=COL[1],lwd=2,
     ylab=paste("Power (",depths_name[Type.Depth],")"), 
     xlab=xlab_text)
lines(m,six_table[1,,2],type='b',pch=plotchar[2],col=COL[2],lwd=4)
lines(m,six_table[1,,3],type='b',pch=plotchar[3],col=COL[3],lwd=4)
lines(m,six_table[1,,5],type='b',pch=plotchar[4],col=COL[4],lwd=4)
lines(m,six_table[1,,4],type='b',pch=plotchar[5],col=COL[5],lwd=4)
lines(m,six_table[1,,6],type='b',pch=plotchar[6],col=COL[6],lwd=4)
dev.off()


#==================================END==========================================

