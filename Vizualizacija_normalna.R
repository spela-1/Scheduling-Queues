# Vizualizacija normalna
#install.packages("ggpubr")

library(ggplot2)
library(tidyr)
library(ggpubr)

#set.seed(0)
#n_24 = casi_prihodov_normalne( 5, 5, 24, 0.01, 0.25)
#n_24 = as_tibble(n_24)
#write.csv(n_24, "n_24.csv")
n_24 = read.csv("n_24.csv")

#set.seed(0)
#n_4 = casi_prihodov_normalne( 5, 5, 4, 0.01, 0.25)
#write.csv(n_4, "n_4.csv")
n_4 = read.csv("n_4.csv")


Normalna_porazdelitev_n = read.csv("normalna_n.csv")

Normalna = Normalna_porazdelitev_n[,0:4]

x = c(4, 8, 12 , 16 , 20 , 24)

z = 3.559897 # povprecni cas cakanja

df = cbind(x ,Normalna)

Tabela = df %>% pivot_longer( !x, names_to = "Algoritmi", values_to = "Povprecno cakanje")

#df = cbind(x, Beta_porazdelitev_n)

#=========================================================================================== RISANJE POVP. CASA CAKANJA ==================PREVERI ALPHA IN BETA NUJNO===========================
cakanje_norm = ggplot(Tabela, aes(x=x, y = `Povprecno cakanje`, col = Algoritmi)) +
  geom_line()+
  geom_point() + labs(title = "Povprečni čas čakanja opravil", subtitle = "E = 3.559897, Var = 17.32713, k =100 " ,y = "Povprečno čakanje", x = "Število prihodov") +
  ylim(0, 1010) +
  scale_colour_manual(values=c('greenyellow','lightpink1',"tomato3", "lightskyblue"))
#===================================================================================================================================================================




#================================================================================== RISANJE PRIHODOV =================================
prihodi_norm = ggplot(n_24, aes(x=cas_prihoda, y=dolzina_opravila)) + 
  geom_point(size=0.5, color = "violetred4") + 
  geom_segment(aes(x=cas_prihoda, 
                   xend=cas_prihoda, 
                   y=0, 
                   yend=dolzina_opravila), colour = "yellowgreen") +
  labs(y = "Dolžina opravila", x = "Čas prihoda") +
  geom_line(aes(y=z), colour="grey",linetype="dashed") +
  labs(subtitle="n = 24, lambda = 0.25") +
  xlim(0, 12) + ylim(0,19)
#=========================================================================

# Tabela za napoved

Normalna_predictions = Normalna_porazdelitev_n[,5:7]
df_predictions = cbind(x ,Normalna_predictions)
Tabela_predictions = df_predictions %>% pivot_longer( !x, names_to = "Algoritmi", values_to = "Povprecno cakanje")


#====================================================================================== RISANJE POVP. CASA CAKANJA NAPOVEDI ================================================================
cakanje_norm_predictions = ggplot(Tabela_predictions, aes(x=x, y = `Povprecno cakanje`, col = Algoritmi)) +
  geom_line()+
  geom_point() + labs(title = "Povprečni čas čakanja napovedi", subtitle = "Šum ~ N(0,0.01)" ,y = "Povprečno čakanje z napovedmi", x = "Število prihodov") +
  ylim(0, 1010) +
  scale_colour_manual(values=c('lightpink3',"tomato4", "lightslateblue"))
#==================================================================================================================================================================

Normalna_porazdelitev_v = read.csv("normalna4_v.csv")
Normalna_v = Normalna_porazdelitev_v[,5:7]
Var = c(2.5, 2, 1.5 , 1 , 0.5 , 0.01)
df_var = cbind(Var ,Normalna_v)
Tabela_var = df_var %>% pivot_longer( !Var, names_to = "Algoritmi", values_to = "Povprecno cakanje")

#========================================================= RISANJE POVP. CAKANJA GLEDE NA VARIANCO ==============================
# RABIL POPRAVIT PODATKE
cakanje_varianca_n = ggplot(Tabela_var, aes(x=Var, y = `Povprecno cakanje`, col = Algoritmi)) +
  geom_line()+
  geom_point() + labs(title = "V odvisnosti od variance", subtitle = "n = 4" ,y = "Povprečno čakanje", x = "Varianca šuma") +
  geom_hline(yintercept=23.67987,linetype="dashed", color = "greenyellow") +
  annotate("text", x=0, y=23.97987, label="FCFS", size = 2.7, color = "green3") +
  scale_colour_manual(values=c('lightpink3',"tomato4", "lightslateblue")) +
  geom_hline(yintercept=14.37206, linetype="dashed", color = "lightpink1") +
  annotate("text", x=0, y=14.67206, label="PSJF", size = 2.7, color = "lightpink1") +
  geom_hline(yintercept=19.75076, linetype="dashed", color = "tomato3") +
  annotate("text", x=0, y=20, label="SJF", size = 2.7, color = "tomato3") +
  geom_hline(yintercept=12.55601, linetype="dashed", color = "lightskyblue") +
  annotate("text", x=0, y=12.85601, label="SRPT", size = 2.7, color = "lightskyblue")
#================================================================================================================================================================================

#================================================================================== RISANJE PRIHODOV =================================
prihodi_norm_n4 = ggplot(n_4, aes(x=cas_prihoda, y=dolzina_opravila)) + 
  geom_point(size=0.5, color = "violetred4") + 
  geom_segment(aes(x=cas_prihoda, 
                   xend=cas_prihoda, 
                   y=0, 
                   yend=dolzina_opravila), colour = "yellowgreen") +
  labs(y = "Dolžina opravila", x = "Čas prihoda") +
  geom_line(aes(y=3.559897), colour="grey",linetype="dashed") +
  labs(title="Prihodi opravil / dolžina opravil", 
       subtitle="E = 3.559897, Var = 17.32713, n = 4, lambda = 0.25") +
  xlim(0, 12) + ylim(0,19)
#=========================================================================

Normalna_porazdelitev_v_24 = read.csv("normalna_v.csv")
Normalna_v_24 = Normalna_porazdelitev_v_24[,5:7]
Var = c(2.5, 2, 1.5 , 1 , 0.5 , 0.01)
df_var_24 = cbind(Var ,Normalna_v_24)
Tabela_var_24 = df_var_24 %>% pivot_longer( !Var, names_to = "Algoritmi", values_to = "Povprecno cakanje")
#========================================================= RISANJE POVP. CAKANJA GLEDE NA VARIANCO ==============================

cakanje_varianca_n_24 = ggplot(Tabela_var_24, aes(x=Var, y = `Povprecno cakanje`, col = Algoritmi)) +
  geom_line()+
  geom_point() + labs(subtitle = "n = 24 , FCFS = 1553.008" ,y = "Povprečno čakanje", x = "Varianca šuma") +
  scale_colour_manual(values=c('lightpink3',"tomato4", "lightslateblue")) +
  geom_hline(yintercept=934.6914, linetype="dashed", color = "lightpink1") +
  geom_hline(yintercept=978.2421, linetype="dashed", color = "tomato3") +
  geom_hline(yintercept=930.8688, linetype="dashed", color = "lightskyblue")
#================================================================================================================================================================================

# CE KDO ZNA PREUREDIT VRSTNI RED LEGENDE BI BLO KUL , JZ GREM JOKAT
# lahko zamenjam samo na grse fonte (r nima lepih fontov ki podpirajo sumnike)

ggarrange(cakanje_norm,cakanje_norm_predictions, cakanje_varianca_n ,prihodi_norm_n4,cakanje_varianca_n_24,prihodi_norm,
          ncol = 2, nrow = 3)

