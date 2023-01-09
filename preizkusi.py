import pandas
import pandas as pd
import numpy as np


#tabela = pd.read_csv("podatki.csv")
#print(tabela)

#tabel_v_list = tabela.values.tolist()
#print(tabel_v_list)
#razbitje = np.array_split(np.array(tabel_v_list), 1000)
#print(razbitje)

#tabela.drop('Unnamed: 0', inplace=True, axis=1)    stran da prvi stolpec
#tabela.shape


from algoritmi import FCFS
from algoritmi import SJF
from algoritmi import SRPT
from algoritmi import PSJF
from algoritmi import SPJF
from algoritmi import SPRPT
from algoritmi import PSPJF



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


def na_tabelah(tabele, niz_detoteke):
#funkcija na vsaki tabeli v seznamu tabel izvede funkcijo "izvedi_algoritem", 
#torej za vsako tabelo dobimo seznam povprečnega časa čakanja
    seznam = []
    i = 0
    for niz_tabele in tabele:
        tabela = pd.read_csv(niz_tabele, header=0)
        seznam.append(izvedi_algoritme(tabela))
        i += 1
    
    df = pd.DataFrame(seznam, columns=["FCFS", "SJF", "SRPT", "PSJF", "SPJF", "SPRPT", "PSPJF"])
    df.to_csv(niz_detoteke, index=False)




tabele_beta_n = ["bn5.csv", "bn10.csv", "bn50.csv", "bn100.csv", "bn500.csv", "bn1000.csv"]
tabele_beta_v = ["bv1.csv", "bv08.csv", "bv06.csv", "bv04.csv", "bv02.csv", "bv01.csv"]


#na_tabelah(tabele_beta_n, "beta_n.csv")
#na_tabelah(tabele_beta_v, "beta_v.csv")

tabele_norm_n = ["nn5.csv", "nn10.csv", "nn50.csv", "nn100.csv", "nn500.csv", "nn1000.csv"]
tabele_norm_v = ["nv1.csv", "nv08.csv", "nv06.csv", "nv04.csv", "nv02.csv", "nv01.csv"]

#na_tabelah(tabele_norm_n, "normalna_n.csv")
#na_tabelah(tabele_norm_v, "normalna_v.csv")


tabele_beta_n_majhna = ["mbn4.csv", "mbn8.csv", "mbn12.csv", "mbn16.csv", "mbn20.csv", "mbn24.csv", "mbn28.csv", "mbn32.csv", "mbn36.csv", "mbn40.csv","mbn44.csv", "mbn48.csv"]
na_tabelah(tabele_beta_n_majhna, "tabele_beta_n_majhna.csv")