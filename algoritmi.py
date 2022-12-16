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