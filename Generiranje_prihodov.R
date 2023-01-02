# Generiranje podatkov
library(dplyr)



# Rabimo upostevati pogoj Var < E(1 - E) ! 

#Komentar: prof je omenil da lahko dolocimo min in max beta porazdelitve, to lahko naredimo pri enakomerno zvezni porazdelitvi, pri beta te opcije ni

#============================================================================ CAS PRIHODA - BETA PORAZDELITEV in STEVILO PRIHODOV - NORMALNA PORAZDELITEV  ==================================================================================
casi_prihodov = function(E, Var, n, velikost) {
  alpha = E*(E*(1-E)/Var - 1)
  beta = (1 - E)*(E*(1-E)/Var - 1)
  b = rbeta(n, alpha, beta)*velikost
  b = round(b)
  p = abs(rnorm(n,0, 0.5))*n
  p = round(p)
  a = bind_cols(p,b)
  colnames(a) = c("cas_prihoda", "dolzina_opravila")
  a <- a %>% arrange((cas_prihoda))
  return(a)
}
#==========================================================================================================================================================================

#Komentar: upanje normalne je 0, in varianca je 0.5, doloceno po obcutku, potrebno dodatnega premisleka in komentarja


a = casi_prihodov(0.5,0.1,100,10)

summary(a)


# generira tudi dolzine prihodov 0
