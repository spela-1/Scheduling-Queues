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
  a = a[order(a[,1]),]
  return(a)
}
#==========================================================================================================================================================================
mylist <- as.list(replicate(100, 5))

#====================================================PODATKI: Var = 5.01 , n ==============================================================================================

n_5 = lapply(mylist,casi_prihodov_normalne,Var=5, n= 5, shum = 0.01, rt = 0.25)

n_10 = lapply(mylist,casi_prihodov_normalne,Var=5, n= 10, shum = 0.01, rt = 0.25)

n_50 = lapply(mylist,casi_prihodov_normalne,Var=5, n= 50, shum = 0.01, rt = 0.25)

n_100 = lapply(mylist,casi_prihodov_normalne,Var=5, n= 100, shum = 0.01, rt = 0.25)

n_500 = lapply(mylist,casi_prihodov_normalne,Var=5, n= 500, shum = 0.01, rt = 0.25)

n_1000 = lapply(mylist,casi_prihodov_normalne,Var=5, n= 1000, shum = 0.01, rt = 0.25)

#=================================================================================================================================================================

write.csv(n_5, "n5.csv")

write.csv(n_10, "n10.csv")

write.csv(n_50, "n50.csv")

write.csv(n_100, "n100.csv")

write.csv(n_500, "n500.csv")

write.csv(n_1000, "n1000.csv")

#====================================================PODATKI: Var = 5.02 , m ==================================================================

m_5 = lapply(mylist,casi_prihodov_normalne,Var=5, n= 5, shum = 0.02, rt = 0.25)

m_10 = lapply(mylist,casi_prihodov_normalne,Var=5, n= 10, shum = 0.02, rt = 0.25)

m_50 = lapply(mylist,casi_prihodov_normalne,Var=5, n= 50, shum = 0.02, rt = 0.25)

m_100 = lapply(mylist,casi_prihodov_normalne,Var=5, n= 100, shum = 0.02, rt = 0.25)

m_500 = lapply(mylist,casi_prihodov_normalne,Var=5, n= 500, shum = 0.02, rt = 0.25)

m_1000 = lapply(mylist,casi_prihodov_normalne,Var=5, n= 1000, shum = 0.02, rt = 0.25)

#=================================================================================================================================================================

write.csv(m_5, "m5.csv")

write.csv(m_10, "m10.csv")

write.csv(m_50, "m50.csv")

write.csv(m_100, "m100.csv")

write.csv(m_500, "m500.csv")

write.csv(m_1000, "m1000.csv")

#====================================================PODATKI: Var = 5.04 , k ==================================================================

k_5 = lapply(mylist,casi_prihodov_normalne,Var=5, n= 5, shum = 0.04, rt = 0.25)

k_10 = lapply(mylist,casi_prihodov_normalne,Var=5, n= 10, shum = 0.04, rt = 0.25)

k_50 = lapply(mylist,casi_prihodov_normalne,Var=5, n= 50, shum = 0.04, rt = 0.25)

k_100 = lapply(mylist,casi_prihodov_normalne,Var=5, n= 100, shum = 0.04, rt = 0.25)

k_500 = lapply(mylist,casi_prihodov_normalne,Var=5, n= 500, shum = 0.04, rt = 0.25)

k_1000 = lapply(mylist,casi_prihodov_normalne,Var=5, n= 1000, shum = 0.04, rt = 0.25)

#=================================================================================================================================================================

write.csv(k_5, "k5.csv")

write.csv(k_10, "k10.csv")

write.csv(k_50, "k50.csv")

write.csv(k_100, "k100.csv")

write.csv(k_500, "k500.csv")

write.csv(k_1000, "k1000.csv")

#====================================================PODATKI: Var = 5.06 , j ==================================================================

j_5 = lapply(mylist,casi_prihodov_normalne,Var=5, n= 5, shum = 0.06, rt = 0.25)

j_10 = lapply(mylist,casi_prihodov_normalne,Var=5, n= 10, shum = 0.06, rt = 0.25)

j_50 = lapply(mylist,casi_prihodov_normalne,Var=5, n= 50, shum = 0.06, rt = 0.25)

j_100 = lapply(mylist,casi_prihodov_normalne,Var=5, n= 100, shum = 0.06, rt = 0.25)

j_500 = lapply(mylist,casi_prihodov_normalne,Var=5, n= 500, shum = 0.06, rt = 0.25)

j_1000 = lapply(mylist,casi_prihodov_normalne,Var=5, n= 1000, shum = 0.06, rt = 0.25)

#=================================================================================================================================================================

write.csv(j_5, "j5.csv")

write.csv(j_10, "j10.csv")

write.csv(j_50, "j50.csv")

write.csv(j_100, "j100.csv")

write.csv(j_500, "j500.csv")

write.csv(j_1000, "j1000.csv")

#====================================================PODATKI: Var = 5.08 , t ==================================================================

t_5 = lapply(mylist,casi_prihodov_normalne,Var=5, n= 5, shum = 0.08, rt = 0.25)

t_10 = lapply(mylist,casi_prihodov_normalne,Var=5, n= 10, shum = 0.08, rt = 0.25)

t_50 = lapply(mylist,casi_prihodov_normalne,Var=5, n= 50, shum = 0.08, rt = 0.25)

t_100 = lapply(mylist,casi_prihodov_normalne,Var=5, n= 100, shum = 0.08, rt = 0.25)

t_500 = lapply(mylist,casi_prihodov_normalne,Var=5, n= 500, shum = 0.08, rt = 0.25)

t_1000 = lapply(mylist,casi_prihodov_normalne,Var=5, n= 1000, shum = 0.08, rt = 0.25)

#=================================================================================================================================================================

write.csv(t_5, "t5.csv")

write.csv(t_10, "t10.csv")

write.csv(t_50, "t50.csv")

write.csv(t_100, "t100.csv")

write.csv(t_500, "t500.csv")

write.csv(t_1000, "t1000.csv")

#====================================================PODATKI: Var = 5.1 , l ==================================================================

l_5 = lapply(mylist,casi_prihodov_normalne,Var=5, n= 5, shum = 0.1, rt = 0.25)

l_10 = lapply(mylist,casi_prihodov_normalne,Var=5, n= 10, shum = 0.1, rt = 0.25)

l_50 = lapply(mylist,casi_prihodov_normalne,Var=5, n= 50, shum = 0.1, rt = 0.25)

l_100 = lapply(mylist,casi_prihodov_normalne,Var=5, n= 100, shum = 0.1, rt = 0.25)

l_500 = lapply(mylist,casi_prihodov_normalne,Var=5, n= 500, shum = 0.1, rt = 0.25)

l_1000 = lapply(mylist,casi_prihodov_normalne,Var=5, n= 1000, shum = 0.1, rt = 0.25)

#=================================================================================================================================================================

write.csv(l_5, "l5.csv")

write.csv(l_10, "l10.csv")

write.csv(l_50, "l50.csv")

write.csv(l_100, "l100.csv")

write.csv(l_500, "l500.csv")

write.csv(l_1000, "l1000.csv")


#======================================================================= TO SPODAJ LAHKO ZANEMARIS ===============================================================
#.................................................................................................................................................................

























b = casi_prihodov_normalne(5,5,10, 1, 0.25)

# to vrze matriko teh podatkov k jo rabis rezat
#=============================================================================== GENERIRANJE ===============================================================================
generiranje2 = function(k) {
  i = 1
  while (i < k) {
    a = casi_prihodov_normalne(5,5,10, 1, 0.25)
    b = rbind(b, a)
    i = i +1
  }
  return(b)
}
#==============================================================================================================================================================
# k = stevilo zdruzitev tabel
c = generiranje2(1000)
