# Generiranje podatkov za normalno porazdelitev
library(dplyr)


#============================================================================ CAS PRIHODA - NORMALNA PORAZDELITEV in STEVILO PRIHODOV - NORMALNA PORAZDELITEV  ==================================================================================
casi_prihodov_normalne = function(E, Var, n, shum) {
  dolzina_opravila = round(abs(rnorm(n,E, Var)))
  
  cas_prihoda = abs(rnorm(n,0, 0.5))*n  # tuki dam absolutno vrednost, je mar to dovoljeno?, potem dobimo nekaj drugega vendarle
  cas_prihoda = round(cas_prihoda)      # tuki dodajam se sum
  
  noise = round(rnorm(n,E, shum) - E) # lahko tudi pogledamo koliko je znasal posamezen sum
  
  dolzina_opravila_noise = noise + dolzina_opravila
  a = cbind(cas_prihoda,dolzina_opravila,dolzina_opravila, dolzina_opravila_noise)
  a = pmax(a,0)
  a = a[order(a[,1]),]
  return(a)
}
#==========================================================================================================================================================================

b = casi_prihodov_normalne(5,5,10, 1)

# to vrze matriko teh podatkov k jo rabis rezat
#=============================================================================== GENERIRANJE ===============================================================================
generiranje2 = function(k) {
  i = 1
  while (i < k) {
    a = casi_prihodov_normalne(5,5,10, 1)
    b = rbind(b, a)
    i = i +1
  }
  return(b)
}
#==============================================================================================================================================================
# k = stevilo zdruzitev tabel
c = generiranje2(1000)
