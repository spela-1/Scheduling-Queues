# Generiranje podatkov za beta porazdelitev
library(dplyr)

set.seed(0)
# Rabimo upostevati pogoj Var < E(1 - E) ! 

# Var(Z + k*X) = Var(Z) + kˇ2 * Var(X), varianca napovedi = 1.01
# x = beta, upanje = 1/2 in var = 1
# Z = normalna , upanje = 0 in var = 0.01
# k = burst_time = 10

#============================================================================ CAS PRIHODA - BETA PORAZDELITEV in STEVILO PRIHODOV - NORMALNA PORAZDELITEV  ==================================================================================
casi_prihodov_beta = function(E, Var, n, burst_time, shum, rt) {
  alpha = E*(E*(1-E)/Var - 1)
  beta = (1 - E)*(E*(1-E)/Var - 1)
  dolzina_opravila = rbeta(n, alpha, beta)*burst_time
  
  cas_prihoda = rexp(n, rt)     # tuki dodajam se sum
  
  noise = rnorm( n, 0, shum)
  dolzina_opravila_noise = noise + dolzina_opravila
  a = cbind(cas_prihoda , dolzina_opravila, dolzina_opravila_noise)
  a = pmax(a,10^-7)
  
  return(a)
}

generiranje_beta = function(E, Var, n, burst_time, shum, rt, k) {
  i = 1
  b = c(0,0,0,0)
  while (i < k) {
    a = casi_prihodov_beta(E, Var, n, burst_time, shum, rt)
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

write.csv(n_5, "bn5.csv")
write.csv(n_10, "bn10.csv")
write.csv(n_50, "bn50.csv")
write.csv(n_100, "bn100.csv")
write.csv(n_500, "bn500.csv")
write.csv(n_1000, "bn1000.csv")

#sprememba šum = 0.1, 0.08, 0.06, 0.04, 0.02, 0.01

v_1 = generiranje_beta( 0.5, 0.01, 10, 10 , 0.1, 0.25, 100)
v_08 = generiranje_beta( 0.5, 0.01, 10, 10 , 0.08, 0.25, 100)
v_06 = generiranje_beta( 0.5, 0.01, 10, 10 , 0.06, 0.25, 100)
v_04 = generiranje_beta( 0.5, 0.01, 10, 10 , 0.04, 0.25, 100)
v_02 = generiranje_beta( 0.5, 0.01, 10, 10 , 0.02, 0.25, 100)
v_01 = generiranje_beta( 0.5, 0.01, 10, 10 , 0.01, 0.25, 100)

write.csv(v_1, "bv1.csv")
write.csv(v_08, "bv08.csv")
write.csv(v_06, "bv06.csv")
write.csv(v_04, "bv04.csv")
write.csv(v_02, "bv02.csv")
write.csv(v_01, "bv01.csv")
#==========================================================================================================================================================================
#OPOMBA: dejanska pricakovana vrednost je E*velikost (varianca tudi ni pravilna, sam varianca ni linearna)

#KOMENTAR: as_tibble zna biti popolnoma nepotreben (in vse nadalje) , ce hocs to banano uredit po velikosti uporabs a = a[order(a[,1]),]
# funkcijski parametri:
# E = upanje/burst_time
# Var = varianca....nelinearna
# n = stevilo prihodov
# burst_time = zgornja meja "burst time"
# shum =...
# rt = "pogostost" prihoda 
# k = stevilo generiranih tabel


#Komentar: Burst time je najmanj 10^-7
#Komentar: moti me da sum lahko poveca najin maksimalen burst time
#==========================================================================================================================



