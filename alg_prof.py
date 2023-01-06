from dataclasses import dataclass, field
from heapq import heappop, heappush


class Opravilo():

    def __init__(self, id, arrival, length, predicted):
        self.id = id
        self.arrival = arrival
        self.length = length
        self.predicted = predicted

#@dataclass(order=True)
#class Opravilo:
#    id: int=field(compare=False)
#    arrival: float
#    length: float
#    predicted: float=field(default=None)

    def __post_init__(self): 
        if self.predicted is None: # če nimamo napovedi, naj bo enaka dolžini
            self.predicted = self.length
        assert self.arrival >= 0 and self.length > 0 and self.predicted > 0 # preverimo, da so podatki smiselni




#First Come First Serve    
def FCFS(seznam):
# vzame množico opravil in izračuna povprečen čas čakanja
# opravila je list opravil, opravilo = (id, arrival,length, length, predicted)
    opravila = (Opravilo(*t) for t in seznam)# zadnje, navidezno opravilo
    opravila = sorted(opravila, key=lambda item: item.arrival)
    cakanje = 0
    t=0
    dogodki = []

    for opravilo in opravila:

        if t < opravilo.arrival:
            t = opravilo.arrival

        cas_cakanja = t-opravilo.arrival
        cakanje += cas_cakanja
        t += opravilo.length  
        dogodki.append((t, opravilo, cas_cakanja)) # zabeležimo dokončanje opravila

    return cakanje


# Shortest Job First
def SJF(seznam):
    opravila = (Opravilo(*t) for t in seznam)# zadnje, navidezno opravilo
    opravila = sorted(opravila, key=lambda item: item.arrival) + [Opravilo(None, float('inf'), float('inf'),float('inf') )] # zadnje, navidezno opravilo
    dogodki = []
    vrsta = []
    t = 0
    cakanje = 0
    for naslednje in opravila:
        while vrsta: # ponavljamo, dokler vrsta ni prazna

            cas, opravilo = vrsta[0] # pogledamo opravilo na začetku vrste

            prekinitev = naslednje.arrival - t # čas do prihoda naslednjega opravila
            if prekinitev <= 0:
                break # če je naslednje opravilo že prišlo, prekinemo zanko, da ga dodamo v vrsto


            preostanek = cas - prekinitev # preostali čas trajanja po prihodu naslednjega opravila

            # naslednje opravilo bo prišlo pred koncem izvajanja trenutnega ima manjši predvideni čas trajanja
            if preostanek > 0:
                vrsta[0] = (preostanek, opravilo) # popravimo preostali čas
                t = naslednje.arrival # premaknemo se na čas prekinitve
                break

            dogodki.append((t, opravilo, cas, 0)) # zabeležimo dokončanje opravila
            heappop(vrsta) # odstranimo opravilo iz vrste
            t += cas # premaknemo se na čas konca izvajanja
            cakanje += t - opravilo.length - opravilo.arrival # zabeležimo čakanje

        else: # zanke nismo prekinili z break
            t = naslednje.arrival # premaknemo se naprej do časa prihoda naslednjega opravila

        heappush(vrsta, (naslednje.length, naslednje)) # dodamo opravilo z začetno prioriteto enako dolžini 

    return cakanje # bolj smiselno je, če vračata skupno čakanje, saj to ni odvisno le od števila opravil


#Shortest remaining procesing time
def SRPT(seznam):
    opravila = (Opravilo(*t) for t in seznam)# zadnje, navidezno opravilo
    opravila = sorted(opravila, key=lambda item: item.arrival) + [Opravilo(None, float('inf'), float('inf'), float('inf'))] # zadnje, navidezno opravilo
    dogodki = []
    vrsta = []
    t = 0
    cakanje = 0
    for naslednje in opravila:
        while vrsta: # ponavljamo, dokler vrsta ni prazna

            prekinitev = naslednje.arrival - t # čas do prihoda naslednjega opravila
            if prekinitev <= 0:
                break # če je naslednje opravilo že prišlo, prekinemo zanko, da ga dodamo v vrsto

            cas, opravilo = vrsta[0] # pogledamo opravilo na začetku vrste
            preostanek = cas - prekinitev # preostali čas trajanja po prihodu naslednjega opravila

            # naslednje opravilo bo prišlo pred koncem izvajanja trenutnega ima manjši predvideni čas trajanja
            if preostanek > 0 and preostanek > naslednje.length:            
                dogodki.append((t, opravilo, prekinitev, preostanek)) # zabeležimo izvajanje do prekinitve
                vrsta[0] = (preostanek, opravilo) # popravimo preostali čas
                t = naslednje.arrival # premaknemo se na čas prekinitve
                break # prekinemo zanko, da dodamo naslednje opravilo v vrsto

            else: # izvajanje se bo končalo
                dogodki.append((t, opravilo, cas, 0)) # zabeležimo dokončanje opravila
                heappop(vrsta) # odstranimo opravilo iz vrste
                t += cas # premaknemo se na čas konca izvajanja
                cakanje += t - opravilo.length - opravilo.arrival # zabeležimo čakanje

        else: # zanke nismo prekinili z break
            t = naslednje.arrival # premaknemo se naprej do časa prihoda naslednjega opravila

        heappush(vrsta, (naslednje.length, naslednje)) # dodamo opravilo z začetno prioriteto enako dolžini 
    return cakanje # bolj smiselno je, če vračata skupno čakanje, saj to ni odvisno le od števila opravil




#Preemptive shortest job first
def PSJF(seznam):
    opravila = (Opravilo(*t) for t in seznam)# zadnje, navidezno opravilo
    opravila = sorted(opravila, key=lambda item: item.arrival) + [Opravilo(None, float('inf'), float('inf'), float('inf'))] # zadnje, navidezno opravilo
    dogodki = []
    vrsta = []
    t = 0
    cakanje = 0
    for naslednje in opravila:
        while vrsta: # ponavljamo, dokler vrsta ni prazna

            prekinitev = naslednje.arrival - t # čas do prihoda naslednjega opravila
            if prekinitev <= 0:
                break # če je naslednje opravilo že prišlo, prekinemo zanko, da ga dodamo v vrsto

            cas, opravilo = vrsta[0] # pogledamo opravilo na začetku vrste
            preostanek = cas - prekinitev # preostali čas trajanja po prihodu naslednjega opravila

            # naslednje opravilo bo prišlo pred koncem izvajanja trenutnega ima manjši predvideni čas trajanja
            if preostanek > 0 and opravilo.length > naslednje.length:
                dogodki.append((t, opravilo, prekinitev, preostanek)) # zabeležimo izvajanje do prekinitve
                vrsta[0] = (preostanek, opravilo) # popravimo preostali čas
                t = naslednje.arrival # premaknemo se na čas prekinitve
                break # prekinemo zanko, da dodamo naslednje opravilo v vrsto

            else: # izvajanje se bo končalo
                dogodki.append((t, opravilo, cas, 0)) # zabeležimo dokončanje opravila
                heappop(vrsta) # odstranimo opravilo iz vrste
                t += cas # premaknemo se na čas konca izvajanja
                cakanje += t - opravilo.length - opravilo.arrival # zabeležimo čakanje

        else: # zanke nismo prekinili z break
            t = naslednje.arrival # premaknemo se naprej do časa prihoda naslednjega opravila

        heappush(vrsta, (naslednje.length, naslednje)) # dodamo opravilo z začetno prioriteto enako dolžini 
    return cakanje # bolj smiselno je, če vračata skupno čakanje, saj to ni odvisno le od števila opravil


#PREDICTED

#Shortest Predicted Job First
def SPJF(seznam):
    opravila = (Opravilo(*t) for t in seznam)# zadnje, navidezno opravilo
    opravila = sorted(opravila, key=lambda item: item.arrival) + [Opravilo(None, float('inf'), float('inf'), float('inf'))] # zadnje, navidezno opravilo
    dogodki = []
    vrsta = []
    t = 0
    cakanje = 0
    for naslednje in opravila:
        while vrsta: # ponavljamo, dokler vrsta ni prazna

            predvideno, cas, opravilo = vrsta[0] # pogledamo opravilo na začetku vrste

            prekinitev = naslednje.arrival - t # čas do prihoda naslednjega opravila
            if prekinitev <= 0:
                break # če je naslednje opravilo že prišlo, prekinemo zanko, da ga dodamo v vrsto


            preostanek = cas - prekinitev # preostali čas trajanja po prihodu naslednjega opravila

            # naslednje opravilo bo prišlo pred koncem izvajanja trenutnega ima manjši predvideni čas trajanja
            if preostanek > 0:
                vrsta[0] = (predvideno, preostanek, opravilo) # popravimo preostali čas
                t = naslednje.arrival # premaknemo se na čas prekinitve
                break

            dogodki.append((t, opravilo, cas, 0)) # zabeležimo dokončanje opravila
            heappop(vrsta) # odstranimo opravilo iz vrste
            t += cas # premaknemo se na čas konca izvajanja
            cakanje += t - opravilo.length - opravilo.arrival # zabeležimo čakanje

        else: # zanke nismo prekinili z break
            t = naslednje.arrival # premaknemo se naprej do časa prihoda naslednjega opravila

        heappush(vrsta, (naslednje.predicted, naslednje.length, naslednje)) # dodamo opravilo z začetno prioriteto enako dolžini 

    return cakanje # bolj smiselno je, če vračata skupno čakanje, saj to ni odvisno le od števila opravil    
    


#Shortest Predicted Remaining Procesing Time
def SPRPT(seznam):
    opravila = (Opravilo(*t) for t in seznam)# zadnje, navidezno opravilo
    opravila = sorted(opravila, key=lambda item: item.arrival) + [Opravilo(None, float('inf'), float('inf'), float('inf'))] # zadnje, navidezno opravilo
    dogodki = []
    vrsta = []
    t = 0
    cakanje = 0
    for naslednje in opravila:
        while vrsta: # ponavljamo, dokler vrsta ni prazna

            prekinitev = naslednje.arrival - t # čas do prihoda naslednjega opravila
            if prekinitev <= 0:
                break # če je naslednje opravilo že prišlo, prekinemo zanko, da ga dodamo v vrsto

            predvideno, cas, opravilo = vrsta[0] # pogledamo opravilo na začetku vrste
            preostanek = cas - prekinitev # preostali čas trajanja po prihodu naslednjega opravila
            predvideno = predvideno - prekinitev

            # naslednje opravilo bo prišlo pred koncem izvajanja trenutnega ima manjši predvideni čas trajanja
            if preostanek > 0 and predvideno > naslednje.predicted:
                dogodki.append((t, opravilo, prekinitev, preostanek)) # zabeležimo izvajanje do prekinitve
                vrsta[0] = (predvideno, preostanek, opravilo) # popravimo preostali čas
                t = naslednje.arrival # premaknemo se na čas prekinitve
                break # prekinemo zanko, da dodamo naslednje opravilo v vrsto

            else: # izvajanje se bo končalo
                dogodki.append((t, opravilo, cas, 0)) # zabeležimo dokončanje opravila
                heappop(vrsta) # odstranimo opravilo iz vrste
                t += cas # premaknemo se na čas konca izvajanja
                cakanje += t - opravilo.length - opravilo.arrival # zabeležimo čakanje

        else: # zanke nismo prekinili z break
            t = naslednje.arrival # premaknemo se naprej do časa prihoda naslednjega opravila

        heappush(vrsta, (naslednje.predicted, naslednje.length, naslednje)) # dodamo opravilo z začetno prioriteto enako dolžini 
    return cakanje # bolj smiselno je, če vračata skupno čakanje, saj to ni odvisno le od števila opravil


#Preemptive Shortest Predicted job first
def PSPJF(seznam):
    opravila = (Opravilo(*t) for t in seznam)# zadnje, navidezno opravilo
    opravila = sorted(opravila, key=lambda item: item.arrival) + [Opravilo(None, float('inf'), float('inf'), float('inf'))] # zadnje, navidezno opravilo
    dogodki = []
    vrsta = []
    t = 0
    cakanje = 0
    for naslednje in opravila:
        while vrsta: # ponavljamo, dokler vrsta ni prazna

            prekinitev = naslednje.arrival - t # čas do prihoda naslednjega opravila
            if prekinitev <= 0:
                break # če je naslednje opravilo že prišlo, prekinemo zanko, da ga dodamo v vrsto

            predvideno, cas, opravilo = vrsta[0] # pogledamo opravilo na začetku vrste
            preostanek = cas - prekinitev # preostali čas trajanja po prihodu naslednjega opravila

            # naslednje opravilo bo prišlo pred koncem izvajanja trenutnega ima manjši predvideni čas trajanja
            if preostanek > 0 and predvideno > naslednje.predicted:
                dogodki.append((t, opravilo, prekinitev, preostanek)) # zabeležimo izvajanje do prekinitve
                vrsta[0] = (predvideno, preostanek, opravilo) # popravimo preostali čas
                t = naslednje.arrival # premaknemo se na čas prekinitve
                break # prekinemo zanko, da dodamo naslednje opravilo v vrsto

            else: # izvajanje se bo končalo
                dogodki.append((t, opravilo, cas, 0)) # zabeležimo dokončanje opravila
                heappop(vrsta) # odstranimo opravilo iz vrste
                t += cas # premaknemo se na čas konca izvajanja
                cakanje += t - opravilo.length - opravilo.arrival # zabeležimo čakanje

        else: # zanke nismo prekinili z break
            t = naslednje.arrival # premaknemo se naprej do časa prihoda naslednjega opravila

        heappush(vrsta, (naslednje.predicted, naslednje.length, naslednje)) # dodamo opravilo z začetno prioriteto enako dolžini 
    return cakanje # bolj smiselno je, če vračata skupno čakanje, saj to ni odvisno le od števila opravil
