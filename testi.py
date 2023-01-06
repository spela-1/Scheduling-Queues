import algoritmi



from algoritmi import FCFS

opravila2 = [(1, 0, 1), (4, 3, 5), (5, 7, 1)]
opravila1 = [(1, 0, 1), (2, 0, 2), (3, 2, 4), (4, 3, 5), (5, 7, 1)]

cakanje2 = FCFS(opravila2)
cakanje1 = FCFS(opravila1)


from algoritmi import SJF

opravila_SJF = [('p1', 0, 1), ('p2', 0, 2), ('p3', 2, 4), ('p4', 3, 5), ('p5', 7, 1)]

cakanje_SJF = SJF(opravila_SJF)
print("SJF", cakanje_SJF)


from alg_prof import SRPT

opravila_SRPT1 = [["1", 2, 6, 6], ["2", 5, 2, 2], ["3", 1, 8, 8], ["4", 0,3, 3], ["5", 4, 4, 4]]
opravila_SRPT2 = [["1", 0, 7,7], ["2", 1, 3, 3],["3", 3, 4, 4]]

cakanje_SRPT1 = SRPT(opravila_SRPT1)  
cakanje_SRPT2 = SRPT(opravila_SRPT2)    

print("SPRT1", cakanje_SRPT1)
print("SPRT2", cakanje_SRPT2) #pravilen odgovor 8/3 


from algoritmi import PSJF

opravila_PSJF1 = [['p1', 0, 1, 1], ['p2', 0, 2, 2], ['p3', 2, 4, 4], ['p4', 3, 5, 5] , ['p5', 7, 1, 1]]
opravila_PSJF2 = [["1", 2, 6, 6], ["2", 5, 2, 2], ["3", 1, 8, 8], ["4",0, 3, 3], ["5", 4, 4, 4]]

cakanje_PSJF1 = PSJF(opravila_PSJF1)  
cakanje_PSJF2 = PSJF(opravila_PSJF2)

print("PSJF1", cakanje_PSJF1)
print("PSJF2", cakanje_PSJF2)


from algoritmi import SPJF

opravila_SPJF = [('p1', 0, 1, 1), ('p2', 0, 2, 2), ('p3', 2, 4, 4), ('p4', 3, 5, 5), ('p5', 7, 1, 1)]
opravila_SPJF1 = [('p1', 0, 1, 2), ('p2', 0, 2, 1), ('p3', 2, 4, 4), ('p4', 3, 5, 3), ('p5', 7, 1, 2)]

cakanje_SPJF = SPJF(opravila_SPJF)
cakanje_SPJF1 = SPJF(opravila_SPJF1)

print("SPJF", cakanje_SPJF)
print("SPJF1", cakanje_SPJF1)


from algoritmi import SPRPT

opravila_SPRPT1 = [["1", 2, 6, 6, 6], ["2", 5, 2, 2, 2], ["3", 1, 8, 8, 8], ["4", 0, 3, 3, 3], ["5", 4, 4, 4, 4]]
opravila_SPRPT2 = [["1", 0, 7, 7, 7], ["2", 1, 3, 3, 3],["3", 3, 4, 4, 4]]
opravila_SPRPT3 = [["1", 0, 7, 7, 1], ["2", 1, 3, 3, 10],["3", 3, 4, 4, 4]]

cakanje_SPRPT1 = SPRPT(opravila_SPRPT1)  
cakanje_SPRPT2 = SPRPT(opravila_SPRPT2)
cakanje_SPRPT3 = SPRPT(opravila_SPRPT3)    

print("SPRPT1", cakanje_SPRPT1)
print("SPRPT2", cakanje_SPRPT2) #pravilen odgovor 8/3 
print("SPRPT3", cakanje_SPRPT3)


from alg_prof import PSPJF

opravila_PSPJF1 = [['p1', 0,  1, 1], ['p2', 0, 2, 2], ['p3', 2, 4, 4], ['p4', 3, 5, 5] , ['p5', 7, 1, 1]]
opravila_PSPJF2 = [["1", 2, 6, 6], ["2", 5, 2, 2], ["3", 1, 8, 8], ["4",0, 3, 3], ["5", 4, 4, 4]]
opravila_PSPJF3 = [["1", 2, 6, 10], ["2", 5, 2, 1], ["3", 1, 8, 2], ["4",0, 3, 7], ["5", 4, 4, 4]]

cakanje_PSPJF1 = PSPJF(opravila_PSPJF1)  
cakanje_PSPJF2 = PSPJF(opravila_PSPJF2)
cakanje_PSPJF3 = PSPJF(opravila_PSPJF3)

print("PSPJF1", cakanje_PSPJF1)
print("PSPJF2", cakanje_PSPJF2)
print("PSPJF3", cakanje_PSPJF3)
