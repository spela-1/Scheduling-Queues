# Generiranje podatkov za normalno porazdelitev
library(dplyr)


#============================================================================ CAS PRIHODA - NORMALNA PORAZDELITEV in STEVILO PRIHODOV - NORMALNA PORAZDELITEV  ==================================================================================
casi_prihodov_normalne = function(E, Var, n, shum, rt) {
  dolzina_opravila = abs(rnorm(n,E, Var))
  
  cas_prihoda = rexp(n, rt)  # tuki dam absolutno vrednost, je mar to dovoljeno?, potem dobimo nekaj drugega vendarle

  noise = rnorm(n,0, shum) # lahko tudi pogledamo koliko je znasal posamezen sum
  
  dolzina_opravila_noise = noise + dolzina_opravila
  a = cbind(cas_prihoda,dolzina_opravila,dolzina_opravila, dolzina_opravila_noise)
  a = pmax(a,10^-7)
  return(a)
}


generiranje_normalna = function(E, Var, n, burst_time, shum, rt, k) {
  i = 1
  b = c(0,0,0,0)
  while (i < k) {
    a = casi_prihodov_normalne(E, Var, n, burst_time, shum, rt)
    b = rbind(b, a)
    i = i +1
  }
  b = b[-c(1),]
  id = c(1:length(b[,1]))
  row.names(b) = id
  return(b)
}


#GENERIRANJE

#sprememba n=5, 10, 50, 100, 500, 1000 (pri var=0.01)

n_5 = generiranje_beta( 0.5, 0.01, 5, 10 , 0.01, 0.25, 100)
n_10 = generiranje_beta( 0.5, 0.01, 10, 10 , 0.01, 0.25, 100)
n_50 = generiranje_beta( 0.5, 0.01, 50, 10 , 0.01, 0.25, 100)
n_100 = generiranje_beta( 0.5, 0.01, 100, 10 , 0.01, 0.25, 100)
n_500 = generiranje_beta( 0.5, 0.01, 500, 10 , 0.01, 0.25, 100)
n_1000 = generiranje_beta( 0.5, 0.01, 1000, 10 , 0.01, 0.25, 100)

write.csv(n_5, "nn5.csv")
write.csv(n_10, "nn10.csv")
write.csv(n_50, "nn50.csv")
write.csv(n_100, "nn100.csv")
write.csv(n_500, "nn500.csv")
write.csv(n_1000, "nn1000.csv")

#sprememba šum = 0.1, 0.08, 0.06, 0.04, 0.02, 0.01

v_1 = generiranje_beta( 0.5, 0.01, 10, 10 , 0.1, 0.25, 100)
v_08 = generiranje_beta( 0.5, 0.01, 10, 10 , 0.08, 0.25, 100)
v_06 = generiranje_beta( 0.5, 0.01, 10, 10 , 0.06, 0.25, 100)
v_04 = generiranje_beta( 0.5, 0.01, 10, 10 , 0.04, 0.25, 100)
v_02 = generiranje_beta( 0.5, 0.01, 10, 10 , 0.02, 0.25, 100)
v_01 = generiranje_beta( 0.5, 0.01, 10, 10 , 0.01, 0.25, 100)

write.csv(v_1, "nv1.csv")
write.csv(v_08, "nv08.csv")
write.csv(v_06, "nv06.csv")
write.csv(v_04, "nv04.csv")
write.csv(v_02, "nv02.csv")
write.csv(v_01, "nv01.csv")

















