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
    while len(opravila) > 0:
        opravilo = opravila[0]
        opravila.remove(opravilo)   

        #če se na opravila čaka in se med tem ne izvaja nobeno drugo 
        if opravilo[1] > t:
            t = opravilo[1]

        #vsa opravila, ki so prišla do časa t postavi v vrsto in izbriše iz opravil
        vrsta.append(opravilo)
        if len(opravila) !=0:
            while opravila[0][1]<= t :
                vrsta.append(opravila[0])
                opravila.remove(opravila[0])
            vrsta = sorted(vrsta, key=lambda item: item[2])  #razvrsti po length
        
        #izvaja opravila v vrsti dokler ni t enak času prihoda naslednjega opravila ali pa je list opravil prazen
        if len(opravila) !=0:
            while t < opravila[0][1] :
                opravilo1 = vrsta[0]
                vrsta.remove(opravilo1)
                cas_cakanja = t-opravilo1[1]
                cakanje.append(cas_cakanja)
                t = opravilo1[2] + t  #čas po končanem opravilu
        else:
            while len(vrsta) !=0:
                opravilo1 = vrsta[0]
                vrsta.remove(opravilo1)
                cas_cakanja = t-opravilo1[1]
                cakanje.append(cas_cakanja)
                t = opravilo1[2] + t  #čas po končanem opravilu

    return cakanje

opravila_SJF = [('p1', 0, 1), ('p2', 0, 2), ('p3', 2, 4), ('p4', 3, 5), ('p5', 7, 1)]

cakanje_SJF = SJF(opravila_SJF)


# zadeva zdej dela ampak definitivno ni najbolj učinkovita. mrbit bi blo boljš delat z indeksi...?

#Shortest remaining procesing time
def SRPT(opravila):
# vzame množico opravil in izračuna čas čakanja
# opravila je list opravil, opravilo = (id, arrival, length)
    opravila = sorted(opravila, key=lambda item: item[1])  #razvrsti po arrival
    cakanje = []
    vrsta = []
    t=opravila[0][1] #če se prvo opravilo začne po času 0
    i=0 #indeks zadnjega opravila postavljenega v vrsto:
    while 1:

        #vsa opravila, ki so prišla do časa t postavi v vrsto
        while opravila[i][1]<t:
            vrsta.append(opravila[i])
            i += 1
        vrsta = sorted(vrsta, key=lambda item: item[2])  #razvrsti po length
        
        trenutno = vrsta[0]

# t1 od začetka intervala 


        if opravila[i+1][1]< trenutno[2] + t:   #če bo naslednje opravilo prej prišel preden se bo trenutno zaključilo

            if opravila[i+1][2]<trenutno[2]:    #če je dolžina krajša od trenutnega
                trenutno[2] = trenutno[2] - t1   #shranimo preostali čas ki ga trenutno opravilo potrebuje, da bo končano
                vrsta.append(trenutno)          #in trenutno gre nazaj v vrsto
                t = opravila[i+1][1]            #čas se spremeni
                i += 1
            else:
                vrsta.append(opravila[i+1])
                vrsta = sorted(vrsta, key=lambda item: item[2])
                i += 1

         # SICER se trenutno opravilo se zaključi
            
#NEVEMMMM
