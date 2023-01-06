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
  a = a[order(a[,1]),]
  return(a)
}
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



#Komentar: Burst time je najmanj 10^-7
#Komentar: moti me da sum lahko poveca najin maksimalen burst time
#================================================================================= PRIPRAVLJENI PODATKI: Var= 1.01 , n =========================================================================================

n_5 = casi_prihodov_beta( 0.5, 0.01, 5, 10 , 0.01, 0.25)

n_10 = casi_prihodov_beta( 0.5, 0.01, 10, 10 , 0.01, 0.25)

n_50 = casi_prihodov_beta( 0.5, 0.01, 50, 10 , 0.01, 0.25)

n_100 = casi_prihodov_beta( 0.5, 0.01, 100, 10 , 0.01, 0.25)

n_500 = casi_prihodov_beta( 0.5, 0.01, 500, 10 , 0.01, 0.25)

n_1000 = casi_prihodov_beta( 0.5, 0.01, 1000, 10 , 0.01, 0.25)

#=================================================================================================================================================================

write.csv(n_5, "n5.csv")

write.csv(n_10, "n10.csv")

write.csv(n_50, "n50.csv")

write.csv(n_100, "n100.csv")

write.csv(n_500, "n500.csv")

write.csv(n_1000, "n1000.csv")

#================================================================================= PRIPRAVLJENI PODATKI: Var= 1.02 , m ======================================================================

m_5 = casi_prihodov_beta( 0.5, 0.01, 5, 10 , 0.02, 0.25)

m_10 = casi_prihodov_beta( 0.5, 0.01, 10, 10 , 0.02, 0.25)

m_50 = casi_prihodov_beta( 0.5, 0.01, 50, 10 , 0.02, 0.25)

m_100 = casi_prihodov_beta( 0.5, 0.01, 100, 10 , 0.02, 0.25)

m_500 = casi_prihodov_beta( 0.5, 0.01, 500, 10 , 0.02, 0.25)

m_1000 = casi_prihodov_beta( 0.5, 0.01, 1000, 10 , 0.02, 0.25)

#=================================================================================================================================================================

write.csv(m_5, "m5.csv")

write.csv(m_10, "m10.csv")

write.csv(m_50, "m50.csv")

write.csv(m_100, "m100.csv")

write.csv(m_500, "m500.csv")

write.csv(m_1000, "m1000.csv")

#================================================================================= PRIPRAVLJENI PODATKI: Var= 1.04 , k ======================================================================

k_5 = casi_prihodov_beta( 0.5, 0.01, 5, 10 , 0.04, 0.25)

k_10 = casi_prihodov_beta( 0.5, 0.01, 10, 10 , 0.04, 0.25)

k_50 = casi_prihodov_beta( 0.5, 0.01, 50, 10 , 0.04, 0.25)

k_100 = casi_prihodov_beta( 0.5, 0.01, 100, 10 , 0.04, 0.25)

k_500 = casi_prihodov_beta( 0.5, 0.01, 500, 10 , 0.04, 0.25)

k_1000 = casi_prihodov_beta( 0.5, 0.01, 1000, 10 , 0.04, 0.25)

#=================================================================================================================================================================

write.csv(k_5, "k5.csv")

write.csv(k_10, "k10.csv")

write.csv(k_50, "k50.csv")

write.csv(k_100, "k100.csv")

write.csv(k_500, "k500.csv")

write.csv(k_1000, "k1000.csv")

#================================================================================= PRIPRAVLJENI PODATKI: Var= 1.06 , j ======================================================================

j_5 = casi_prihodov_beta( 0.5, 0.01, 5, 10 , 0.06, 0.25)

j_10 = casi_prihodov_beta( 0.5, 0.01, 10, 10 , 0.06, 0.25)

j_50 = casi_prihodov_beta( 0.5, 0.01, 50, 10 , 0.06, 0.25)

j_100 = casi_prihodov_beta( 0.5, 0.01, 100, 10 , 0.06, 0.25)

j_500 = casi_prihodov_beta( 0.5, 0.01, 500, 10 , 0.06, 0.25)

j_1000 = casi_prihodov_beta( 0.5, 0.01, 1000, 10 , 0.06, 0.25)

#=================================================================================================================================================================

write.csv(j_5, "j5.csv")

write.csv(j_10, "j10.csv")

write.csv(j_50, "j50.csv")

write.csv(j_100, "j100.csv")

write.csv(j_500, "j500.csv")

write.csv(j_1000, "j1000.csv")

#================================================================================= PRIPRAVLJENI PODATKI: Var= 1.08 , t ======================================================================

t_5 = casi_prihodov_beta( 0.5, 0.01, 5, 10 , 0.08, 0.25)

t_10 = casi_prihodov_beta( 0.5, 0.01, 10, 10 , 0.08, 0.25)

t_50 = casi_prihodov_beta( 0.5, 0.01, 50, 10 , 0.08, 0.25)

t_100 = casi_prihodov_beta( 0.5, 0.01, 100, 10 , 0.08, 0.25)

t_500 = casi_prihodov_beta( 0.5, 0.01, 500, 10 , 0.08, 0.25)

t_1000 = casi_prihodov_beta( 0.5, 0.01, 1000, 10 , 0.08, 0.25)

#=================================================================================================================================================================

write.csv(t_5, "t5.csv")

write.csv(t_10, "t10.csv")

write.csv(t_50, "t50.csv")

write.csv(t_100, "t100.csv")

write.csv(t_500, "t500.csv")

write.csv(t_1000, "t1000.csv")


#================================================================================= PRIPRAVLJENI PODATKI: Var= 1.1 , l ======================================================================

l_5 = casi_prihodov_beta( 0.5, 0.01, 5, 10 , 0.1, 0.25)

l_10 = casi_prihodov_beta( 0.5, 0.01, 10, 10 , 0.1, 0.25)

l_50 = casi_prihodov_beta( 0.5, 0.01, 50, 10 , 0.1, 0.25)

l_100 = casi_prihodov_beta( 0.5, 0.01, 100, 10 , 0.1, 0.25)

l_500 = casi_prihodov_beta( 0.5, 0.01, 500, 10 , 0.1, 0.25)

l_1000 = casi_prihodov_beta( 0.5, 0.01, 1000, 10 , 0.1, 0.25)

#=================================================================================================================================================================

write.csv(l_5, "l5.csv")

write.csv(l_10, "l10.csv")

write.csv(l_50, "l50.csv")

write.csv(l_100, "l100.csv")

write.csv(l_500, "l500.csv")

write.csv(l_1000, "l1000.csv")

#======================================================================= TO SPODAJ LAHKO ZANEMARIS ===============================================================
#.................................................................................................................................................................












#========================================================================================================= raje bi s tem delal ker se mi zdi bolj pregledno
mylist <- list(a=0.5,b=0.5,c=0.5) # neznam ta seznam razsirit
a = lapply(mylist,casi_prihodov,Var=0.1, n= 10, velikost = 10, shum = 0.01) # vrze seznam teh podatkov
#========================================================================================================= vendar neznam



# to vrze matriko teh podatkov k jo rabis rezat
#=============================================================================== GENERIRANJE ===============================================================================
generiranje = function(k) {
  i = 1
  while (i < k) {
  a = casi_prihodov_beta(0.5,0.1,10,10, 0.01,0.25)
  b = rbind(b, a)
  i = i +1
  }
  return(b)
}
#==============================================================================================================================================================
# k = stevilo zdruzitev tabel
c = generiranje(10)
c2 = generiranje(15)
c3 = generiranje(1000)
#==============================================================================================================================================================
# osebna zelja: mogoce vizualno predstavitev vseh prihodov, pa tudi osebna radovednost kako tako stvar narest (ker to ni histogram), aha poglej v dn mislm da vem kaj hoces


