# Generiranje podatkov za beta porazdelitev
library(dplyr)

# Rabimo upostevati pogoj Var < E(1 - E) ! 

# rabim izracunat dejansko varianco in dejansko varianco "shuma"

#============================================================================ CAS PRIHODA - BETA PORAZDELITEV in STEVILO PRIHODOV - NORMALNA PORAZDELITEV  ==================================================================================
casi_prihodov_beta = function(E, Var, n, velikost, shum) {
  alpha = E*(E*(1-E)/Var - 1)
  beta = (1 - E)*(E*(1-E)/Var - 1)
  dolzina_opravila = rbeta(n, alpha, beta)*velikost
  dolzina_opravila = round(dolzina_opravila)
  cas_prihoda = abs(rnorm(n,0, 0.5))*n
  cas_prihoda = round(cas_prihoda)      # tuki dodajam se sum
  
  alpha1 = E*(E*(1-E)/shum - 1)
  beta1 = (1 - E)*(E*(1-E)/shum - 1)
  noise = rbeta(n, alpha1, beta1)*velikost - E*velikost
  noise = round(noise)
  dolzina_opravila_noise = noise + dolzina_opravila
  a = cbind(cas_prihoda,dolzina_opravila,dolzina_opravila, dolzina_opravila_noise)
  a = pmax(a,0)
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


#Komentar: upanje normalne je 0, in varianca je 0.5, doloceno po obcutku, potrebno dodatnega premisleka in komentarja


#Komentar: generira tudi dolzine prihodov 0, ta problem lahko odpravimo preprosto da dodamo +1
#Komentar: moti me da sum lahko poveca najin maksimalen burst time
#==========================================================================================================================================================================

b = casi_prihodov_beta(0.5,0.1,10,10, 0.01)

#========================================================================================================= raje bi s tem delal ker se mi zdi bolj pregledno
mylist <- list(a=0.5,b=0.5,c=0.5) # neznam ta seznam razsirit
a = lapply(mylist,casi_prihodov,Var=0.1, n= 10, velikost = 10, shum = 0.01) # vrze seznam teh podatkov
#========================================================================================================= vendar neznam



# to vrze matriko teh podatkov k jo rabis rezat
#=============================================================================== GENERIRANJE ===============================================================================
generiranje = function(k) {
  i = 1
  while (i < k) {
  a = casi_prihodov_beta(0.5,0.1,10,10, 0.01)
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


