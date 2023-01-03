import pandas
import pandas as pd
import numpy as np


tabela = pd.read_csv("podatki.csv")
print(tabela)

#tabela.drop('Unnamed: 0', inplace=True, axis=1)    stran da prvi stolpec
#tabela.shape


from algoritmi import FCFS
from algoritmi import SJF
from algoritmi import SRPT
from algoritmi import PSJF
from algoritmi import SPJF
from algoritmi import SPRPT
from algoritmi import PSPJF



def izvedi_alg(tabela, stevilo_preizkusov=10):
    
    tabel_v_list = tabela.values.tolist()
    razbitje = np.array_split(np.array(tabel_v_list), stevilo_preizkusov)

    vsota = 0
    n = len(razbitje)
    for i in razbitje:
        vsota += FCFS(i)
    return (vsota/n)

print(izvedi_alg(tabela))

