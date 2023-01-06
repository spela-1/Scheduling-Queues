# Generiranje podatkov za beta porazdelitev
library(dplyr)

# Rabimo upostevati pogoj Var < E(1 - E) ! 

# rabim izracunat dejansko varianco in dejansko varianco "shuma"

#============================================================================ CAS PRIHODA - BETA PORAZDELITEV in STEVILO PRIHODOV - NORMALNA PORAZDELITEV  ==================================================================================
casi_prihodov_beta = function(E, Var, n, velikost, shum, rt) {
  alpha = E*(E*(1-E)/Var - 1)
  beta = (1 - E)*(E*(1-E)/Var - 1)
  dolzina_opravila = rbeta(n, alpha, beta)*velikost
  
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
# E = upanje/velikost
# Var = varianca....nelinearna
# n = stevilo prihodov
# velikost = zgornja meja "burst time"



#Komentar: Burst time je najmanj 10^-7
#Komentar: moti me da sum lahko poveca najin maksimalen burst time
#==========================================================================================================================================================================

b = casi_prihodov_beta(0.5,0.1,10,10, 0.01,0.25)

#========================================================================================================= raje bi s tem delal ker se mi zdi bolj pregledno
mylist <- list(a=0.5,b=0.5,c=0.5) # neznam ta seznam razsirit
a = lapply(mylist,casi_prihodov,Var=0.1, n= 10, velikost = 10, shum = 0.01, rt = 0.25) # vrze seznam teh podatkov
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
c = generiranje(1000)
#==============================================================================================================================================================
# osebna zelja: mogoce vizualno predstavitev vseh prihodov, pa tudi osebna radovednost kako tako stvar narest (ker to ni histogram), aha poglej v dn mislm da vem kaj hoces


