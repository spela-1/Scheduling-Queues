# Vizualizacija
# dal sem k = 1000 (v PYTHON), dogajajo se cudne stvari, verjetno ni problem v prvotnih algoritmih

library(ggplot2)
library(tidyr)

Beta_porazdelitev_n = read.csv("beta_n.csv")

Beta = Beta_porazdelitev_n[,0:4]

x = c(4, 8, 12 , 16 , 20 , 24)

df = cbind(x ,Beta)

Tabela = df %>% pivot_longer( !x, names_to = "Algoritem", values_to = "Povprecno_cakanje")

#df = cbind(x, Beta_porazdelitev_n)

cakanje = ggplot(Tabela, aes(x=x, y = Povprecno_cakanje, col = Algoritem)) +
  geom_line()+
  geom_point()

n_5 = casi_prihodov_normalne( 5, 5, 24, 0.01, 0.25)
n_10 = as_tibble(n_5)


ggplot(n_10, aes(x=cas_prihoda, y=dolzina_opravila)) + 
  geom_point(size=3) + 
  geom_segment(aes(x=cas_prihoda, 
                   xend=cas_prihoda, 
                   y=0, 
                   yend=dolzina_opravila)) + 
  labs(title="Prihodi opravil", 
       subtitle="M")
  theme(axis.text.x = element_text(angle=65, vjust=0.6))  # ta vrstica pazi
