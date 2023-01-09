# Generiranje podatkov za normalno porazdelitev
library(dplyr)

set.seed(0)
#============================================================================ CAS PRIHODA - NORMALNA PORAZDELITEV in STEVILO PRIHODOV - NORMALNA PORAZDELITEV  ==================================================================================
casi_prihodov_normalne = function(E, Var, n, shum, rt) {
  dolzina_opravila = abs(rnorm(n,E, Var))
  
  cas_prihoda = rexp(n, rt)  # tuki dam absolutno vrednost, je mar to dovoljeno?, potem dobimo nekaj drugega vendarle

  noise = rnorm(n,0, shum) # lahko tudi pogledamo koliko je znasal posamezen sum
  
  dolzina_opravila_noise = noise + dolzina_opravila
  a = cbind(cas_prihoda,dolzina_opravila, dolzina_opravila_noise)
  a = pmax(a,10^-7)
  return(a)
}


generiranje_normalna = function(E, Var, n, shum, rt, k) {
  i = 1
  b = c(0,0,0)
  while (i < k + 1) {
    a = casi_prihodov_normalne(E, Var, n, shum, rt)
    b = rbind(b, a)
    i = i +1
  }
  b = b[-c(1),]
  id = c(1:length(b[,1]))
  row.names(b) = id
  return(b)
}


#GENERIRANJE

#sprememba n=5, 10, 50, 100, 500, 1000 (pri var=5.01)

#spremeni k na 1000


n_5 = generiranje_normalna( 5, 5, 4, 0.01, 0.25, 100)
n_10 = generiranje_normalna( 5, 5, 8, 0.01, 0.25, 100)
n_50 = generiranje_normalna( 5, 5, 12, 0.01, 0.25, 100)
n_100 = generiranje_normalna(  5, 5, 16, 0.01, 0.25, 100)
n_500 = generiranje_normalna( 5, 5, 20, 0.01, 0.25, 100)
n_1000 = generiranje_normalna( 5, 5, 24, 0.01, 0.25, 100)

write.csv(n_5, "nn5.csv")
write.csv(n_10, "nn10.csv")
write.csv(n_50, "nn50.csv")
write.csv(n_100, "nn100.csv")
write.csv(n_500, "nn500.csv")
write.csv(n_1000, "nn1000.csv")

#sprememba šum = 0.1, 0.08, 0.06, 0.04, 0.02, 0.01, se cakanje

set.seed(0)
v_1 = generiranje_normalna(  5, 5, 24 , 2.5, 0.25, 100)
set.seed(0)
v_08 = generiranje_normalna(  5, 5,  24 , 2, 0.25, 100)
set.seed(0)
v_06 = generiranje_normalna(  5, 5, 24 , 1.5, 0.25, 100)
set.seed(0)
v_04 = generiranje_normalna(  5, 5, 24 , 1, 0.25, 100)
set.seed(0)
v_02 = generiranje_normalna( 5, 5, 24 , 0.5, 0.25, 100)
set.seed(0)
v_01 = generiranje_normalna( 5, 5, 24, 0.01, 0.25, 100)

write.csv(v_1, "nv1.csv")
write.csv(v_08, "nv08.csv")
write.csv(v_06, "nv06.csv")
write.csv(v_04, "nv04.csv")
write.csv(v_02, "nv02.csv")
write.csv(v_01, "nv01.csv")

# za n = 4, se cakanje
set.seed(0)
v_1 = generiranje_normalna(  5, 5, 4 , 2.5, 0.25, 100)
set.seed(0)
v_08 = generiranje_normalna(  5, 5,  4 , 2, 0.25, 100)
set.seed(0)
v_06 = generiranje_normalna(  5, 5, 4 , 1.5, 0.25, 100)
set.seed(0)
v_04 = generiranje_normalna(  5, 5, 4 , 1, 0.25, 100)
set.seed(0)
v_02 = generiranje_normalna( 5, 5, 4 , 0.5, 0.25, 100)
set.seed(0)
v_01 = generiranje_normalna( 5, 5, 4, 0.01, 0.25, 100)

write.csv(v_1, "n4v1.csv")
write.csv(v_08, "n4v08.csv")
write.csv(v_06, "n4v06.csv")
write.csv(v_04, "n4v04.csv")
write.csv(v_02, "n4v02.csv")
write.csv(v_01, "n4v01.csv")
















