# Code to reproduce Figs S2-S5

# Libraries
#install.packages("ggplot2")
#install.packages("readxl")
#install.packages("HDInterval")
#install.packages("cowplot")
library(ggplot2)
library(readxl)
library(HDInterval)
library(cowplot)

# Blue and yellow colours
bblue = "#0000FF"
bbblue = "0000FF60"
yyellow = "#FFD700"
yyyellow = "#FFD70060"

# Change plotting theme
theme_set(theme_classic() + 
            theme(panel.background=element_rect(colour = "grey40", fill = NA),
                  axis.title.x = element_text(size = 16),
                  axis.text.x = element_text(size = 14),
                  axis.title.y = element_text(size = 13),
                  axis.text.y = element_text(size = 14)))

# Functions for quantiles boxplots
## Function to calculate boxplot percentiles
bp.pctiles = function (x, probs = c(0.10, 0.25, 0.5, 0.75, 0.90)) {
  r <- quantile(x, probs = probs, na.rm = TRUE)
  names(r) <- c("ymin", "lower", "middle", "upper", "ymax")
  r
}

## Function to calculate HDI (highest density interval)
hdi.stat = function(x, credMass=0.5) {
  r = unname(HDInterval::hdi(x, credMass=credMass))
  r = c(y=r[1], yend=r[2])
  r
}

## Function to calculate the 10th and 90th percentiles
add.percentiles = function(x) {
  r = quantile(x, probs=c(0.10, 0.90))
  names(r) = c("lwr", "upr")
  r
}

# Set working directory to that containing the data from the folder titled
# "Figs. S2-S5 - Finite Sample Size Regression"
#setwd("...")
#wdirectory_name <- ...
setwd(wdirectory_name)

# Figs. S2-S3 - N=5,j=4

## Import data
N = 5
j = 4
theoretical_exponent = N - j + 1
ps_number = 1
mean_number = 1
xlsxfilename = paste("SyntheticData_Finite_N",as.character(N),"_j",as.character(j),"_ps",as.character(ps_number),"_mean",as.character(mean_number),".xlsx", sep="")

## Construct 'metadata' dataframe with filenames, parameter set number, mean number, etc.
ps_number_vec = c(1, 2, 3, 4, 5)
mean_number_vec = c(1, 5, 10, 25)
filename_list <- list()
mean_number_list <- list()
ps_number_list <- list()
for (ps_number in ps_number_vec) {
  for (mean_number in mean_number_vec) {
    xlsxfilename = paste("SyntheticData_Finite_N",as.character(N),"_j",as.character(j),"_ps",as.character(ps_number),"_mean",as.character(mean_number),".xlsx", sep="")
    filename_list <- append(filename_list, xlsxfilename)
    mean_number_list <- append(mean_number_list, mean_number)
    ps_number_list <- append(ps_number_list, ps_number)
    #print(xlsxfilename)
  }
}
metadata <- data.frame(unlist(ps_number_list), unlist(mean_number_list), unlist(filename_list))
colnames(metadata) <- c("ps_number","mean_number","filename")
metadata$ps_number <- as.factor(metadata$ps_number)
metadata$mean_number <- as.factor(metadata$mean_number)


## Construct new data set for plotting

#datasets 
#assign sample sizes

x_sampsizes <- rep(c(50,100,500,1000,10000),each=5000)
x_sampsizes <- as.factor(x_sampsizes)

#linear regression
data_linreg_mean1_samp <- data.frame(SampSize=x_sampsizes)
data_linreg_mean5_samp <- data.frame(SampSize=x_sampsizes)
data_linreg_mean10_samp <- data.frame(SampSize=x_sampsizes)
data_linreg_mean25_samp <- data.frame(SampSize=x_sampsizes)

#nonlinear regression
data_nonlinreg_mean1_samp <- data.frame(SampSize=x_sampsizes)
data_nonlinreg_mean5_samp <- data.frame(SampSize=x_sampsizes)
data_nonlinreg_mean10_samp <- data.frame(SampSize=x_sampsizes)
data_nonlinreg_mean25_samp <- data.frame(SampSize=x_sampsizes)

#assign parameter sets
x_ps <- rep(c(1,2,3,4,5),each=5000)
x_ps <- as.factor(x_ps)
data_linreg_mean1_ps <- data.frame(ps=x_ps,SS50=rep(c(NA),each=25000),SS100=rep(c(NA),each=25000),SS500=rep(c(NA),each=25000),SS1000=rep(c(NA),each=25000),SS10000=rep(c(NA),each=25000))
data_linreg_mean5_ps <- data.frame(ps=x_ps,SS50=rep(c(NA),each=25000),SS100=rep(c(NA),each=25000),SS500=rep(c(NA),each=25000),SS1000=rep(c(NA),each=25000),SS10000=rep(c(NA),each=25000))
data_linreg_mean10_ps <- data.frame(ps=x_ps,SS50=rep(c(NA),each=25000),SS100=rep(c(NA),each=25000),SS500=rep(c(NA),each=25000),SS1000=rep(c(NA),each=25000),SS10000=rep(c(NA),each=25000))
data_linreg_mean25_ps <- data.frame(ps=x_ps,SS50=rep(c(NA),each=25000),SS100=rep(c(NA),each=25000),SS500=rep(c(NA),each=25000),SS1000=rep(c(NA),each=25000),SS10000=rep(c(NA),each=25000))

data_nonlinreg_mean1_ps <- data.frame(ps=x_ps,SS50=rep(c(NA),each=25000),SS100=rep(c(NA),each=25000),SS500=rep(c(NA),each=25000),SS1000=rep(c(NA),each=25000),SS10000=rep(c(NA),each=25000))
data_nonlinreg_mean5_ps <- data.frame(ps=x_ps,SS50=rep(c(NA),each=25000),SS100=rep(c(NA),each=25000),SS500=rep(c(NA),each=25000),SS1000=rep(c(NA),each=25000),SS10000=rep(c(NA),each=25000))
data_nonlinreg_mean10_ps <- data.frame(ps=x_ps,SS50=rep(c(NA),each=25000),SS100=rep(c(NA),each=25000),SS500=rep(c(NA),each=25000),SS1000=rep(c(NA),each=25000),SS10000=rep(c(NA),each=25000))
data_nonlinreg_mean25_ps <- data.frame(ps=x_ps,SS50=rep(c(NA),each=25000),SS100=rep(c(NA),each=25000),SS500=rep(c(NA),each=25000),SS1000=rep(c(NA),each=25000),SS10000=rep(c(NA),each=25000))

slope_inf_list <- list()
exponent_inf_list <- list()

for (xlsxfilename in filename_list){
  #filename
  filename <- paste(wdirectory_name, xlsxfilename, sep = "")
  
  #read in data (infinite sample size estimates)
  data <- read_excel(filename, range = "M1:N2")
  slope_inf <- as.numeric(data[1])
  exponent_inf <- as.numeric(data[2])
  slope_inf_list <- append(slope_inf_list, slope_inf)
  exponent_inf_list <- append(exponent_inf_list, exponent_inf)
  
  #read in data (sample sizes, slope and exponent estimates)
  data <- read_excel(filename, range = "Q2:S25002")
  SampSize <- data[1]
  Slopes <- data[2]
  Exponents <- data[3]
  
  #find index of row in metadata with corresponding filename
  row_idx <- as.numeric(rownames(metadata[metadata$filename==xlsxfilename,]))
  ps_number <- metadata[row_idx,1]
  mean_number <- metadata[row_idx,2]
  
  #SampSizes datasets first - sample sizes are first column (each column is a different parameter set)
  #assign the data to the correct dataset
  if (mean_number==1) {
    #column name (from parameter set number)
    colname_ <- paste("ps",ps_number,sep="")
    #assign data to data frame
    data_linreg_mean1_samp[, colname_] <- Slopes
    data_nonlinreg_mean1_samp[, colname_] <- Exponents
  } else if (mean_number==5) {
    #column name (from parameter set number)
    colname_ <- paste("ps",ps_number,sep="")
    #assign data to data frame
    data_linreg_mean5_samp[, colname_] <- Slopes
    data_nonlinreg_mean5_samp[, colname_] <- Exponents
  } else if (mean_number==10) {
    #column name (from parameter set number)
    colname_ <- paste("ps",ps_number,sep="")
    #assign data to data frame
    data_linreg_mean10_samp[, colname_] <- Slopes
    data_nonlinreg_mean10_samp[, colname_] <- Exponents
  } else if (mean_number==25) {
    #column name (from parameter set number)
    colname_ <- paste("ps",ps_number,sep="")
    #assign data to data frame
    data_linreg_mean25_samp[, colname_] <- Slopes
    data_nonlinreg_mean25_samp[, colname_] <- Exponents
  }
  
  #split the slopes and exponents by sample sizes
  Slopes_50 <- Slopes[1:5000,1]
  Slopes_100 <- Slopes[5001:10000,1]
  Slopes_500 <- Slopes[10001:15000,1]
  Slopes_1000 <- Slopes[15001:20000,1]
  Slopes_10000 <- Slopes[20001:25000,1]
  Exponents_50 <- Exponents[1:5000,1]
  Exponents_100 <- Exponents[5001:10000,1]
  Exponents_500 <- Exponents[10001:15000,1]
  Exponents_1000 <- Exponents[15001:20000,1]
  Exponents_10000 <- Exponents[20001:25000,1]
  
  #ParameterSets datasets second - parameter set numbers are first column (each column is a different sample size)
  #assign the data to the correct dataset
  if (mean_number==1) {
    if (ps_number==1) {
      #first 1:5000
      #Samp Size = 50
      data_linreg_mean1_ps[1:5000,2] <- Slopes_50
      data_nonlinreg_mean1_ps[1:5000,2] <- Exponents_50
      #Samp Size = 100
      data_linreg_mean1_ps[1:5000,3] <- Slopes_100
      data_nonlinreg_mean1_ps[1:5000,3] <- Exponents_100
      #Samp Size = 500
      data_linreg_mean1_ps[1:5000,4] <- Slopes_500
      data_nonlinreg_mean1_ps[1:5000,4] <- Exponents_500
      #Samp Size = 1000
      data_linreg_mean1_ps[1:5000,5] <- Slopes_1000
      data_nonlinreg_mean1_ps[1:5000,5] <- Exponents_1000
      #Samp Size = 10000
      data_linreg_mean1_ps[1:5000,6] <- Slopes_10000
      data_nonlinreg_mean1_ps[1:5000,6] <- Exponents_10000
    } else if (ps_number==2) {
      #5001:10000
      #Samp Size = 50
      data_linreg_mean1_ps[5001:10000,2] <- Slopes_50
      data_nonlinreg_mean1_ps[5001:10000,2] <- Exponents_50
      #Samp Size = 100
      data_linreg_mean1_ps[5001:10000,3] <- Slopes_100
      data_nonlinreg_mean1_ps[5001:10000,3] <- Exponents_100
      #Samp Size = 500
      data_linreg_mean1_ps[5001:10000,4] <- Slopes_500
      data_nonlinreg_mean1_ps[5001:10000,4] <- Exponents_500
      #Samp Size = 1000
      data_linreg_mean1_ps[5001:10000,5] <- Slopes_1000
      data_nonlinreg_mean1_ps[5001:10000,5] <- Exponents_1000
      #Samp Size = 10000
      data_linreg_mean1_ps[5001:10000,6] <- Slopes_10000
      data_nonlinreg_mean1_ps[5001:10000,6] <- Exponents_10000
    } else if (ps_number==3) {
      #10001:15000
      #Samp Size = 50
      data_linreg_mean1_ps[10001:15000,2] <- Slopes_50
      data_nonlinreg_mean1_ps[10001:15000,2] <- Exponents_50
      #Samp Size = 100
      data_linreg_mean1_ps[10001:15000,3] <- Slopes_100
      data_nonlinreg_mean1_ps[10001:15000,3] <- Exponents_100
      #Samp Size = 500
      data_linreg_mean1_ps[10001:15000,4] <- Slopes_500
      data_nonlinreg_mean1_ps[10001:15000,4] <- Exponents_500
      #Samp Size = 1000
      data_linreg_mean1_ps[10001:15000,5] <- Slopes_1000
      data_nonlinreg_mean1_ps[10001:15000,5] <- Exponents_1000
      #Samp Size = 10000
      data_linreg_mean1_ps[10001:15000,6] <- Slopes_10000
      data_nonlinreg_mean1_ps[10001:15000,6] <- Exponents_10000
    } else if (ps_number==4) {
      #15001:20000
      #Samp Size = 50
      data_linreg_mean1_ps[15001:20000,2] <- Slopes_50
      data_nonlinreg_mean1_ps[15001:20000,2] <- Exponents_50
      #Samp Size = 100
      data_linreg_mean1_ps[15001:20000,3] <- Slopes_100
      data_nonlinreg_mean1_ps[15001:20000,3] <- Exponents_100
      #Samp Size = 500
      data_linreg_mean1_ps[15001:20000,4] <- Slopes_500
      data_nonlinreg_mean1_ps[15001:20000,4] <- Exponents_500
      #Samp Size = 1000
      data_linreg_mean1_ps[15001:20000,5] <- Slopes_1000
      data_nonlinreg_mean1_ps[15001:20000,5] <- Exponents_1000
      #Samp Size = 10000
      data_linreg_mean1_ps[15001:20000,6] <- Slopes_10000
      data_nonlinreg_mean1_ps[15001:20000,6] <- Exponents_10000
    } else if (ps_number==5) {
      #20001:25000
      #Samp Size = 50
      data_linreg_mean1_ps[20001:25000,2] <- Slopes_50
      data_nonlinreg_mean1_ps[20001:25000,2] <- Exponents_50
      #Samp Size = 100
      data_linreg_mean1_ps[20001:25000,3] <- Slopes_100
      data_nonlinreg_mean1_ps[20001:25000,3] <- Exponents_100
      #Samp Size = 500
      data_linreg_mean1_ps[20001:25000,4] <- Slopes_500
      data_nonlinreg_mean1_ps[20001:25000,4] <- Exponents_500
      #Samp Size = 1000
      data_linreg_mean1_ps[20001:25000,5] <- Slopes_1000
      data_nonlinreg_mean1_ps[20001:25000,5] <- Exponents_1000
      #Samp Size = 10000
      data_linreg_mean1_ps[20001:25000,6] <- Slopes_10000
      data_nonlinreg_mean1_ps[20001:25000,6] <- Exponents_10000
    }
  } else if (mean_number==5) {
    if (ps_number==1) {
      #first 1:5000
      #Samp Size = 50
      data_linreg_mean5_ps[1:5000,2] <- Slopes_50
      data_nonlinreg_mean5_ps[1:5000,2] <- Exponents_50
      #Samp Size = 100
      data_linreg_mean5_ps[1:5000,3] <- Slopes_100
      data_nonlinreg_mean5_ps[1:5000,3] <- Exponents_100
      #Samp Size = 500
      data_linreg_mean5_ps[1:5000,4] <- Slopes_500
      data_nonlinreg_mean5_ps[1:5000,4] <- Exponents_500
      #Samp Size = 1000
      data_linreg_mean5_ps[1:5000,5] <- Slopes_1000
      data_nonlinreg_mean5_ps[1:5000,5] <- Exponents_1000
      #Samp Size = 10000
      data_linreg_mean5_ps[1:5000,6] <- Slopes_10000
      data_nonlinreg_mean5_ps[1:5000,6] <- Exponents_10000
    } else if (ps_number==2) {
      #5001:10000
      #Samp Size = 50
      data_linreg_mean5_ps[5001:10000,2] <- Slopes_50
      data_nonlinreg_mean5_ps[5001:10000,2] <- Exponents_50
      #Samp Size = 100
      data_linreg_mean5_ps[5001:10000,3] <- Slopes_100
      data_nonlinreg_mean5_ps[5001:10000,3] <- Exponents_100
      #Samp Size = 500
      data_linreg_mean5_ps[5001:10000,4] <- Slopes_500
      data_nonlinreg_mean5_ps[5001:10000,4] <- Exponents_500
      #Samp Size = 1000
      data_linreg_mean5_ps[5001:10000,5] <- Slopes_1000
      data_nonlinreg_mean5_ps[5001:10000,5] <- Exponents_1000
      #Samp Size = 10000
      data_linreg_mean5_ps[5001:10000,6] <- Slopes_10000
      data_nonlinreg_mean5_ps[5001:10000,6] <- Exponents_10000
    } else if (ps_number==3) {
      #10001:15000
      #Samp Size = 50
      data_linreg_mean5_ps[10001:15000,2] <- Slopes_50
      data_nonlinreg_mean5_ps[10001:15000,2] <- Exponents_50
      #Samp Size = 100
      data_linreg_mean5_ps[10001:15000,3] <- Slopes_100
      data_nonlinreg_mean5_ps[10001:15000,3] <- Exponents_100
      #Samp Size = 500
      data_linreg_mean5_ps[10001:15000,4] <- Slopes_500
      data_nonlinreg_mean5_ps[10001:15000,4] <- Exponents_500
      #Samp Size = 1000
      data_linreg_mean5_ps[10001:15000,5] <- Slopes_1000
      data_nonlinreg_mean5_ps[10001:15000,5] <- Exponents_1000
      #Samp Size = 10000
      data_linreg_mean5_ps[10001:15000,6] <- Slopes_10000
      data_nonlinreg_mean5_ps[10001:15000,6] <- Exponents_10000
    } else if (ps_number==4) {
      #15001:20000
      #Samp Size = 50
      data_linreg_mean5_ps[15001:20000,2] <- Slopes_50
      data_nonlinreg_mean5_ps[15001:20000,2] <- Exponents_50
      #Samp Size = 100
      data_linreg_mean5_ps[15001:20000,3] <- Slopes_100
      data_nonlinreg_mean5_ps[15001:20000,3] <- Exponents_100
      #Samp Size = 500
      data_linreg_mean5_ps[15001:20000,4] <- Slopes_500
      data_nonlinreg_mean5_ps[15001:20000,4] <- Exponents_500
      #Samp Size = 1000
      data_linreg_mean5_ps[15001:20000,5] <- Slopes_1000
      data_nonlinreg_mean5_ps[15001:20000,5] <- Exponents_1000
      #Samp Size = 10000
      data_linreg_mean5_ps[15001:20000,6] <- Slopes_10000
      data_nonlinreg_mean5_ps[15001:20000,6] <- Exponents_10000
    } else if (ps_number==5) {
      #20001:25000
      #Samp Size = 50
      data_linreg_mean5_ps[20001:25000,2] <- Slopes_50
      data_nonlinreg_mean5_ps[20001:25000,2] <- Exponents_50
      #Samp Size = 100
      data_linreg_mean5_ps[20001:25000,3] <- Slopes_100
      data_nonlinreg_mean5_ps[20001:25000,3] <- Exponents_100
      #Samp Size = 500
      data_linreg_mean5_ps[20001:25000,4] <- Slopes_500
      data_nonlinreg_mean5_ps[20001:25000,4] <- Exponents_500
      #Samp Size = 1000
      data_linreg_mean5_ps[20001:25000,5] <- Slopes_1000
      data_nonlinreg_mean5_ps[20001:25000,5] <- Exponents_1000
      #Samp Size = 10000
      data_linreg_mean5_ps[20001:25000,6] <- Slopes_10000
      data_nonlinreg_mean5_ps[20001:25000,6] <- Exponents_10000
    }
  } else if (mean_number==10) {
    if (ps_number==1) {
      #first 1:5000
      #Samp Size = 50
      data_linreg_mean10_ps[1:5000,2] <- Slopes_50
      data_nonlinreg_mean10_ps[1:5000,2] <- Exponents_50
      #Samp Size = 100
      data_linreg_mean10_ps[1:5000,3] <- Slopes_100
      data_nonlinreg_mean10_ps[1:5000,3] <- Exponents_100
      #Samp Size = 500
      data_linreg_mean10_ps[1:5000,4] <- Slopes_500
      data_nonlinreg_mean10_ps[1:5000,4] <- Exponents_500
      #Samp Size = 1000
      data_linreg_mean10_ps[1:5000,5] <- Slopes_1000
      data_nonlinreg_mean10_ps[1:5000,5] <- Exponents_1000
      #Samp Size = 10000
      data_linreg_mean10_ps[1:5000,6] <- Slopes_10000
      data_nonlinreg_mean10_ps[1:5000,6] <- Exponents_10000
    } else if (ps_number==2) {
      #5001:10000
      #Samp Size = 50
      data_linreg_mean10_ps[5001:10000,2] <- Slopes_50
      data_nonlinreg_mean10_ps[5001:10000,2] <- Exponents_50
      #Samp Size = 100
      data_linreg_mean10_ps[5001:10000,3] <- Slopes_100
      data_nonlinreg_mean10_ps[5001:10000,3] <- Exponents_100
      #Samp Size = 500
      data_linreg_mean10_ps[5001:10000,4] <- Slopes_500
      data_nonlinreg_mean10_ps[5001:10000,4] <- Exponents_500
      #Samp Size = 1000
      data_linreg_mean10_ps[5001:10000,5] <- Slopes_1000
      data_nonlinreg_mean10_ps[5001:10000,5] <- Exponents_1000
      #Samp Size = 10000
      data_linreg_mean10_ps[5001:10000,6] <- Slopes_10000
      data_nonlinreg_mean10_ps[5001:10000,6] <- Exponents_10000
    } else if (ps_number==3) {
      #10001:15000
      #Samp Size = 50
      data_linreg_mean10_ps[10001:15000,2] <- Slopes_50
      data_nonlinreg_mean10_ps[10001:15000,2] <- Exponents_50
      #Samp Size = 100
      data_linreg_mean10_ps[10001:15000,3] <- Slopes_100
      data_nonlinreg_mean10_ps[10001:15000,3] <- Exponents_100
      #Samp Size = 500
      data_linreg_mean10_ps[10001:15000,4] <- Slopes_500
      data_nonlinreg_mean10_ps[10001:15000,4] <- Exponents_500
      #Samp Size = 1000
      data_linreg_mean10_ps[10001:15000,5] <- Slopes_1000
      data_nonlinreg_mean10_ps[10001:15000,5] <- Exponents_1000
      #Samp Size = 10000
      data_linreg_mean10_ps[10001:15000,6] <- Slopes_10000
      data_nonlinreg_mean10_ps[10001:15000,6] <- Exponents_10000
    } else if (ps_number==4) {
      #15001:20000
      #Samp Size = 50
      data_linreg_mean10_ps[15001:20000,2] <- Slopes_50
      data_nonlinreg_mean10_ps[15001:20000,2] <- Exponents_50
      #Samp Size = 100
      data_linreg_mean10_ps[15001:20000,3] <- Slopes_100
      data_nonlinreg_mean10_ps[15001:20000,3] <- Exponents_100
      #Samp Size = 500
      data_linreg_mean10_ps[15001:20000,4] <- Slopes_500
      data_nonlinreg_mean10_ps[15001:20000,4] <- Exponents_500
      #Samp Size = 1000
      data_linreg_mean10_ps[15001:20000,5] <- Slopes_1000
      data_nonlinreg_mean10_ps[15001:20000,5] <- Exponents_1000
      #Samp Size = 10000
      data_linreg_mean10_ps[15001:20000,6] <- Slopes_10000
      data_nonlinreg_mean10_ps[15001:20000,6] <- Exponents_10000
    } else if (ps_number==5) {
      #20001:25000
      #Samp Size = 50
      data_linreg_mean10_ps[20001:25000,2] <- Slopes_50
      data_nonlinreg_mean10_ps[20001:25000,2] <- Exponents_50
      #Samp Size = 100
      data_linreg_mean10_ps[20001:25000,3] <- Slopes_100
      data_nonlinreg_mean10_ps[20001:25000,3] <- Exponents_100
      #Samp Size = 500
      data_linreg_mean10_ps[20001:25000,4] <- Slopes_500
      data_nonlinreg_mean10_ps[20001:25000,4] <- Exponents_500
      #Samp Size = 1000
      data_linreg_mean10_ps[20001:25000,5] <- Slopes_1000
      data_nonlinreg_mean10_ps[20001:25000,5] <- Exponents_1000
      #Samp Size = 10000
      data_linreg_mean10_ps[20001:25000,6] <- Slopes_10000
      data_nonlinreg_mean10_ps[20001:25000,6] <- Exponents_10000
    }
  } else if (mean_number==25) {
    if (ps_number==1) {
      #first 1:5000
      #Samp Size = 50
      data_linreg_mean25_ps[1:5000,2] <- Slopes_50
      data_nonlinreg_mean25_ps[1:5000,2] <- Exponents_50
      #Samp Size = 100
      data_linreg_mean25_ps[1:5000,3] <- Slopes_100
      data_nonlinreg_mean25_ps[1:5000,3] <- Exponents_100
      #Samp Size = 500
      data_linreg_mean25_ps[1:5000,4] <- Slopes_500
      data_nonlinreg_mean25_ps[1:5000,4] <- Exponents_500
      #Samp Size = 1000
      data_linreg_mean25_ps[1:5000,5] <- Slopes_1000
      data_nonlinreg_mean25_ps[1:5000,5] <- Exponents_1000
      #Samp Size = 10000
      data_linreg_mean25_ps[1:5000,6] <- Slopes_10000
      data_nonlinreg_mean25_ps[1:5000,6] <- Exponents_10000
    } else if (ps_number==2) {
      #5001:10000
      #Samp Size = 50
      data_linreg_mean25_ps[5001:10000,2] <- Slopes_50
      data_nonlinreg_mean25_ps[5001:10000,2] <- Exponents_50
      #Samp Size = 100
      data_linreg_mean25_ps[5001:10000,3] <- Slopes_100
      data_nonlinreg_mean25_ps[5001:10000,3] <- Exponents_100
      #Samp Size = 500
      data_linreg_mean25_ps[5001:10000,4] <- Slopes_500
      data_nonlinreg_mean25_ps[5001:10000,4] <- Exponents_500
      #Samp Size = 1000
      data_linreg_mean25_ps[5001:10000,5] <- Slopes_1000
      data_nonlinreg_mean25_ps[5001:10000,5] <- Exponents_1000
      #Samp Size = 10000
      data_linreg_mean25_ps[5001:10000,6] <- Slopes_10000
      data_nonlinreg_mean25_ps[5001:10000,6] <- Exponents_10000
    } else if (ps_number==3) {
      #10001:15000
      #Samp Size = 50
      data_linreg_mean25_ps[10001:15000,2] <- Slopes_50
      data_nonlinreg_mean25_ps[10001:15000,2] <- Exponents_50
      #Samp Size = 100
      data_linreg_mean25_ps[10001:15000,3] <- Slopes_100
      data_nonlinreg_mean25_ps[10001:15000,3] <- Exponents_100
      #Samp Size = 500
      data_linreg_mean25_ps[10001:15000,4] <- Slopes_500
      data_nonlinreg_mean25_ps[10001:15000,4] <- Exponents_500
      #Samp Size = 1000
      data_linreg_mean25_ps[10001:15000,5] <- Slopes_1000
      data_nonlinreg_mean25_ps[10001:15000,5] <- Exponents_1000
      #Samp Size = 10000
      data_linreg_mean25_ps[10001:15000,6] <- Slopes_10000
      data_nonlinreg_mean25_ps[10001:15000,6] <- Exponents_10000
    } else if (ps_number==4) {
      #15001:20000
      #Samp Size = 50
      data_linreg_mean25_ps[15001:20000,2] <- Slopes_50
      data_nonlinreg_mean25_ps[15001:20000,2] <- Exponents_50
      #Samp Size = 100
      data_linreg_mean25_ps[15001:20000,3] <- Slopes_100
      data_nonlinreg_mean25_ps[15001:20000,3] <- Exponents_100
      #Samp Size = 500
      data_linreg_mean25_ps[15001:20000,4] <- Slopes_500
      data_nonlinreg_mean25_ps[15001:20000,4] <- Exponents_500
      #Samp Size = 1000
      data_linreg_mean25_ps[15001:20000,5] <- Slopes_1000
      data_nonlinreg_mean25_ps[15001:20000,5] <- Exponents_1000
      #Samp Size = 10000
      data_linreg_mean25_ps[15001:20000,6] <- Slopes_10000
      data_nonlinreg_mean25_ps[15001:20000,6] <- Exponents_10000
    } else if (ps_number==5) {
      #20001:25000
      #Samp Size = 50
      data_linreg_mean25_ps[20001:25000,2] <- Slopes_50
      data_nonlinreg_mean25_ps[20001:25000,2] <- Exponents_50
      #Samp Size = 100
      data_linreg_mean25_ps[20001:25000,3] <- Slopes_100
      data_nonlinreg_mean25_ps[20001:25000,3] <- Exponents_100
      #Samp Size = 500
      data_linreg_mean25_ps[20001:25000,4] <- Slopes_500
      data_nonlinreg_mean25_ps[20001:25000,4] <- Exponents_500
      #Samp Size = 1000
      data_linreg_mean25_ps[20001:25000,5] <- Slopes_1000
      data_nonlinreg_mean25_ps[20001:25000,5] <- Exponents_1000
      #Samp Size = 10000
      data_linreg_mean25_ps[20001:25000,6] <- Slopes_10000
      data_nonlinreg_mean25_ps[20001:25000,6] <- Exponents_10000
    }
  }
  
  
}
metadata$slope_inf <- unlist(slope_inf_list)
metadata$exponent_inf <- unlist(exponent_inf_list)

# Plot boxplots on same figure

#big y axis = mean numbers
#big x axis = parameter set numbers

## Fig. S2 - Linear regression

ylim_down <- 0.5
ylim_up <- 2.5
ytick_down <- 0.5
ytick_up <- 2.5
ytick_jump <- 0.5

#mean = 1
list_plots1 <- vector('list', 5)
inf_idx1 = c(1,5,9,13,17)
variable_to_be_plotted<-c("ps1","ps2","ps3","ps4","ps5")
for (i in seq_along(list_plots1)) {
  list_plots1[[i]] <- ggplot(data_linreg_mean1_samp[5001:25000,], aes(x=SampSize, y=.data[[variable_to_be_plotted[i]]])) +
    # Add boxplots
    stat_summary(fun.data=bp.pctiles, geom="boxplot",  linewidth=0.5, width=0.5, 
                 color=bblue, fill=bblue, alpha=0.4) +
    # Add two more percentiles as dashes across the boxplot whiskers
    stat_summary(fun.y=add.percentiles, geom="point", pch="_", colour=bblue,
                 size=6) +
    # Add theoretical exponent line
    geom_hline(yintercept = theoretical_exponent, linetype="dashed", color="red",
               linewidth=1) +
    # Add infinite sample size estimate line
    geom_hline(yintercept = metadata[inf_idx1[i],4], linetype="dashed", color="grey40",
               linewidth=0.8) +
    #labels
    labs(x="Sample size", y="Estimated exponent") +
    #ylims
    coord_cartesian(ylim=c(ylim_down,2.2)) +
    #yticks
    scale_y_continuous(breaks=seq(ytick_down,ytick_up,ytick_jump))
}

pg1 <- plot_grid(list_plots1[[1]], list_plots1[[2]], list_plots1[[3]], list_plots1[[4]],
                 list_plots1[[5]], labels = c('A', 'B', 'C', 'D', 'E'), label_size = 16,
                 nrow = 1)
pg1

#mean = 5
list_plots2 <- vector('list', 5)
inf_idx2 = c(2,6,10,14,18)
variable_to_be_plotted<-c("ps1","ps2","ps3","ps4","ps5")
for (i in seq_along(list_plots2)) {
  list_plots2[[i]] <- ggplot(data_linreg_mean5_samp[5001:25000,], aes(x=SampSize, y=.data[[variable_to_be_plotted[i]]])) +
    # Add boxplots
    stat_summary(fun.data=bp.pctiles, geom="boxplot",  linewidth=0.5, width=0.5, 
                 color=bblue, fill=bblue, alpha=0.4) +
    # Add two more percentiles as dashes across the boxplot whiskers
    stat_summary(fun.y=add.percentiles, geom="point", pch="_", colour=bblue,
                 size=6) +
    # Add theoretical exponent line
    geom_hline(yintercept = theoretical_exponent, linetype="dashed", color="red",
               linewidth=1) +
    # Add infinite sample size estimate line
    geom_hline(yintercept = metadata[inf_idx2[i],4], linetype="dashed", color="grey40",
               linewidth=0.8) +
    #labels
    labs(x="Sample size", y="Estimated exponent") +
    #ylims
    coord_cartesian(ylim=c(ylim_down,ylim_up)) + 
    #yticks
    scale_y_continuous(breaks=seq(ytick_down,ytick_up,ytick_jump))
}

pg2 <- plot_grid(list_plots2[[1]], list_plots2[[2]], list_plots2[[3]], list_plots2[[4]],
                 list_plots2[[5]], labels = c('F', 'G', 'H', 'I', 'J'), label_size = 16,
                 nrow = 1)
pg2

#mean = 10
list_plots3 <- vector('list', 5)
inf_idx3 = c(3,7,11,15,19)
variable_to_be_plotted<-c("ps1","ps2","ps3","ps4","ps5")
for (i in seq_along(list_plots3)) {
  list_plots3[[i]] <- ggplot(data_linreg_mean10_samp[5001:25000,], aes(x=SampSize, y=.data[[variable_to_be_plotted[i]]])) +
    # Add boxplots
    stat_summary(fun.data=bp.pctiles, geom="boxplot",  linewidth=0.5, width=0.5, 
                 color=bblue, fill=bblue, alpha=0.4) +
    # Add two more percentiles as dashes across the boxplot whiskers
    stat_summary(fun.y=add.percentiles, geom="point", pch="_", colour=bblue,
                 size=6) +
    # Add theoretical exponent line
    geom_hline(yintercept = theoretical_exponent, linetype="dashed", color="red",
               linewidth=1) +
    # Add infinite sample size estimate line
    geom_hline(yintercept = metadata[inf_idx3[i],4], linetype="dashed", color="grey40",
               linewidth=0.8) +
    #labels
    labs(x="Sample size", y="Estimated exponent") +
    #ylims
    coord_cartesian(ylim=c(0.8,ylim_up)) + 
    #yticks
    scale_y_continuous(breaks=seq(ytick_down,ytick_up,ytick_jump))
}

pg3 <- plot_grid(list_plots3[[1]], list_plots3[[2]], list_plots3[[3]], list_plots3[[4]],
                 list_plots3[[5]], labels = c('K', 'L', 'M', 'N', 'O'), label_size = 16,
                 nrow = 1)
pg3

#mean = 25
list_plots4 <- vector('list', 5)
inf_idx4 = c(4,8,12,16,20)
variable_to_be_plotted<-c("ps1","ps2","ps3","ps4","ps5")
for (i in seq_along(list_plots4)) {
  list_plots4[[i]] <- ggplot(data_linreg_mean25_samp[5001:25000,], aes(x=SampSize, y=.data[[variable_to_be_plotted[i]]])) +
    # Add boxplots
    stat_summary(fun.data=bp.pctiles, geom="boxplot",  linewidth=0.5, width=0.5, 
                 color=bblue, fill=bblue, alpha=0.4) +
    # Add two more percentiles as dashes across the boxplot whiskers
    stat_summary(fun.y=add.percentiles, geom="point", pch="_", colour=bblue,
                 size=6) +
    # Add theoretical exponent line
    geom_hline(yintercept = theoretical_exponent, linetype="dashed", color="red",
               linewidth=1) +
    # Add infinite sample size estimate line
    geom_hline(yintercept = metadata[inf_idx4[i],4], linetype="dashed", color="grey40",
               linewidth=0.8) +
    #labels
    labs(x="Sample size", y="Estimated exponent") +
    #ylims
    coord_cartesian(ylim=c(1.4,ylim_up)) + 
    #yticks
    scale_y_continuous(breaks=seq(ytick_down,ytick_up,ytick_jump))
}

pg4 <- plot_grid(list_plots4[[1]], list_plots4[[2]], list_plots4[[3]], list_plots4[[4]],
                 list_plots4[[5]], labels = c('P', 'Q', 'R', 'S', 'T'), label_size = 16,
                 nrow = 1)
pg4

pg_all <- plot_grid(pg1, pg2, pg3, pg4, nrow = 4)
pg_all

## Fig. S3 - Nonlinear regression

ylim_down <- 0.5
ylim_up <- 2.7
ytick_down <- 0.5
ytick_up <- 3.0
ytick_jump <- 0.5

#mean = 1
list_plots1 <- vector('list', 5)
inf_idx1 = c(1,5,9,13,17)
variable_to_be_plotted<-c("ps1","ps2","ps3","ps4","ps5")
for (i in seq_along(list_plots1)) {
  list_plots1[[i]] <- ggplot(data_nonlinreg_mean1_samp[5001:25000,], aes(x=SampSize, y=.data[[variable_to_be_plotted[i]]])) +
    # Add boxplots
    stat_summary(fun.data=bp.pctiles, geom="boxplot",  linewidth=0.5, width=0.5, 
                 color=yyellow, fill=yyellow, alpha=0.4) +
    # Add two more percentiles as dashes across the boxplot whiskers
    stat_summary(fun.y=add.percentiles, geom="point", pch="_", colour=yyellow,
                 size=6) +
    # Add theoretical exponent line
    geom_hline(yintercept = theoretical_exponent, linetype="dashed", color="red",
               linewidth=1) +
    # Add infinite sample size estimate line
    geom_hline(yintercept = metadata[inf_idx1[i],5], linetype="dashed", color="grey40",
               linewidth=0.8) +
    #labels
    labs(x="Sample size", y="Estimated exponent") +
    #ylims
    coord_cartesian(ylim=c(ylim_down,2.0)) +
    #yticks
    scale_y_continuous(breaks=seq(ytick_down,ytick_up,ytick_jump))
}

pg1 <- plot_grid(list_plots1[[1]], list_plots1[[2]], list_plots1[[3]], list_plots1[[4]],
                 list_plots1[[5]], labels = c('A', 'B', 'C', 'D', 'E'), label_size = 16,
                 nrow = 1)
pg1

#mean = 5
list_plots2 <- vector('list', 5)
inf_idx2 = c(2,6,10,14,18)
variable_to_be_plotted<-c("ps1","ps2","ps3","ps4","ps5")
for (i in seq_along(list_plots2)) {
  list_plots2[[i]] <- ggplot(data_nonlinreg_mean5_samp[5001:25000,], aes(x=SampSize, y=.data[[variable_to_be_plotted[i]]])) +
    # Add boxplots
    stat_summary(fun.data=bp.pctiles, geom="boxplot",  linewidth=0.5, width=0.5, 
                 color=yyellow, fill=yyellow, alpha=0.4) +
    # Add two more percentiles as dashes across the boxplot whiskers
    stat_summary(fun.y=add.percentiles, geom="point", pch="_", colour=yyellow,
                 size=6) +
    # Add theoretical exponent line
    geom_hline(yintercept = theoretical_exponent, linetype="dashed", color="red",
               linewidth=1) +
    # Add infinite sample size estimate line
    geom_hline(yintercept = metadata[inf_idx2[i],5], linetype="dashed", color="grey40",
               linewidth=0.8) +
    #labels
    labs(x="Sample size", y="Estimated exponent") +
    #ylims
    coord_cartesian(ylim=c(ylim_down,ylim_up)) + 
    #yticks
    scale_y_continuous(breaks=seq(ytick_down,ytick_up,ytick_jump))
}

pg2 <- plot_grid(list_plots2[[1]], list_plots2[[2]], list_plots2[[3]], list_plots2[[4]],
                 list_plots2[[5]], labels = c('F', 'G', 'H', 'I', 'J'), label_size = 16,
                 nrow = 1)
pg2

#mean = 10
list_plots3 <- vector('list', 5)
inf_idx3 = c(3,7,11,15,19)
variable_to_be_plotted<-c("ps1","ps2","ps3","ps4","ps5")
for (i in seq_along(list_plots3)) {
  list_plots3[[i]] <- ggplot(data_nonlinreg_mean10_samp[5001:25000,], aes(x=SampSize, y=.data[[variable_to_be_plotted[i]]])) +
    # Add boxplots
    stat_summary(fun.data=bp.pctiles, geom="boxplot",  linewidth=0.5, width=0.5, 
                 color=yyellow, fill=yyellow, alpha=0.4) +
    # Add two more percentiles as dashes across the boxplot whiskers
    stat_summary(fun.y=add.percentiles, geom="point", pch="_", colour=yyellow,
                 size=6) +
    # Add theoretical exponent line
    geom_hline(yintercept = theoretical_exponent, linetype="dashed", color="red",
               linewidth=1) +
    # Add infinite sample size estimate line
    geom_hline(yintercept = metadata[inf_idx3[i],5], linetype="dashed", color="grey40",
               linewidth=0.8) +
    #labels
    labs(x="Sample size", y="Estimated exponent") +
    #ylims
    coord_cartesian(ylim=c(0.7,ylim_up)) + 
    #yticks
    scale_y_continuous(breaks=seq(ytick_down,ytick_up,ytick_jump))
}

pg3 <- plot_grid(list_plots3[[1]], list_plots3[[2]], list_plots3[[3]], list_plots3[[4]],
                 list_plots3[[5]], labels = c('K', 'L', 'M', 'N', 'O'), label_size = 16,
                 nrow = 1)
pg3

#mean = 25
list_plots4 <- vector('list', 5)
inf_idx4 = c(4,8,12,16,20)
variable_to_be_plotted<-c("ps1","ps2","ps3","ps4","ps5")
for (i in seq_along(list_plots4)) {
  list_plots4[[i]] <- ggplot(data_nonlinreg_mean25_samp[5001:25000,], aes(x=SampSize, y=.data[[variable_to_be_plotted[i]]])) +
    # Add boxplots
    stat_summary(fun.data=bp.pctiles, geom="boxplot",  linewidth=0.5, width=0.5, 
                 color=yyellow, fill=yyellow, alpha=0.4) +
    # Add two more percentiles as dashes across the boxplot whiskers
    stat_summary(fun.y=add.percentiles, geom="point", pch="_", colour=yyellow,
                 size=6) +
    # Add theoretical exponent line
    geom_hline(yintercept = theoretical_exponent, linetype="dashed", color="red",
               linewidth=1) +
    # Add infinite sample size estimate line
    geom_hline(yintercept = metadata[inf_idx4[i],5], linetype="dashed", color="grey40",
               linewidth=0.8) +
    #labels
    labs(x="Sample size", y="Estimated exponent") +
    #ylims
    coord_cartesian(ylim=c(1.3,2.5)) + 
    #yticks
    scale_y_continuous(breaks=seq(ytick_down,ytick_up,ytick_jump))
}

pg4 <- plot_grid(list_plots4[[1]], list_plots4[[2]], list_plots4[[3]], list_plots4[[4]],
                 list_plots4[[5]], labels = c('P', 'Q', 'R', 'S', 'T'), label_size = 16,
                 nrow = 1)
pg4

pg_all <- plot_grid(pg1, pg2, pg3, pg4, nrow = 4)
pg_all

# Figs. S4-S5 - N=5,j=1

## Import data
N = 5
j = 1
theoretical_exponent = N - j + 1
ps_number = 1
mean_number = 1
xlsxfilename = paste("SyntheticData_Finite_N",as.character(N),"_j",as.character(j),"_ps",as.character(ps_number),"_mean",as.character(mean_number),".xlsx", sep="")

## Construct 'metadata' dataframe with filenames, parameter set number, mean number, etc.
ps_number_vec = c(1, 2, 3, 4, 5)
mean_number_vec = c(1, 5, 8, 12)
filename_list <- list()
mean_number_list <- list()
ps_number_list <- list()
for (ps_number in ps_number_vec) {
  for (mean_number in mean_number_vec) {
    xlsxfilename = paste("SyntheticData_Finite_N",as.character(N),"_j",as.character(j),"_ps",as.character(ps_number),"_mean",as.character(mean_number),".xlsx", sep="")
    filename_list <- append(filename_list, xlsxfilename)
    mean_number_list <- append(mean_number_list, mean_number)
    ps_number_list <- append(ps_number_list, ps_number)
    #print(xlsxfilename)
  }
}
metadata <- data.frame(unlist(ps_number_list), unlist(mean_number_list), unlist(filename_list))
colnames(metadata) <- c("ps_number","mean_number","filename")
metadata$ps_number <- as.factor(metadata$ps_number)
metadata$mean_number <- as.factor(metadata$mean_number)

## Construct new data set for plotting

#datasets 
#assign sampsizes
x_sampsizes <- rep(c(100,500,1000,10000),each=5000)
x_sampsizes <- as.factor(x_sampsizes)
data_linreg_mean1_samp <- data.frame(SampSize=x_sampsizes)
data_linreg_mean5_samp <- data.frame(SampSize=x_sampsizes)
data_linreg_mean8_samp <- data.frame(SampSize=x_sampsizes)
data_linreg_mean12_samp <- data.frame(SampSize=x_sampsizes)

data_nonlinreg_mean1_samp <- data.frame(SampSize=x_sampsizes)
data_nonlinreg_mean5_samp <- data.frame(SampSize=x_sampsizes)
data_nonlinreg_mean8_samp <- data.frame(SampSize=x_sampsizes)
data_nonlinreg_mean12_samp <- data.frame(SampSize=x_sampsizes)

slope_inf_list <- list()
exponent_inf_list <- list()

for (xlsxfilename in filename_list){
  #filename
  filename <- paste(wdirectory_name, xlsxfilename, sep = "")
  
  #read in data (infinite sample size estimates)
  data <- read_excel(filename, range = "M1:N2")
  slope_inf <- as.numeric(data[1])
  exponent_inf <- as.numeric(data[2])
  slope_inf_list <- append(slope_inf_list, slope_inf)
  exponent_inf_list <- append(exponent_inf_list, exponent_inf)
  
  #find index of row in metadata with corresponding filename
  row_idx <- as.numeric(rownames(metadata[metadata$filename==xlsxfilename,]))
  ps_number <- metadata[row_idx,1]
  mean_number <- metadata[row_idx,2]
  
  #read in data (sample sizes, slope and exponent estimates)
  if (mean_number==1) {
    #no sample sizes 50 and 100
    data <- read_excel(filename, range = "Q2:S15002")
    SampSize <- data[1]
    Slopes <- data[2]
    Exponents <- data[3]
  } else if (mean_number==5 & ps_number==4) {
    #no sample size 50
    data <- read_excel(filename, range = "Q2:S20002")
    SampSize <- data[1]
    Slopes <- data[2]
    Exponents <- data[3]
  } else if ( (mean_number==8 & ps_number==3) | (mean_number==8 & ps_number==4) | (mean_number==8 & ps_number==5)) {
    #no sample size 50
    data <- read_excel(filename, range = "Q2:S20002")
    SampSize <- data[1]
    Slopes <- data[2]
    Exponents <- data[3]
  } else if (mean_number==12) {
    #no sample size 50
    data <- read_excel(filename, range = "Q2:S20002")
    SampSize <- data[1]
    Slopes <- data[2]
    Exponents <- data[3]
  } else {
    #no sample size 50
    data <- read_excel(filename, range = "Q5002:S25002")
    SampSize <- data[1]
    Slopes <- data[2]
    Exponents <- data[3]
  }
  
  #SampSizes datasets first - sample sizes are first column (each column is a different parameter set)
  #assign the data to the correct dataset
  if (mean_number==1) {
    #column name (from parameter set number)
    colname_ <- paste("ps",ps_number,sep="")
    #assign data to data frame
    #skip the 100 sample size values
    data_linreg_mean1_samp[, colname_] <- NA
    data_nonlinreg_mean1_samp[, colname_] <- NA
    #assign the 500, 1000, and 10000 sample size values
    data_linreg_mean1_samp[5001:20000, colname_] <- Slopes
    data_nonlinreg_mean1_samp[5001:20000, colname_] <- Exponents
  } else if (mean_number==5) {
    #column name (from parameter set number)
    colname_ <- paste("ps",ps_number,sep="")
    #assign data to data frame
    data_linreg_mean5_samp[, colname_] <- Slopes
    data_nonlinreg_mean5_samp[, colname_] <- Exponents
  } else if (mean_number==8) {
    #column name (from parameter set number)
    colname_ <- paste("ps",ps_number,sep="")
    #assign data to data frame
    data_linreg_mean8_samp[, colname_] <- Slopes
    data_nonlinreg_mean8_samp[, colname_] <- Exponents
  } else if (mean_number==12) {
    #column name (from parameter set number)
    colname_ <- paste("ps",ps_number,sep="")
    #assign data to data frame
    data_linreg_mean12_samp[, colname_] <- Slopes
    data_nonlinreg_mean12_samp[, colname_] <- Exponents
  }
  
  
}
metadata$slope_inf <- unlist(slope_inf_list)
metadata$exponent_inf <- unlist(exponent_inf_list)

# Plot boxplots on same figure

#big y axis = mean numbers
#big x axis = parameter set numbers

## Fig. S4 - Linear regression

ylim_down <- 1.5
ylim_up <- 5.0
ytick_down <- 1.0
ytick_up <- 5.5
ytick_jump <- 1.0

#mean = 1
list_plots1 <- vector('list', 5)
inf_idx1 = c(1,5,9,13,17)
variable_to_be_plotted<-c("ps1","ps2","ps3","ps4","ps5")
for (i in seq_along(list_plots1)) {
  list_plots1[[i]] <- ggplot(data_linreg_mean1_samp, aes(x=SampSize, y=.data[[variable_to_be_plotted[i]]])) +
    # Add boxplots
    stat_summary(fun.data=bp.pctiles, geom="boxplot",  linewidth=0.5, width=0.5, 
                 color=bblue, fill=bblue, alpha=0.4) +
    # Add two more percentiles as dashes across the boxplot whiskers
    stat_summary(fun.y=add.percentiles, geom="point", pch="_", colour=bblue,
                 size=6) +
    # Add theoretical exponent line
    geom_hline(yintercept = theoretical_exponent, linetype="dashed", color="red",
               linewidth=1) +
    # Add infinite sample size estimate line
    geom_hline(yintercept = metadata[inf_idx1[i],4], linetype="dashed", color="grey40",
               linewidth=0.8) +
    #labels
    labs(x="Sample size", y="Estimated exponent") +
    #ylims
    coord_cartesian(ylim=c(ylim_down,ylim_up)) +
    #yticks
    scale_y_continuous(breaks=seq(ytick_down,ytick_up,ytick_jump))
}

pg1 <- plot_grid(list_plots1[[1]], list_plots1[[2]], list_plots1[[3]], list_plots1[[4]],
                 list_plots1[[5]], labels = c('A', 'B', 'C', 'D', 'E'), label_size = 16,
                 nrow = 1)
pg1

#mean = 5
list_plots2 <- vector('list', 5)
inf_idx2 = c(2,6,10,14,18)
variable_to_be_plotted<-c("ps1","ps2","ps3","ps4","ps5")
for (i in seq_along(list_plots2)) {
  list_plots2[[i]] <- ggplot(data_linreg_mean5_samp, aes(x=SampSize, y=.data[[variable_to_be_plotted[i]]])) +
    # Add boxplots
    stat_summary(fun.data=bp.pctiles, geom="boxplot",  linewidth=0.5, width=0.5, 
                 color=bblue, fill=bblue, alpha=0.4) +
    # Add two more percentiles as dashes across the boxplot whiskers
    stat_summary(fun.y=add.percentiles, geom="point", pch="_", colour=bblue,
                 size=6) +
    # Add theoretical exponent line
    geom_hline(yintercept = theoretical_exponent, linetype="dashed", color="red",
               linewidth=1) +
    # Add infinite sample size estimate line
    geom_hline(yintercept = metadata[inf_idx2[i],4], linetype="dashed", color="grey40",
               linewidth=0.8) +
    #labels
    labs(x="Sample size", y="Estimated exponent") +
    #ylims
    coord_cartesian(ylim=c(0.5,ylim_up)) + 
    #yticks
    scale_y_continuous(breaks=seq(ytick_down,ytick_up,ytick_jump))
}

pg2 <- plot_grid(list_plots2[[1]], list_plots2[[2]], list_plots2[[3]], list_plots2[[4]],
                 list_plots2[[5]], labels = c('F', 'G', 'H', 'I', 'J'), label_size = 16,
                 nrow = 1)
pg2

#mean = 8
list_plots3 <- vector('list', 5)
inf_idx3 = c(3,7,11,15,19)
variable_to_be_plotted<-c("ps1","ps2","ps3","ps4","ps5")
for (i in seq_along(list_plots3)) {
  list_plots3[[i]] <- ggplot(data_linreg_mean8_samp, aes(x=SampSize, y=.data[[variable_to_be_plotted[i]]])) +
    # Add boxplots
    stat_summary(fun.data=bp.pctiles, geom="boxplot",  linewidth=0.5, width=0.5, 
                 color=bblue, fill=bblue, alpha=0.4) +
    # Add two more percentiles as dashes across the boxplot whiskers
    stat_summary(fun.y=add.percentiles, geom="point", pch="_", colour=bblue,
                 size=6) +
    # Add theoretical exponent line
    geom_hline(yintercept = theoretical_exponent, linetype="dashed", color="red",
               linewidth=1) +
    # Add infinite sample size estimate line
    geom_hline(yintercept = metadata[inf_idx3[i],4], linetype="dashed", color="grey40",
               linewidth=0.8) +
    #labels
    labs(x="Sample size", y="Estimated exponent") +
    #ylims
    coord_cartesian(ylim=c(ylim_down,ylim_up)) + 
    #yticks
    scale_y_continuous(breaks=seq(ytick_down,ytick_up,ytick_jump))
}

pg3 <- plot_grid(list_plots3[[1]], list_plots3[[2]], list_plots3[[3]], list_plots3[[4]],
                 list_plots3[[5]], labels = c('K', 'L', 'M', 'N', 'O'), label_size = 16,
                 nrow = 1)
pg3

#mean = 12
list_plots4 <- vector('list', 5)
inf_idx4 = c(4,8,12,16,20)
variable_to_be_plotted<-c("ps1","ps2","ps3","ps4","ps5")
for (i in seq_along(list_plots4)) {
  list_plots4[[i]] <- ggplot(data_linreg_mean12_samp, aes(x=SampSize, y=.data[[variable_to_be_plotted[i]]])) +
    # Add boxplots
    stat_summary(fun.data=bp.pctiles, geom="boxplot",  linewidth=0.5, width=0.5, 
                 color=bblue, fill=bblue, alpha=0.4) +
    # Add two more percentiles as dashes across the boxplot whiskers
    stat_summary(fun.y=add.percentiles, geom="point", pch="_", colour=bblue,
                 size=6) +
    # Add theoretical exponent line
    geom_hline(yintercept = theoretical_exponent, linetype="dashed", color="red",
               linewidth=1) +
    # Add infinite sample size estimate line
    geom_hline(yintercept = metadata[inf_idx4[i],4], linetype="dashed", color="grey40",
               linewidth=0.8) +
    #labels
    labs(x="Sample size", y="Estimated exponent") +
    #ylims
    coord_cartesian(ylim=c(1.2,5.5)) + 
    #yticks
    scale_y_continuous(breaks=seq(ytick_down,ytick_up,ytick_jump))
}

pg4 <- plot_grid(list_plots4[[1]], list_plots4[[2]], list_plots4[[3]], list_plots4[[4]],
                 list_plots4[[5]], labels = c('P', 'Q', 'R', 'S', 'T'), label_size = 16,
                 nrow = 1)
pg4

pg_all <- plot_grid(pg1, pg2, pg3, pg4, nrow = 4)
pg_all

## Fig. S5 - Nonlinear regression

ylim_down <- 0.5
ylim_up <- 9.75
ytick_down <- 0.5
ytick_up <- 10.0
ytick_jump <- 2.0

#mean = 1
list_plots1 <- vector('list', 5)
inf_idx1 = c(1,5,9,13,17)
variable_to_be_plotted<-c("ps1","ps2","ps3","ps4","ps5")
for (i in seq_along(list_plots1)) {
  list_plots1[[i]] <- ggplot(data_nonlinreg_mean1_samp, aes(x=SampSize, y=.data[[variable_to_be_plotted[i]]])) +
    # Add boxplots
    stat_summary(fun.data=bp.pctiles, geom="boxplot",  linewidth=0.5, width=0.5, 
                 color=yyellow, fill=yyellow, alpha=0.4) +
    # Add two more percentiles as dashes across the boxplot whiskers
    stat_summary(fun.y=add.percentiles, geom="point", pch="_", colour=yyellow,
                 size=6) +
    # Add theoretical exponent line
    geom_hline(yintercept = theoretical_exponent, linetype="dashed", color="red",
               linewidth=1) +
    # Add infinite sample size estimate line
    geom_hline(yintercept = metadata[inf_idx1[i],5], linetype="dashed", color="grey40",
               linewidth=0.8) +
    #labels
    labs(x="Sample size", y="Estimated exponent") +
    #ylims
    coord_cartesian(ylim=c(1.5,5.5)) +
    #yticks
    scale_y_continuous(breaks=seq(2.0,ytick_up,1.0))
}

pg1 <- plot_grid(list_plots1[[1]], list_plots1[[2]], list_plots1[[3]], list_plots1[[4]],
                 list_plots1[[5]], labels = c('A', 'B', 'C', 'D', 'E'), label_size = 16,
                 nrow = 1)
pg1

#mean = 5
list_plots2 <- vector('list', 5)
inf_idx2 = c(2,6,10,14,18)
variable_to_be_plotted<-c("ps1","ps2","ps3","ps4","ps5")
for (i in seq_along(list_plots2)) {
  list_plots2[[i]] <- ggplot(data_nonlinreg_mean5_samp, aes(x=SampSize, y=.data[[variable_to_be_plotted[i]]])) +
    # Add boxplots
    stat_summary(fun.data=bp.pctiles, geom="boxplot",  linewidth=0.5, width=0.5, 
                 color=yyellow, fill=yyellow, alpha=0.4) +
    # Add two more percentiles as dashes across the boxplot whiskers
    stat_summary(fun.y=add.percentiles, geom="point", pch="_", colour=yyellow,
                 size=6) +
    # Add theoretical exponent line
    geom_hline(yintercept = theoretical_exponent, linetype="dashed", color="red",
               linewidth=1) +
    # Add infinite sample size estimate line
    geom_hline(yintercept = metadata[inf_idx2[i],5], linetype="dashed", color="grey40",
               linewidth=0.8) +
    #labels
    labs(x="Sample size", y="Estimated exponent") +
    #ylims
    coord_cartesian(ylim=c(ylim_down,8.5)) + 
    #yticks
    scale_y_continuous(breaks=seq(1.0,ytick_up,ytick_jump))
}

pg2 <- plot_grid(list_plots2[[1]], list_plots2[[2]], list_plots2[[3]], list_plots2[[4]],
                 list_plots2[[5]], labels = c('F', 'G', 'H', 'I', 'J'), label_size = 16,
                 nrow = 1)
pg2

#mean = 10
list_plots3 <- vector('list', 5)
inf_idx3 = c(3,7,11,15,19)
variable_to_be_plotted<-c("ps1","ps2","ps3","ps4","ps5")
for (i in seq_along(list_plots3)) {
  list_plots3[[i]] <- ggplot(data_nonlinreg_mean8_samp, aes(x=SampSize, y=.data[[variable_to_be_plotted[i]]])) +
    # Add boxplots
    stat_summary(fun.data=bp.pctiles, geom="boxplot",  linewidth=0.5, width=0.5, 
                 color=yyellow, fill=yyellow, alpha=0.4) +
    # Add two more percentiles as dashes across the boxplot whiskers
    stat_summary(fun.y=add.percentiles, geom="point", pch="_", colour=yyellow,
                 size=6) +
    # Add theoretical exponent line
    geom_hline(yintercept = theoretical_exponent, linetype="dashed", color="red",
               linewidth=1) +
    # Add infinite sample size estimate line
    geom_hline(yintercept = metadata[inf_idx3[i],5], linetype="dashed", color="grey40",
               linewidth=0.8) +
    #labels
    labs(x="Sample size", y="Estimated exponent") +
    #ylims
    coord_cartesian(ylim=c(1.5,7.75)) + 
    #yticks
    scale_y_continuous(breaks=seq(2.0,ytick_up,ytick_jump))
}

pg3 <- plot_grid(list_plots3[[1]], list_plots3[[2]], list_plots3[[3]], list_plots3[[4]],
                 list_plots3[[5]], labels = c('K', 'L', 'M', 'N', 'O'), label_size = 16,
                 nrow = 1)
pg3

#mean = 25
list_plots4 <- vector('list', 5)
inf_idx4 = c(4,8,12,16,20)
variable_to_be_plotted<-c("ps1","ps2","ps3","ps4","ps5")
for (i in seq_along(list_plots4)) {
  list_plots4[[i]] <- ggplot(data_nonlinreg_mean12_samp, aes(x=SampSize, y=.data[[variable_to_be_plotted[i]]])) +
    # Add boxplots
    stat_summary(fun.data=bp.pctiles, geom="boxplot",  linewidth=0.5, width=0.5, 
                 color=yyellow, fill=yyellow, alpha=0.4) +
    # Add two more percentiles as dashes across the boxplot whiskers
    stat_summary(fun.y=add.percentiles, geom="point", pch="_", colour=yyellow,
                 size=6) +
    # Add theoretical exponent line
    geom_hline(yintercept = theoretical_exponent, linetype="dashed", color="red",
               linewidth=1) +
    # Add infinite sample size estimate line
    geom_hline(yintercept = metadata[inf_idx4[i],5], linetype="dashed", color="grey40",
               linewidth=0.8) +
    #labels
    labs(x="Sample size", y="Estimated exponent") +
    #ylims
    coord_cartesian(ylim=c(1.0,ylim_up)) + 
    #yticks
    scale_y_continuous(breaks=seq(1.0,ytick_up,ytick_jump))
}

pg4 <- plot_grid(list_plots4[[1]], list_plots4[[2]], list_plots4[[3]], list_plots4[[4]],
                 list_plots4[[5]], labels = c('P', 'Q', 'R', 'S', 'T'), label_size = 16,
                 nrow = 1)
pg4

pg_all <- plot_grid(pg1, pg2, pg3, pg4, nrow = 4)
pg_all
