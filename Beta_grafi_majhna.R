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
  geom_point() + labs(title = "Povprečni čas čakanja opravil za Beta(12,12)", subtitle = "E = 0.5, Var = 0.01, Šum = 0.01" ,y = "Povprečno čakanje (k=100)", x = "Število prihodov") +
  scale_colour_manual(values=c('greenyellow','lightpink1',"lightpink3", "tomato3",'tomato4',"lightslateblue", "lightskyblue"))


Beta_manj = Beta_porazdelitev_n[1:3,]
x_manj = c(4, 8, 12 )
df_manj = cbind(x_manj ,Beta_manj)
Tabela_manj = df_manj %>% pivot_longer( !x_manj, names_to = "Algoritmi", values_to = "Povprecno cakanje")

cakanje_beta_majhna_4_12 = ggplot(Tabela_manj, aes(x=x_manj, y = `Povprecno cakanje`, col = Algoritmi)) +
  geom_line()+
  geom_point() + labs(title = "Povprečni čas čakanja opravil za Beta(12,12)", subtitle = "E = 0.5, Var = 0.01, Šum = 0.01" ,y = "Povprečno čakanje (k=100)", x = "Število prihodov") +
  scale_colour_manual(values=c('greenyellow','lightpink1',"lightpink3", "tomato3",'tomato4',"lightslateblue", "lightskyblue"))




Beta_vec = Beta_porazdelitev_n[10:12,]
x_vec = c(40, 44, 48 )
df_vec = cbind(x_vec ,Beta_vec)
Tabela_vec = df_vec %>% pivot_longer( !x_vec, names_to = "Algoritmi", values_to = "Povprecno cakanje")

cakanje_beta_majhna_40_48 = ggplot(Tabela_vec, aes(x=x_vec, y = `Povprecno cakanje`, col = Algoritmi)) +
  geom_line()+
  geom_point() + labs(title = "Povprečni čas čakanja opravil za Beta(12,12)", subtitle = "E = 0.5, Var = 0.01, Šum = 0.01" ,y = "Povprečno čakanje (k=100)", x = "Število prihodov") +
  scale_colour_manual(values=c('greenyellow','lightpink1',"lightpink3", "tomato3",'tomato4',"lightslateblue", "lightskyblue"))

cakanje_beta_majhna

ggarrange(cakanje_beta_majhna_4_12,cakanje_beta_majhna_40_48,
          ncol = 2, nrow = 1)

