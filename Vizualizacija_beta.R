# Vizualizacija
# dal sem k = 1000 (v PYTHON), dogajajo se cudne stvari, verjetno ni problem v prvotnih algoritmih
#install.packages("ggpubr")

library(ggplot2)
library(tidyr)
library(ggpubr)

b_24 = read.csv("b_24.csv")
#set.seed(0)
#b_24 = casi_prihodov_beta( 0.5, 0.01, 24, 10 , 0.01, 0.25)
#b_24 = as_tibble(b_24)
#write.csv(b_24, "b_24.csv")


Beta_porazdelitev_n = read.csv("beta_n.csv")

Beta = Beta_porazdelitev_n[,0:4]

x = c(4, 8, 12 , 16 , 20 , 24)

z = 5 # povprecni cas cakanja

df = cbind(x ,Beta)

Tabela = df %>% pivot_longer( !x, names_to = "Algoritmi", values_to = "Povprecno cakanje")

#df = cbind(x, Beta_porazdelitev_n)

#=========================================================================================== RISANJE POVP. CASA CAKANJA ==================PREVERI ALPHA IN BETA NUJNO===========================
cakanje_beta = ggplot(Tabela, aes(x=x, y = `Povprecno cakanje`, col = Algoritmi)) +
  geom_line()+
  geom_point() + labs(title = "Povprečni čas čakanja opravil",subtitle = "E = 5, Var = 1, k = 100" ,y = "Povprečno čakanje", x = "Število prihodov") +
  ylim(0, 1300) +
  scale_colour_manual(values=c('greenyellow','lightpink1',"tomato3", "lightskyblue"))
#===================================================================================================================================================================




#================================================================================== RISANJE PRIHODOV =================================
prihodi_beta = ggplot(b_24, aes(x=cas_prihoda, y=dolzina_opravila)) + 
  geom_point(size=0.5, color = "violetred4") + 
  geom_segment(aes(x=cas_prihoda, 
                   xend=cas_prihoda, 
                   y=0, 
                   yend=dolzina_opravila), colour = "yellowgreen") +
  labs(y = "Dolžina opravila", x = "Čas prihoda") +
  geom_line(aes(y=z), colour="grey",linetype="dashed") +
  labs(subtitle="n = 24, lambda = 0.25") +
  ylim(0,8) +
  xlim(0,12)
#=========================================================================

# Tabela za napoved

Beta_predictions = Beta_porazdelitev_n[,5:7]
df_predictions = cbind(x ,Beta_predictions)
Tabela_predictions = df_predictions %>% pivot_longer( !x, names_to = "Algoritmi", values_to = "Povprecno cakanje")


#====================================================================================== RISANJE POVP. CASA CAKANJA NAPOVEDI ================================================================
cakanje_beta_predictions = ggplot(Tabela_predictions, aes(x=x, y = `Povprecno cakanje`, col = Algoritmi)) +
  geom_line()+
  geom_point() + labs(title = "Povprečni čas čakanja napovedi", subtitle = "Šum ~ N(0,0.01)" ,y = "Povprečno čakanje napovedi", x = "Število prihodov") +
  ylim(0, 1300) +
  scale_colour_manual(values=c('lightpink3',"tomato4", "lightslateblue"))
#==================================================================================================================================================================

Beta_porazdelitev_v = read.csv("beta4_v.csv")
Beta_v = Beta_porazdelitev_v[,5:7]
Var = c(2.5, 2, 1.5 , 1 , 0.5 , 0.01)
df_var = cbind(Var ,Beta_v)
Tabela_var = df_var %>% pivot_longer( !Var, names_to = "Algoritmi", values_to = "Povprecno cakanje")

#========================================================= RISANJE POVP. CAKANJA GLEDE NA VARIANCO ==============================
# RABIL POPRAVIT PODATKE
cakanje_varianca = ggplot(Tabela_var, aes(x=Var, y = `Povprecno cakanje`, col = Algoritmi)) +
  geom_line()+
  geom_point() + labs(title = "V odvisnosti od variance", subtitle = "n = 4" ,y = "Povprečno čakanje", x = "Varianca šuma") +
  geom_hline(yintercept=17.20937,linetype="dashed", color = "greenyellow") +
  annotate("text", x=0, y=17.6, label="FCFS", size = 2.7, color = "green3") +
  scale_colour_manual(values=c('lightpink3',"tomato4", "lightslateblue")) +
  geom_hline(yintercept=17.67441, linetype="dashed", color = "lightpink1") +
  annotate("text", x=0, y=17.97441, label="PSJF", size = 2.7, color = "lightpink1") +
  geom_hline(yintercept=16.24942, linetype="dashed", color = "tomato3") +
  annotate("text", x=0, y=16.59, label="SJF", size = 2.7, color = "tomato3") +
  geom_hline(yintercept=14.91326, linetype="dashed", color = "lightskyblue") +
  annotate("text", x=0, y=15.2, label="SRPT", size = 2.7, color = "lightskyblue")
#================================================================================================================================================================================
# lahko zamenjam samo na grse fonte (r nima lepih fontov ki podpirajo sumnike)
Beta_porazdelitev_v_24 = read.csv("beta_v.csv")
Beta_v_24 = Beta_porazdelitev_v_24[,5:7]
Var = c(2.5, 2, 1.5 , 1 , 0.5 , 0.01)
df_var_24 = cbind(Var ,Beta_v_24)
Tabela_var_24 = df_var_24 %>% pivot_longer( !Var, names_to = "Algoritmi", values_to = "Povprecno cakanje")
#========================================================= RISANJE POVP. CAKANJA GLEDE NA VARIANCO 24 ==============================
# RABIL POPRAVIT PODATKE
cakanje_varianca_24 = ggplot(Tabela_var_24, aes(x=Var, y = `Povprecno cakanje`, col = Algoritmi)) +
  geom_line()+
  geom_point() + labs(subtitle = "n = 24, FCFS = 1291.643" ,y = "Povprečno čakanje", x = "Varianca šuma") +
  scale_colour_manual(values=c('lightpink3',"tomato4", "lightslateblue")) +
  geom_hline(yintercept=1144.338, linetype="dashed", color = "lightpink1") +
  geom_hline(yintercept=1147.34, linetype="dashed", color = "tomato3") +
  geom_hline(yintercept=1137.292, linetype="dashed", color = "lightskyblue")
#================================================================================================================================================================================
#set.seed(0)
#b_4 = casi_prihodov_beta( 0.5, 0.01, 4, 10 , 0.01, 0.25)
#b_4 = as_tibble(b_4)
#write.csv(b_4, "b_4.csv")
b_4 = read.csv("b_4.csv")
#================================================================================== RISANJE PRIHODOV 4 =================================
prihodi_beta_4 = ggplot(b_4, aes(x=cas_prihoda, y=dolzina_opravila)) + 
  geom_point(size=0.5, color = "violetred4") + 
  geom_segment(aes(x=cas_prihoda, 
                   xend=cas_prihoda, 
                   y=0, 
                   yend=dolzina_opravila), colour = "yellowgreen") +
  labs(y = "Dolžina opravila", x = "Čas prihoda") +
  geom_line(aes(y=z), colour="grey",linetype="dashed") +
  labs(title="Prihodi opravil / dolžina opravil", 
       subtitle="E = 5, Var = 1, n = 4, lambda = 0.25") +
  ylim(0,8) +
  xlim(0,12)
#=========================================================================



ggarrange(cakanje_beta,cakanje_beta_predictions,cakanje_varianca ,prihodi_beta_4,cakanje_varianca_24,prihodi_beta,
          ncol = 2, nrow = 3)


# CE KDO ZNA PREUREDIT VRSTNI RED LEGENDE BI BLO KUL , JZ GREM JOKAT

