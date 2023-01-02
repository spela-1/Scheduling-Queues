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

opravila1 = [(1, 0, 1), (2, 0, 2), (3, 2, 4), (4, 3, 5), (5, 7, 1)]
cakanje1 = FCFS(opravila1)


#Shortest job first
def SJF(opravila):
# vzame množico opravil in izračuna povprečen čas čakanja
# opravila je list opravil, opravilo = (id, arrival, length)
    opravila = sorted(opravila, key=lambda item: item[1])  #razvrsti po arrival
    cakanje = []
    vrsta = []
    t=opravila[0][1] #če se prvo opravilo začne po času 0
    n = len(opravila)

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

    return sum(cakanje)/n

# zadeva zdej dela ampak definitivno ni najbolj učinkovita. mrbit bi blo boljš delat z indeksi...?
opravila_SJF = [('p1', 0, 1), ('p2', 0, 2), ('p3', 2, 4), ('p4', 3, 5), ('p5', 7, 1)]

cakanje_SJF = SJF(opravila_SJF)
print("SJF", cakanje_SJF)




#Shortest remaining procesing time
def SRPT(opravila):
# vzame množico opravil in izračuna čas čakanja
# opravila je list opravil, opravilo = [id, arrival, length, length] = [id, arrival, length, remaining procesing time]
    opravila = sorted(opravila, key=lambda item: item[1])  #razvrsti po arrival
    cakanje = []
    vrsta = []
    t=opravila[0][1] #če se prvo opravilo začne po času 0
    t1 = opravila[0][1] #
    i=0 #indeks naslednjega opravila ki bo postavljen v vrsto:
    dokončana = 0
    n = len(opravila)

    while opravila[i][1]<=t:
        vrsta.append(opravila[i])
        i += 1
        if i + 1  == len(opravila):
              break

    while dokončana < len(opravila):

        vrsta = sorted(vrsta, key=lambda item: item[3])  #razvrsti po remaining procesing time
        
        trenutno = vrsta[0]

        if i < len(opravila):
            naslednje = opravila[i]
        else:
            naslednje = ["p", 100000000 , 0, 0]       # izmislimo si fiktivo opravilo tako, da bo {naslednje[1]< trenutno[3] + t} vedno FALSE



        if naslednje[1] < trenutno[3] + t:   #če bo naslednje opravilo prej prišel preden se bo trenutno zaključilo

            if naslednje[3]<trenutno[3]:    #če je remaining procesing time naslenjega krajša od trenutnega
                vrsta.remove(trenutno)
                t = naslednje[1]            #čas se spremeni
                trenutno[3] = trenutno[3]-(t-t1)  #shranimo preostali čas ki ga trenutno opravilo potrebuje, da bo končano t1 od začetka intervala 
                vrsta.append(trenutno)          #in trenutno gre nazaj v vrsto
                vrsta.append(naslednje)
                i += 1
                vrsta = sorted(vrsta, key=lambda item: item[3])   #razvrsti po remaining procesing time
                t1 = t                          #shrani se čas kdaj se je začelo to opravilo izvajati
                
                
            else:                           #če je remaining procesing time naslednjega daljša od trenutnega 
                vrsta.append(naslednje)
                i += 1
                vrsta = sorted(vrsta, key=lambda item: item[3])
                t1 = t  
                t = naslednje[1]
                trenutno[3] = trenutno[3]-(t-t1)
                

        else:                                       # SICER se trenutno opravilo zaključi
            dokončana += 1
            t = t + trenutno[3]
            t1 = t
            cas_cakanja = t - trenutno[1] - trenutno[2]
            cakanje.append(cas_cakanja)   
            vrsta.remove(trenutno)


    return sum(cakanje)/n
            

opravila_SRPT1 = [["1", 2, 6, 6], ["2", 5, 2, 2], ["3", 1, 8, 8], ["4", 0,3, 3], ["5", 4, 4, 4]]
opravila_SRPT2 = [["1", 0, 7,7], ["2", 1, 3, 3],["3", 3, 4, 4]]

cakanje_SRPT1 = SRPT(opravila_SRPT1)  
cakanje_SRPT2 = SRPT(opravila_SRPT2)    

print("SPRT1", cakanje_SRPT1)
print("SPRT2", cakanje_SRPT2) #pravilen odgovor 8/3 




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
    n =len(opravila)

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
            t = t + trenutno[3]
            t1 = t
            cas_cakanja = t - trenutno[1] - trenutno[2]
            cakanje.append(cas_cakanja)   
            vrsta.remove(trenutno)


    return sum(cakanje)/n


opravila_PSJF1 = [['p1', 0, 1, 1], ['p2', 0, 2, 2], ['p3', 2, 4, 4], ['p4', 3, 5, 5] , ['p5', 7, 1, 1]]
opravila_PSJF2 = [["1", 2, 6, 6], ["2", 5, 2, 2], ["3", 1, 8, 8], ["4",0, 3, 3], ["5", 4, 4, 4]]

cakanje_PSJF1 = PSJF(opravila_PSJF1)  
cakanje_PSJF2 = PSJF(opravila_PSJF2)

print("PSJF1", cakanje_PSJF1)
print("PSJF2", cakanje_PSJF2)



# VARIACIJE Z NAPOVEDMI:    vse je treba še preveriti če delajo pravilno

#Shortest Predicted Job First
def SPJF(opravila):
# vzame množico opravil in izračuna čas čakanja
# opravila je list opravil, opravilo = (id, arrival, length, predicted length)
    opravila = sorted(opravila, key=lambda item: item[1])  #razvrsti po arrival
    cakanje = []
    vrsta = []
    t=opravila[0][1] #če se prvo opravilo začne po času 0
    n= len(opravila)
    
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

        vrsta = sorted(vrsta, key=lambda item: item[3])  #razvrsti po predicted length
        
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

    return sum(cakanje)/n


opravila_SPJF = [('p1', 0, 1, 1), ('p2', 0, 2, 2), ('p3', 2, 4, 4), ('p4', 3, 5, 5), ('p5', 7, 1, 1)]
cakanje_SPJF = SPJF(opravila_SPJF)
print("SPJF", cakanje_SPJF)

opravila_SPJF1 = [('p1', 0, 1, 2), ('p2', 0, 2, 1), ('p3', 2, 4, 4), ('p4', 3, 5, 3), ('p5', 7, 1, 2)]
cakanje_SPJF1 = SPJF(opravila_SPJF1)
print("SPJF1", cakanje_SPJF1)



#Shortest Predicted Remaining Procesing Time
def SPRPT(opravila):
# vzame množico opravil in izračuna čas čakanja
# opravila je list opravil, opravilo = [id, arrival, length, length, predicted length] = [id, arrival, length, remaining procesing time, predicted remaining length]
    opravila = sorted(opravila, key=lambda item: item[1])  #razvrsti po arrival
    cakanje = []
    vrsta = []
    t=opravila[0][1] #če se prvo opravilo začne po času 0
    t1 = opravila[0][1] #
    i=0 #indeks naslednjega opravila ki bo postavljen v vrsto:
    dokončana = 0
    n= len(opravila)

    while opravila[i][1]<=t:
        vrsta.append(opravila[i])
        i += 1
        if i + 1  == len(opravila):
              break

    while dokončana < len(opravila):

        vrsta = sorted(vrsta, key=lambda item: item[4])  #razvrsti po predicted remaining procesing time
        
        trenutno = vrsta[0]

        if i < len(opravila):
            naslednje = opravila[i]
        else:
            naslednje = ["p", 100000000 , 0, 0, 0]       # izmislimo si fiktivo opravilo tako, da bo {naslednje[1]< trenutno[3] + t} vedno FALSE



        if naslednje[1] < trenutno[3] + t:   #če bo naslednje opravilo prej prišel preden se bo trenutno zaključilo

            if naslednje[4]<trenutno[4]:    #če je predicted remaining procesing time naslenjega krajša od trenutnega
                vrsta.remove(trenutno)
                t = naslednje[1]            #čas se spremeni
                trenutno[3] = trenutno[3]-(t-t1)  #shranimo preostali čas ki ga trenutno opravilo potrebuje, da bo končano t1 od začetka intervala
                trenutno[4] = trenutno[4]-(t-t1)  #shranimo preostali predicted čas ki ga trenutno opravilo potrebuje, da bo končano t1 od začetka intervala 
                vrsta.append(trenutno)          #in trenutno gre nazaj v vrsto
                vrsta.append(naslednje)
                i += 1
                vrsta = sorted(vrsta, key=lambda item: item[4])   #razvrsti po predicted remaining procesing time
                t1 = t                          #shrani se čas kdaj se je začelo to opravilo izvajati
                
                
            else:                           #če je remaining procesing time naslednjega daljša od trenutnega 
                vrsta.append(naslednje)
                i += 1
                vrsta = sorted(vrsta, key=lambda item: item[4])
                t1 = t  
                t = naslednje[1]
                trenutno[3] = trenutno[3]-(t-t1)
                trenutno[4] = trenutno[4]-(t-t1)
                

        else:                                       # SICER se trenutno opravilo zaključi
            dokončana += 1
            t = t + trenutno[3]
            t1 = t
            cas_cakanja = t - trenutno[1] - trenutno[2]
            cakanje.append(cas_cakanja)   
            vrsta.remove(trenutno)


    return sum(cakanje)/n



opravila_SPRPT1 = [["1", 2, 6, 6, 6], ["2", 5, 2, 2, 2], ["3", 1, 8, 8, 8], ["4", 0, 3, 3, 3], ["5", 4, 4, 4, 4]]
opravila_SPRPT2 = [["1", 0, 7, 7, 7], ["2", 1, 3, 3, 3],["3", 3, 4, 4, 4]]
opravila_SPRPT3 = [["1", 0, 7, 7, 1], ["2", 1, 3, 3, 10],["3", 3, 4, 4, 4]]

cakanje_SPRPT1 = SPRPT(opravila_SPRPT1)  
cakanje_SPRPT2 = SPRPT(opravila_SPRPT2)
cakanje_SPRPT3 = SPRPT(opravila_SPRPT3)    

print("SPRPT1", cakanje_SPRPT1)
print("SPRPT2", cakanje_SPRPT2) #pravilen odgovor 8/3 
print("SPRPT3", cakanje_SPRPT3)


#Preemptive Shortest Predicted Job First
def PSPJF(opravila):
# vzame množico opravil in izračuna čas čakanja
# opravila je list opravil, opravilo = [id, arrival, length, length, predicted length] = [id, arrival, length, remaining procesing time, predicted length]
    opravila = sorted(opravila, key=lambda item: item[1])  #razvrsti po arrival
    cakanje = []
    vrsta = []
    t=opravila[0][1] #če se prvo opravilo začne po času 0
    t1 = opravila[0][1] #
    i=0 #indeks naslednjega opravila ki bo postavljen v vrsto:
    dokončana = 0
    n = len(opravila)

    while opravila[i][1]<=t:
        vrsta.append(opravila[i])
        i += 1
        if i + 1  == len(opravila):
              break

    while dokončana < len(opravila):

        vrsta = sorted(vrsta, key=lambda item: item[4])  #razvrsti po predicted length
        
        trenutno = vrsta[0]

        if i < len(opravila):
            naslednje = opravila[i]
        else:
            naslednje = ["p", 100000000 , 0, 0, 0]       # izmislimo si fiktivo opravilo tako, da bo {naslednje[1]< trenutno[2] + t} vedno ne res



        if naslednje[1] < trenutno[3] + t:   #če bo naslednje opravilo prej prišel preden se bo trenutno zaključilo

            if naslednje[4]<trenutno[4]:    #če je predicted dolžina naslenjega krajša od trenutnega
                vrsta.remove(trenutno)
                t = naslednje[1]            #čas se spremeni
                trenutno[3] = trenutno[3]-(t-t1)  #shranimo preostali čas ki ga trenutno opravilo potrebuje, da bo končano t1 od začetka intervala 
                vrsta.append(trenutno)          #in trenutno gre nazaj v vrsto
                vrsta.append(naslednje)
                i += 1
                vrsta = sorted(vrsta, key=lambda item: item[4])   #razvrsti po length
                t1 = t                          #shrani se čas kdaj se je začelo to opravilo izvajati
                
                
            else:                           #če je predicted dolžina naslednjega daljša od trenutnega 
                vrsta.append(naslednje)
                i += 1
                vrsta = sorted(vrsta, key=lambda item: item[4])
                t1 = t  
                t = naslednje[1]
                trenutno[3] = trenutno[3]-(t-t1)
                

        else:                                       # SICER se trenutno opravilo zaključi
            dokončana += 1
            t = t + trenutno[3]
            t1 = t
            cas_cakanja = t - trenutno[1] - trenutno[2]
            cakanje.append(cas_cakanja)   
            vrsta.remove(trenutno)


    return sum(cakanje)/n

opravila_PSPJF1 = [['p1', 0, 1, 1, 1], ['p2', 0, 2, 2, 2], ['p3', 2, 4, 4, 4], ['p4', 3, 5, 5, 5] , ['p5', 7, 1, 1, 1]]
opravila_PSPJF2 = [["1", 2, 6, 6, 6], ["2", 5, 2, 2, 2], ["3", 1, 8, 8, 8], ["4",0, 3, 3, 3], ["5", 4, 4, 4, 4]]
opravila_PSPJF3 = [["1", 2, 6, 6, 10], ["2", 5, 2, 2, 1], ["3", 1, 8, 8, 2], ["4",0, 3, 3, 7], ["5", 4, 4, 4, 4]]

cakanje_PSPJF1 = PSPJF(opravila_PSPJF1)  
cakanje_PSPJF2 = PSPJF(opravila_PSPJF2)
cakanje_PSPJF3 = PSPJF(opravila_PSPJF3)

print("PSPJF1", cakanje_PSPJF1)
print("PSPJF2", cakanje_PSPJF2)
print("PSPJF3", cakanje_PSPJF3)