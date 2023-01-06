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
