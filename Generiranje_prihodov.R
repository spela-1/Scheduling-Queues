# Generiranje podatkov
library(dplyr)

# Rabimo upostevati pogoj Var < E(1 - E) ! 

# rabim izracunat dejansko varianco in dejansko varianco "shuma"

#============================================================================ CAS PRIHODA - BETA PORAZDELITEV in STEVILO PRIHODOV - NORMALNA PORAZDELITEV  ==================================================================================
casi_prihodov = function(E, Var, n, velikost, shum) {
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
  #a = as_tibble(a)
  #a <- a %>% arrange((cas_prihoda))
  return(a)
}
#==========================================================================================================================================================================
#OPOMBA: dejanska pricakovana vrednost je E*velikost (varianca tudi ni pravilna, sam varianca ni linearna)

#KOMENTAR: as_tibble zna biti popolnoma nepotreben (in vse nadalje) , ce hocs to banano uredit po velikosti uporabs a = a[order(a[,1]),]

# n = stevilo prihodov
# velikost = zgornja meja "burst time"

#Komentar: upanje normalne je 0, in varianca je 0.5, doloceno po obcutku, potrebno dodatnega premisleka in komentarja


#Komentar: generira tudi dolzine prihodov 0, ta problem lahko odpravimo preprosto da dodamo +1
#==========================================================================================================================================================================

b = casi_prihodov(0.5,0.1,10,10, 0.1)

generiranje = function(k) {
  i = 1
  while (i < k) {
  a = casi_prihodov(0.5,0.1,10,10, 0.1)
  b = rbind(b, a)
  i = i +1
  }
  return(b)
}

# k = stevilo zdruzitev tabel
c = generiranje(1000)
# ce bos probavala drugacne podatke jih rabs pol se sprement notr v funkciji generiranje ( casi_prihodov(  ) ).
#==================================================================================================================================================


