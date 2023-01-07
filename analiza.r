#analiza
library(tidyverse)
library(ggplot2)
library(dplyr)

beta_n <- t(read.csv("beta_n.csv"))
beta_v <- t(read.csv("beta_v.csv"))
norm_n <- t(read.csv("normalna_n.csv"))
norm_v <- t(read.csv("normalna_v.csv"))

