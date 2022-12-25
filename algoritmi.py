#First Come First Serve    
def FCFS(opravila):
# vzame množico opravil in izračuna čas čakanja
# opravila je list opravil, opravilo = (id, arrival, length)
    opravila = sorted(opravila, key=lambda item: item[1])  #razvrsti po arrival
    cakanje = []
    t=opravila[0][1] #če se prvo opravilo začne po času 0
    for i in range(len(opravila)):

        if t < opravila[i][1]:
            t = opravila[i][1]

        opravilo = opravila[i]
        cas_cakanja = t-opravilo[1]
        cakanje.append(cas_cakanja)
        t = opravilo[2] + t  #čas po končanem opravilu

    return sum(cakanje)



opravila2 = [(1, 0, 1), (4, 3, 5), (5, 7, 1)]
cakanje2 = FCFS(opravila2)

#numpy

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
# opravila je list opravil, opravilo = [id, arrival, length]
    opravila = sorted(opravila, key=lambda item: item[1])  #razvrsti po arrival
    cakanje = []
    vrsta = []
    t=opravila[0][1] #če se prvo opravilo začne po času 0
    t1 = opravila[0][1] #
    i=0 #indeks naslednjega opravila ki bo postavljen v vrsto:
    dokončana = 0

    while opravila[i][1]<=t:
        vrsta.append(opravila[i])
        i += 1
        if i + 1  == len(opravila):
              break

    while dokončana < len(opravila):

        vrsta = sorted(vrsta, key=lambda item: item[2])  #razvrsti po length
        
        trenutno = vrsta[0]

        if i < len(opravila):
            naslednje = opravila[i]
        else:
            naslednje = ["p", 100000000 , 0]       # izmislimo si fiktivo opravilo tako, da bo {naslednje[1]< trenutno[2] + t} vedno ne res



        if naslednje[1] < trenutno[2] + t:   #če bo naslednje opravilo prej prišel preden se bo trenutno zaključilo

            if naslednje[2]<trenutno[2]:    #če je dolžina naslenjega krajša od trenutnega
                vrsta.remove(trenutno)
                t = naslednje[1]            #čas se spremeni
                trenutno[2] = trenutno[2]-(t-t1)  #shranimo preostali čas ki ga trenutno opravilo potrebuje, da bo končano t1 od začetka intervala 
                vrsta.append(trenutno)          #in trenutno gre nazaj v vrsto
                vrsta.append(naslednje)
                i += 1
                vrsta = sorted(vrsta, key=lambda item: item[2])   #razvrsti po length
                t1 = t                          #shrani se čas kdaj se je začelo to opravilo izvajati
                
                
            else:                           #če je dolžina naslednjega daljša od trenutnega 
                vrsta.append(naslednje)
                i += 1
                vrsta = sorted(vrsta, key=lambda item: item[2])
                t1 = t  
                t = naslednje[1]
                trenutno[2] = trenutno[2]-(t-t1)
                

        else:                                       # SICER se trenutno opravilo zaključi
            dokončana += 1
            cas_cakanja = t1 - trenutno[1]
            cakanje.append(cas_cakanja)
            t = t + trenutno[2]
            t1 = t
            vrsta.remove(trenutno)


    return cakanje
            

opravila_SRPT1 = [['p1', 0, 1], ['p2', 0, 2], ['p3', 2, 4], ['p4', 3, 5], ['p5', 7, 1]]
opravila_SRPT2 = [['p1', 0, 5], ['p2', 1, 1], ['p3', 2, 4]]
opravila_SRPT3 = [['p1', 0, 1], ['p2', 0, 2], ['p3', 2, 4], ['p4', 3, 5], ['p5', 7, 1]]
opravila_SRPT4 = [['p1', 0, 1], ['p2', 0, 2], ['p3', 2, 4], ['p4', 3, 5], ['p5', 7, 1]]

cakanje_SRPT1 = SRPT(opravila_SRPT1)  
cakanje_SRPT2 = SRPT(opravila_SRPT2)     


#popraviti je treba:

# fajn bi blo še preveriti če t in t1 štimata tudi pri drugih podatkih,
# npr tako da pride več opravil v pripravljeno vrsto med izvajanjem enega opravila


#Preemptive shortest job first
def PSJF(opravila):
# vzame množico opravil in izračuna čas čakanja
# opravila je list opravil, opravilo = [id, arrival, length, length] = [id, arrival, length, remaining procesing time]
    opravila = sorted(opravila, key=lambda item: item[1])  #razvrsti po arrival
    cakanje = []
    vrsta = []
    t=opravila[0][1] #če se prvo opravilo začne po času 0
    t1 = opravila[0][1] #
    i=0 #indeks naslednjega opravila ki bo postavljen v vrsto:
    dokončana = 0

    while opravila[i][1]<=t:
        vrsta.append(opravila[i])
        i += 1
        if i + 1  == len(opravila):
              break

    while dokončana < len(opravila):

        vrsta = sorted(vrsta, key=lambda item: item[2])  #razvrsti po length
        
        trenutno = vrsta[0]

        if i < len(opravila):
            naslednje = opravila[i]
        else:
            naslednje = ["p", 100000000 , 0, 0]       # izmislimo si fiktivo opravilo tako, da bo {naslednje[1]< trenutno[2] + t} vedno ne res



        if naslednje[1] < trenutno[3] + t:   #če bo naslednje opravilo prej prišel preden se bo trenutno zaključilo

            if naslednje[2]<trenutno[2]:    #če je dolžina naslenjega krajša od trenutnega
                vrsta.remove(trenutno)
                t = naslednje[1]            #čas se spremeni
                trenutno[3] = trenutno[3]-(t-t1)  #shranimo preostali čas ki ga trenutno opravilo potrebuje, da bo končano t1 od začetka intervala 
                vrsta.append(trenutno)          #in trenutno gre nazaj v vrsto
                vrsta.append(naslednje)
                i += 1
                vrsta = sorted(vrsta, key=lambda item: item[2])   #razvrsti po length
                t1 = t                          #shrani se čas kdaj se je začelo to opravilo izvajati
                
                
            else:                           #če je dolžina naslednjega daljša od trenutnega 
                vrsta.append(naslednje)
                i += 1
                vrsta = sorted(vrsta, key=lambda item: item[2])
                t1 = t  
                t = naslednje[1]
                trenutno[3] = trenutno[3]-(t-t1)
                

        else:                                       # SICER se trenutno opravilo zaključi
            dokončana += 1
            cas_cakanja = t1 - trenutno[1]
            cakanje.append(cas_cakanja)
            t = t + trenutno[3]
            t1 = t
            vrsta.remove(trenutno)


    return cakanje

print(cakanje)
            

opravila_PSJF = [['p1', 0, 1, 1], ['p2', 0, 2, 2], ['p3', 2, 4, 4], ['p4', 3, 5, 5] , ['p5', 7, 1, 1]]

cakanje_PSJF = PSJF(opravila_PSJF)  

opravila_PSJF2 = [["1", 2, 6],["2", 5, 2], ["3", 1, 8], ["4",0,3],["5", 4, 4]]

cakanje_PSJF2 = PSJF(opravila_PSJF2)
