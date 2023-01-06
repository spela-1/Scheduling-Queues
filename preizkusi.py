import pandas
import pandas as pd
import numpy as np


tabela = pd.read_csv("podatki.csv")
print(tabela)

#tabel_v_list = tabela.values.tolist()
#print(tabel_v_list)
#razbitje = np.array_split(np.array(tabel_v_list), 1000)
#print(razbitje)

#tabela.drop('Unnamed: 0', inplace=True, axis=1)    stran da prvi stolpec
#tabela.shape


from alg_prof import FCFS
from alg_prof import SJF
from alg_prof import SRPT
from alg_prof import PSJF
from alg_prof import SPJF
from alg_prof import SPRPT
from alg_prof import PSPJF



def izvedi_algoritme(tabela, stevilo_preizkusov=100):
    
    tabel_v_list = tabela.values.tolist()
    razbitje = np.array_split(np.array(tabel_v_list), stevilo_preizkusov)

    vsota_FCFS = 0
    vsota_SJF = 0
    vsota_SRPT = 0
    vsota_PSJF = 0
    vsota_SPJF = 0
    vsota_SPRPT = 0
    vsota_PSPJF = 0
    n=stevilo_preizkusov

    for i in razbitje:
        vsota_FCFS += FCFS(i)
        vsota_SJF += SJF(i)
        vsota_SRPT += SRPT(i)
        vsota_PSJF += PSJF(i)

        vsota_SPJF += SPJF(i) 
        vsota_SPRPT += SPRPT(i)
        vsota_PSPJF += PSPJF(i)

    return [vsota_FCFS/n, vsota_SJF/n, vsota_SRPT/n, vsota_PSJF/n, vsota_SPJF/n, vsota_SPRPT/n, vsota_PSPJF/n]

print(izvedi_algoritme(tabela, 100))

def na_tabelah(tabele):
#funkcija na vsaki tabeli v seznamu tabel izvede funkcijo "izvedi_algoritem", 
#torej za vsako tabelo dobimo seznam povprečnega časa čakanja
    seznam = []
    for niz_tabele in tabele:
        tabela = pd.read_csv(niz_tabele)
        seznam.append(izvedi_algoritme(tabela))

    return seznam