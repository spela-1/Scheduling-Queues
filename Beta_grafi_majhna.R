# prikaz od 4 do 48, vseh algoritmov z majhno varianco

library(ggplot2)
library(tidyr)
library(ggpubr)


Beta_porazdelitev_n = read.csv("tabele_beta_n_majhna.csv")

Beta = Beta_porazdelitev_n

x = c(4, 8, 12 , 16 , 20 , 24,28,32,36,40,44,48)

z = 0.5 # povprecni cas cakanja

df = cbind(x ,Beta)

Tabela = df %>% pivot_longer( !x, names_to = "Algoritmi", values_to = "Povprecno cakanje")

cakanje_beta_majhna = ggplot(Tabela, aes(x=x, y = `Povprecno cakanje`, col = Algoritmi)) +
  geom_line()+
  geom_point() + labs(title = "Povprečni čas čakanja opravil za Beta(12,12)", subtitle = "E = 0.5, Var = 0.01, Šum = 0.01" ,y = "Povprečno čakanje (k=100)", x = "Število prihodov")
