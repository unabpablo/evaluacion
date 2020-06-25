def format(matrix):
    new_dict = {}
    for t in range(horizon_time):
        if t not in new_dict:
            new_dict[t] = []
        for a in range(n_att):
            new_dict[t].append(tuple(matrix[t][a]))
    return new_dict

def decision_normalization(decision):
    normal = {}
    for t in range(horizon_time):
        if t not in normal:
            normal[t] = []
        for a in range(n_att):
            normal[t].append(list(decision[t][a]))
            for x in range(n_resources):
                if attributes[a] == "benefit":
                    normal[t][a][x] = round(decision[t][a][x]/max(decision[t][a]),4)
                else:
                    normal[t][a][x] = round(min(decision[t][a])/decision[t][a][x],4)
    return normal

def wa_operator(matrix):
    wa = []
    for t in range(horizon_time):
        wa.append([])
        for x in range(n_resources):
            cnt = 0
            for a in range(n_att):
                cnt += weights[t][a]*matrix[t][a][x]
            wa[-1].append(round(cnt,4))
    return wa

def dwa_operator(matrix):
    score = []
    for x in range(n_resources):
        score.append(0)
        t = 0
        for w in weight_years:
            score[-1] += round(w*matrix[t][x],4)
            t += 1
    return score

#def total_evaluaciones(id_evaluacion):
#	datos_per = Eval_Data.objects.filter(Conf.Nombre="Raul")
#    return datos_per
resources = ["x1","x2","x3","x4","x5"]
#resources = ["1","2","3","4","5"]

attributes = ["benefit","benefit","cost"]





    coleccion=Collection.objects.filter(Conf_id=id)
    collecion=[]
    crit1=coleccion[0]
    crit2=coleccion[1]


    try:
        etiq1=CollectionTitle.objects.filter(collection=crit1.id)
        etiq2=CollectionTitle.objects.filter(collection=crit2.id)
        for i in range(1,len(etiq1)+1,1):
            valores.append(i)
        for i in range(1,len(etiq2)+1,1):
            valores2.append(i)
    
    except:
        etiq1=None
        etiq2=None

    try:
        crit3=coleccion[2]
        etiq3=CollectionTitle.objects.filter(collection=crit3.id)
        for i in range(1,len(etiq3)+1,1):
            valores3.append(i)
    except:
        crit3=None
        etiq3=None
    try:
        crit4=coleccion[3]
        etiq4=CollectionTitle.objects.filter(collection=crit4.id)
        for i in range(1,len(etiq4)+1,1):
            valores4.append(i)
    except:
        crit4=None
        etiq4=None    
    try:
        crit5=coleccion[4]
        etiq5=CollectionTitle.objects.filter(collection=crit5.id)
        for i in range(1,len(etiq5)+1,1):
            valores4.append(i)
    except:
        crit5=None
        etiq5=None


    usuario=Eval_Data.objects.filter(conf=conf)
    print("asdsa",usuario)
    n=0












#weight_years = [1.0/6, 2.0/6, 3.0/6]
#weights = [[0.4, 0.4, 0.2], [0.4, 0.35, 0.25], [0.4, 0.3, 0.3]]
weights=Eval_Conf.objects.filter(id=conf)
n_resources = len(resources)
n_att = len(attributes)
horizon_time = len(weight_years)
decision = []
all_data = {} # {0:[(0.75,0.95,0.8,0.9,0.85),(0.85,...,0.8,0.85),(0.5,...,0.55)], 1: [(...), (...), (...)], 2:[...]}

for i in usuario:
    if etiq1 is None:
        print("error")
    else:
        for k in etiq1:
            if(i.Peso1==k.Nombre):         #crit1
                i.Peso1=valores[n]
                print(valores[n])
            else:
                n=n+1
        n=0

    if etiq2 is None:
        print("error")
    else:
        for l in etiq2:
            if(i.Peso2==l.Nombre):         #crit1
                i.Peso2=valores2[m]
                print(valores[m])
            else:
                m=m+1
        m=0
    

    if etiq3 is None:
        print("error")
    else:
        for a in etiq3:
            if(i.Peso3==a.Nombre):         #crit1
                i.Peso3=valores3[o]
                print(valores[o])
            else:
                o=+1
        o=0
    
    if etiq4 is None:
        print("error")
    else:
        for b in etiq4:
            if(i.Peso4==b.Nombre):         #crit1
                i.Peso4=valores4[p]
                print(valores[p])
            else:
                p=p+1
        p=0

    print("object ",i.Peso1,i.Peso2)        
    if(i.Peso3 is None):
        i.Peso3=0
    if(i.Peso1 is None):
        i.Peso1=0
    if(i.Peso2 is None):
        i.Peso2=0
    if(i.Peso4 is None):
        i.Peso4=0
    if(i.Peso5 is None):
        i.Peso5=0
            
    data.append(0.5*float(i.Peso1)  +0.3*float(i.Peso2)+0.1*float(i.Peso3) + 0.1*float(i.Peso4))
        













for resource in resources:
    t = 0
    #data = open("-".join(["dataset",resource + ".txt"]))
    #data = open("".join(["dataset",resource + ".txt"]))

    for time in data: # time = [a1,a2,...,an] each line is a different t
        if t not in all_data:
            all_data[t] = []
        L = list(map(float,time.strip().split()))
        all_data[t].append(L)	
        t += 1
    data.close()
for t in range(horizon_time):
    decision.append([])
    for a in range(n_att):
        decision[-1].append([])
        for x in range(n_resources):
            decision[-1][-1].append(all_data[t][x][a])
normal_decision = decision_normalization(format(decision))
print
matrix = list(wa_operator(normal_decision))
score = list(dwa_operator(matrix))
print (score)
print ("Best candidate: "),resources[score.index(max(score))]
print("asas",total_evaluaciones(1))