# Code to reproduce Figs S6-S9

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
# "Figs. S6-S9 - Binomial Sampling Regression"
#setwd("...")
#wdirectory_name <- ...
wdirectory_name <- "//wsl.localhost/Ubuntu/home/andrew/Projects/Indistinguishability-Repo/"
setwd(wdirectory_name)

# Figs. S6-S7 - N=5,j=4

## Import data
N = 5
j = 4
theoretical_exponent = N - j + 1

## Construct 'metadata' dataframe with filenames, parameter set number, mean number, etc.
ps_number_vec = c(1, 2, 3, 4, 5)
mean_number_vec = c(1, 5, 10, 25)
filename_list <- list()
mean_number_list <- list()
ps_number_list <- list()
for (ps_number in ps_number_vec) {
  for (mean_number in mean_number_vec) {
    xlsxfilename = paste("SyntheticData_Finite_BinSamp_N",as.character(N),"_j",as.character(j),"_ps",as.character(ps_number),"_mean",as.character(mean_number),".xlsx", sep="")
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

# Construct new data set

#datasets 
#assign binomial sampling probabilities
x_binprobs <- rep(c(0.2,0.4,0.6,0.8,1.0),each=5000)
x_binprobs <- as.factor(x_binprobs)
data_linreg_mean1_binprob <- data.frame(BinProb=x_binprobs)
data_linreg_mean5_binprob <- data.frame(BinProb=x_binprobs)
data_linreg_mean10_binprob <- data.frame(BinProb=x_binprobs)
data_linreg_mean25_binprob <- data.frame(BinProb=x_binprobs)

data_nonlinreg_mean1_binprob <- data.frame(BinProb=x_binprobs)
data_nonlinreg_mean5_binprob <- data.frame(BinProb=x_binprobs)
data_nonlinreg_mean10_binprob <- data.frame(BinProb=x_binprobs)
data_nonlinreg_mean25_binprob <- data.frame(BinProb=x_binprobs)

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
  
  #read in data (binomial sampling probabilities, slope and exponent estimates)
  data <- read_excel(filename, range = "R2:T25002")
  BinSamps <- data[1]
  Slopes <- data[2]
  Exponents <- data[3]
  
  #find index of row in metadata with corresponding filename
  row_idx <- as.numeric(rownames(metadata[metadata$filename==xlsxfilename,]))
  ps_number <- metadata[row_idx,1]
  mean_number <- metadata[row_idx,2]
  
  #Binomial sampling probabilities datasets first - Bin probs are first column (each column is a different parameter set)
  #assign the data to the correct dataset
  if (mean_number==1) {
    #column name (from parameter set number)
    colname_ <- paste("ps",ps_number,sep="")
    #assign data to data frame
    data_linreg_mean1_binprob[, colname_] <- Slopes
    data_nonlinreg_mean1_binprob[, colname_] <- Exponents
  } else if (mean_number==5) {
    #column name (from parameter set number)
    colname_ <- paste("ps",ps_number,sep="")
    #assign data to data frame
    data_linreg_mean5_binprob[, colname_] <- Slopes
    data_nonlinreg_mean5_binprob[, colname_] <- Exponents
  } else if (mean_number==10) {
    #column name (from parameter set number)
    colname_ <- paste("ps",ps_number,sep="")
    #assign data to data frame
    data_linreg_mean10_binprob[, colname_] <- Slopes
    data_nonlinreg_mean10_binprob[, colname_] <- Exponents
  } else if (mean_number==25) {
    #column name (from parameter set number)
    colname_ <- paste("ps",ps_number,sep="")
    #assign data to data frame
    data_linreg_mean25_binprob[, colname_] <- Slopes
    data_nonlinreg_mean25_binprob[, colname_] <- Exponents
  }
  
}
metadata$slope_inf <- unlist(slope_inf_list)
metadata$exponent_inf <- unlist(exponent_inf_list)


# Plot boxplots on same figure

#big y axis = mean numbers
#big x axis = parameter set numbers

## Fig. S6 - Linear regression

ylim_down <- 0.7
ylim_up <- 2.0
ytick_down <- 0.6
ytick_up <- 2.0
ytick_jump <- 0.2

#mean = 1
list_plots1 <- vector('list', 5)
inf_idx1 = c(1,5,9,13,17)
variable_to_be_plotted<-c("ps1","ps2","ps3","ps4","ps5")
for (i in seq_along(list_plots1)) {
  list_plots1[[i]] <- ggplot(data_linreg_mean1_binprob[1:25000,], aes(x=BinProb, y=.data[[variable_to_be_plotted[i]]])) +
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
    labs(x="Sampling probability", y="Estimated exponent") +
    #ylims
    coord_cartesian(ylim=c(ylim_down,ylim_up)) +
    #yticks
    scale_y_continuous(breaks=seq(0.8,ytick_up,0.4))
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
  list_plots2[[i]] <- ggplot(data_linreg_mean5_binprob[1:25000,], aes(x=BinProb, y=.data[[variable_to_be_plotted[i]]])) +
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
    labs(x="Sampling probability", y="Estimated exponent") +
    #ylims
    coord_cartesian(ylim=c(1.0,ylim_up)) + 
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
  list_plots3[[i]] <- ggplot(data_linreg_mean10_binprob[1:25000,], aes(x=BinProb, y=.data[[variable_to_be_plotted[i]]])) +
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
    labs(x="Sampling probability", y="Estimated exponent") +
    #ylims
    coord_cartesian(ylim=c(1.2,ylim_up)) + 
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
  list_plots4[[i]] <- ggplot(data_linreg_mean25_binprob[1:25000,], aes(x=BinProb, y=.data[[variable_to_be_plotted[i]]])) +
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
    labs(x="Sampling probability", y="Estimated exponent") +
    #ylims
    coord_cartesian(ylim=c(1.6,ylim_up)) + 
    #yticks
    scale_y_continuous(breaks=seq(ytick_down,ytick_up,ytick_jump))
}

pg4 <- plot_grid(list_plots4[[1]], list_plots4[[2]], list_plots4[[3]], list_plots4[[4]],
                 list_plots4[[5]], labels = c('P', 'Q', 'R', 'S', 'T'), label_size = 16,
                 nrow = 1)
pg4

pg_all <- plot_grid(pg1, pg2, pg3, pg4, nrow = 4)
pg_all

## Fig. S7 - Nonlinear regression

ylim_down <- 0.6
ylim_up <- 2.0
ytick_down <- 0.8
ytick_up <- 2.0
ytick_jump <- 0.4

#mean = 1
list_plots1 <- vector('list', 5)
inf_idx1 = c(1,5,9,13,17)
variable_to_be_plotted<-c("ps1","ps2","ps3","ps4","ps5")
for (i in seq_along(list_plots1)) {
  list_plots1[[i]] <- ggplot(data_nonlinreg_mean1_binprob[1:25000,], aes(x=BinProb, y=.data[[variable_to_be_plotted[i]]])) +
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
    labs(x="Sampling probability", y="Estimated exponent") +
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
  list_plots2[[i]] <- ggplot(data_nonlinreg_mean5_binprob[1:25000,], aes(x=BinProb, y=.data[[variable_to_be_plotted[i]]])) +
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
    labs(x="Sampling probability", y="Estimated exponent") +
    #ylims
    coord_cartesian(ylim=c(0.8,ylim_up)) + 
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
  list_plots3[[i]] <- ggplot(data_nonlinreg_mean10_binprob[1:25000,], aes(x=BinProb, y=.data[[variable_to_be_plotted[i]]])) +
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
    labs(x="Sampling probability", y="Estimated exponent") +
    #ylims
    coord_cartesian(ylim=c(1.05,ylim_up)) + 
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
  list_plots4[[i]] <- ggplot(data_nonlinreg_mean25_binprob[1:25000,], aes(x=BinProb, y=.data[[variable_to_be_plotted[i]]])) +
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
    labs(x="Sampling probability", y="Estimated exponent") +
    #ylims
    coord_cartesian(ylim=c(1.5,ylim_up)) + 
    #yticks
    scale_y_continuous(breaks=seq(ytick_down,ytick_up,0.2))
}

pg4 <- plot_grid(list_plots4[[1]], list_plots4[[2]], list_plots4[[3]], list_plots4[[4]],
                 list_plots4[[5]], labels = c('P', 'Q', 'R', 'S', 'T'), label_size = 16,
                 nrow = 1)
pg4

pg_all <- plot_grid(pg1, pg2, pg3, pg4, nrow = 4)
pg_all

# Figs. S8-S9 - N=5,j=1

## Import data
N = 5
j = 1
theoretical_exponent = N - j + 1

## Construct 'metadata' dataframe with filenames, parameter set number, mean number, etc.
ps_number_vec = c(1, 2, 3, 4, 5)
mean_number_vec = c(1, 5, 8, 12)
filename_list <- list()
mean_number_list <- list()
ps_number_list <- list()
for (ps_number in ps_number_vec) {
  for (mean_number in mean_number_vec) {
    xlsxfilename = paste("SyntheticData_Finite_BinSamp_N",as.character(N),"_j",as.character(j),"_ps",as.character(ps_number),"_mean",as.character(mean_number),".xlsx", sep="")
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


# Construct new data set

#datasets 
#assign binomial sampling probabilities
x_binprobs <- rep(c(0.2,0.4,0.6,0.8,1.0),each=5000)
x_binprobs <- as.factor(x_binprobs)
data_linreg_mean1_binprob <- data.frame(BinProb=x_binprobs)
data_linreg_mean5_binprob <- data.frame(BinProb=x_binprobs)
data_linreg_mean8_binprob <- data.frame(BinProb=x_binprobs)
data_linreg_mean12_binprob <- data.frame(BinProb=x_binprobs)

data_nonlinreg_mean1_binprob <- data.frame(BinProb=x_binprobs)
data_nonlinreg_mean5_binprob <- data.frame(BinProb=x_binprobs)
data_nonlinreg_mean8_binprob <- data.frame(BinProb=x_binprobs)
data_nonlinreg_mean12_binprob <- data.frame(BinProb=x_binprobs)

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
  
  #read in data (binomial sampling probabilities, slope and exponent estimates)
  data <- read_excel(filename, range = "R2:T25002")
  BinSamps <- data[1]
  Slopes <- data[2]
  Exponents <- data[3]
  
  #find index of row in metadata with corresponding filename
  row_idx <- as.numeric(rownames(metadata[metadata$filename==xlsxfilename,]))
  ps_number <- metadata[row_idx,1]
  mean_number <- metadata[row_idx,2]
  
  #Binomial sampling probabilities datasets first - Bin probs are first column (each column is a different parameter set)
  #assign the data to the correct dataset
  if (mean_number==1) {
    #column name (from parameter set number)
    colname_ <- paste("ps",ps_number,sep="")
    #assign data to data frame
    data_linreg_mean1_binprob[, colname_] <- Slopes
    data_nonlinreg_mean1_binprob[, colname_] <- Exponents
  } else if (mean_number==5) {
    #column name (from parameter set number)
    colname_ <- paste("ps",ps_number,sep="")
    #assign data to data frame
    data_linreg_mean5_binprob[, colname_] <- Slopes
    data_nonlinreg_mean5_binprob[, colname_] <- Exponents
  } else if (mean_number==8) {
    #column name (from parameter set number)
    colname_ <- paste("ps",ps_number,sep="")
    #assign data to data frame
    data_linreg_mean8_binprob[, colname_] <- Slopes
    data_nonlinreg_mean8_binprob[, colname_] <- Exponents
  } else if (mean_number==12) {
    #column name (from parameter set number)
    colname_ <- paste("ps",ps_number,sep="")
    #assign data to data frame
    data_linreg_mean12_binprob[, colname_] <- Slopes
    data_nonlinreg_mean12_binprob[, colname_] <- Exponents
  }
  
}
metadata$slope_inf <- unlist(slope_inf_list)
metadata$exponent_inf <- unlist(exponent_inf_list)


# Plot boxplots on same figure

#big y axis = mean numbers
#big x axis = parameter set numbers

## Fig. S8 - Linear regression

ylim_down <- 2.0
ylim_up <- 5.5
ytick_down <- 2.0
ytick_up <- 5.5
ytick_jump <- 1.0

#mean = 1
list_plots1 <- vector('list', 5)
inf_idx1 = c(1,5,9,13,17)
variable_to_be_plotted<-c("ps1","ps2","ps3","ps4","ps5")
for (i in seq_along(list_plots1)) {
  list_plots1[[i]] <- ggplot(data_linreg_mean1_binprob[1:25000,], aes(x=BinProb, y=.data[[variable_to_be_plotted[i]]])) +
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
    labs(x="Sampling probability", y="Estimated exponent") +
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
  list_plots2[[i]] <- ggplot(data_linreg_mean5_binprob[1:25000,], aes(x=BinProb, y=.data[[variable_to_be_plotted[i]]])) +
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
    labs(x="Sampling probability", y="Estimated exponent") +
    #ylims
    coord_cartesian(ylim=c(ylim_down,ylim_up)) + 
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
  list_plots3[[i]] <- ggplot(data_linreg_mean8_binprob[1:25000,], aes(x=BinProb, y=.data[[variable_to_be_plotted[i]]])) +
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
    labs(x="Sampling probability", y="Estimated exponent") +
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
  list_plots4[[i]] <- ggplot(data_linreg_mean12_binprob[1:25000,], aes(x=BinProb, y=.data[[variable_to_be_plotted[i]]])) +
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
    labs(x="Sampling probability", y="Estimated exponent") +
    #ylims
    coord_cartesian(ylim=c(ylim_down,ylim_up)) + 
    #yticks
    scale_y_continuous(breaks=seq(ytick_down,ytick_up,ytick_jump))
}

pg4 <- plot_grid(list_plots4[[1]], list_plots4[[2]], list_plots4[[3]], list_plots4[[4]],
                 list_plots4[[5]], labels = c('P', 'Q', 'R', 'S', 'T'), label_size = 16,
                 nrow = 1)
pg4

pg_all <- plot_grid(pg1, pg2, pg3, pg4, nrow = 4)
pg_all

## Fig. S9 - Nonlinear regression

ylim_down <- 1.8
ylim_up <- 5.7
ytick_down <- 2.0
ytick_up <- 5.0
ytick_jump <- 1.0

#mean = 1
list_plots1 <- vector('list', 5)
inf_idx1 = c(1,5,9,13,17)
variable_to_be_plotted<-c("ps1","ps2","ps3","ps4","ps5")
for (i in seq_along(list_plots1)) {
  list_plots1[[i]] <- ggplot(data_nonlinreg_mean1_binprob[1:25000,], aes(x=BinProb, y=.data[[variable_to_be_plotted[i]]])) +
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
    labs(x="Sampling probability", y="Estimated exponent") +
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
  list_plots2[[i]] <- ggplot(data_nonlinreg_mean5_binprob[1:25000,], aes(x=BinProb, y=.data[[variable_to_be_plotted[i]]])) +
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
    labs(x="Sampling probability", y="Estimated exponent") +
    #ylims
    coord_cartesian(ylim=c(ylim_down,ylim_up)) + 
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
  list_plots3[[i]] <- ggplot(data_nonlinreg_mean8_binprob[1:25000,], aes(x=BinProb, y=.data[[variable_to_be_plotted[i]]])) +
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
    labs(x="Sampling probability", y="Estimated exponent") +
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
  list_plots4[[i]] <- ggplot(data_nonlinreg_mean12_binprob[1:25000,], aes(x=BinProb, y=.data[[variable_to_be_plotted[i]]])) +
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
    labs(x="Sampling probability", y="Estimated exponent") +
    #ylims
    coord_cartesian(ylim=c(ylim_down,ylim_up)) + 
    #yticks
    scale_y_continuous(breaks=seq(ytick_down,ytick_up,ytick_jump))
}

pg4 <- plot_grid(list_plots4[[1]], list_plots4[[2]], list_plots4[[3]], list_plots4[[4]],
                 list_plots4[[5]], labels = c('P', 'Q', 'R', 'S', 'T'), label_size = 16,
                 nrow = 1)
pg4

pg_all <- plot_grid(pg1, pg2, pg3, pg4, nrow = 4)
pg_all
