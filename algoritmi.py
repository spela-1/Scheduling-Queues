#First Come First Serve    
def FCFS(opravila):
# vzame množico opravil in izračuna čas čakanja
# opravila je list opravil, opravilo = (id, arrival, length)
    opravila = sorted(opravila, key=lambda item: item[1])  #razvrsti po arrival
    cakanje = []
    t=opravila[0][1] #če se prvo opravilo začne po času 0
    for i in range(len(opravila)):
        opravilo = opravila[i]
        cas_cakanja = t-opravilo[1]
        cakanje.append(cas_cakanja)
        t = opravilo[2] + t  #čas po končanem opravilu

    return sum(cakanje)


opravila1 = [(1, 0, 1), (2, 0, 2), (3, 2, 4), (4, 3, 5), (5, 7, 1)]

cakanje1 = FCFS(opravila1)


#Shortest job first
def SJF(opravila):
# vzame množico opravil in izračuna čas čakanja
# opravila je list opravil, opravilo = (id, arrival, length)
    opravila = sorted(opravila, key=lambda item: item[1])  #razvrsti po arrival
    cakanje = []
    vrsta = []
    t=opravila[0][1] #če se prvo opravilo začne po času 0
    for opravilo in opravila:
        opravila.remove(opravilo)   

        #če se na opravila čaka in se med tem ne izvaja nobeno drugo 
        if opravilo[1] > t:
            t = opravilo[1]

        #vsa opravila, ki so prišla do časa t postavi v vrsto in izbriše iz opravil
        vrsta.append(opravilo)
        while opravila[0][1]<= t:
            vrsta.append(opravila[0])
            opravila.remove(opravila[0])
        vrsta = sorted(vrsta, key=lambda item: item[2])  #razvrsti po length
        
        #izvaja opravila v vrsti dokler ni t enak času prihoda naslednjega opravila ali pa je list opravil prazen
        while t < opravila[0][1] or (len(opravila) == 0 and len(vrsta !=0 )):
            opravilo1 = vrsta[0]
            vrsta.remove(opravilo1)
            cas_cakanja = t-opravilo1[1]
            cakanje.append(cas_cakanja)
            t = opravilo1[2] + t  #čas po končanem opravilu

    return cakanje

opravila_SJF = [(1, 0, 1), (2, 0, 2), (3, 2, 4), (4, 3, 5), (5, 7, 1)]

cakanje_SJF = SJF(opravila_SJF)


# kaj je trenutno narobe? 
# 30. vrstica: ali vzame for i in list, po vrsti? ko se debuga kaze da je vzel p4 pred p3
# ko bi moral vzeti za opravilo p5 vrže na zadnjo vrstico, kot da je kočal vse aka ignorera zadnji element

