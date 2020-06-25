import sys
import matplotlib.pyplot as plt
from math import log,exp
import os
from django.conf import settings
linguistic_var_number = 5
n_att = 4

attributes = ["benefit","cost","benefit","benefit"]
user_required_level = [4, 2, 4, 4]
cant=sum([len(files) for r, d, files in os.walk("C:\\Users\Rauls\Desktop\evaluacion\media\datos")])
print("cantidad es",cant)

n_resources = 2


def matrizT():
    
    delta = [1,1,1,1]

    criptos = {}
    ids = {}
    n_resources = 1
    W_user = [0.25, 0.25, 0.25, 0.25]
 


    #_resources = 76
    resources = []
    for i in range(1,n_resources+1):
        resources.append("".join(["y",str(i)]))

    decision = []
    all_data = {}
    for resource in resources:
        t = 0
        try:
            data = open(os.path.join(settings.BASE_DIR,""+"-".join([resource + ".txt"])))
            for line in data:
                criptos[line.strip()] = []
                ids[int(resource[1:])] = line.strip()
                break
            for time in data: # time = [a1,a2,...,an] each line is a different t
                if t not in all_data:
                    all_data[t] = []
        #        all_data[t].append(map(float,time.strip().split()[:-2]))
                all_data[t].append(list(map(float,time.strip().split()[:-4]))+[log(float(time.strip().split()[-4])+sys.float_info.min),
                                                                        log(float(time.strip().split()[-3])+sys.float_info.min)])
                criptos[line.strip()].append(tuple(map(float,time.strip().split()[-2:])))
                t += 1
            data.close()
        except: 
            all_data = 0
    return all_data
T=len(matrizT())

def add_scalar(x,num):
    if len(num) == 1:
        for i in range(len(x)):
            x[i] += num[0]
    else:
        for i in range(len(x)):
            x[i] += num[i]
    return x

def mult_scalar(x,num):
    if len(num) == 1:
        for i in list(range(len(x))):
            x[i] *= num[0]
    else:
        for i in range(len(x)):
            x[i] *= num[i]
    return x

def substract_list(x,y):
    aux = []
    for i in range(len(x)):
        aux.append(x[i] - y[i])
    return aux

def obtain_elem(l,ind):
    aux = []
    for i in ind:
        aux.append(l[i-1])
    return aux

def ceil(num):
    if num-int(num) == 0:
        return int(num)
    else:
        return int(num+1)

def percentile(x,p):
    x = list(x)
    aux = p[::]
    x.sort()
    trim = add_scalar(mult_scalar(aux, [(len(x)-1)*0.01]), [1])
    delta = substract_list(trim, list(map(int, trim)))
    return add_scalar(mult_scalar(obtain_elem(x, list(map(int,trim))), delta) , mult_scalar(obtain_elem(x, list(map(ceil,trim))), substract_list([1]*len(delta),delta)))

def weighting_years(alpha, horizon_time): # BUM function
    weights = []
    for t in range(horizon_time):
        weights.append((exp(alpha*t/horizon_time)-exp(alpha*(t-1)/horizon_time))/(exp(alpha)-1))
    return weights

def format(matrix):
    new_dict = {}
    for t in range(T):
        if t not in new_dict:
            new_dict[t] = []
        for a in range(n_att):
            new_dict[t].append(tuple(matrix[t][a]))
    return new_dict

def decision_normalization(decision):
    normal = {}
    for t in range(T):
        if t not in normal:
            normal[t] = []
        for a in range(n_att):
            normal[t].append(list(decision[t][a]))
            for x in range(n_resources):
                if attributes[a] == "benefit":
                    normal[t][a][x] = round(decision[t][a][x]/max(decision[t][a]),4)
                else:
                    normal[t][a][x] = round(min(decision[t][a])/(decision[t][a][x]+1e-9),4)
    return normal

def linguistic_values(DD,n_vl):
    D = list(DD)
    delta = 100//(n_vl -1)
    p = list(range(0,101,delta))
    prc = []
    for i in range(n_att):
        prc.append(percentile(D[i],p))
    LV = []
    for i in range(n_att):
        LV.append([])
        LV[-1].append([prc[i][0],prc[i][0],prc[i][1]])
        for j in range(linguistic_var_number-2):
            LV[-1].append(prc[i][j:j+3])
        LV[-1].append([prc[i][linguistic_var_number-2],prc[i][linguistic_var_number-1],prc[i][linguistic_var_number-1]])    
    return LV

def fsimilarity(triang1,triang2):

    min1,centroid1,max1=list(map(float,triang1))
    min2,centroid2,max2=list(map(float,triang2))
    similarity, interception, sign_drift = 0,0,0
    if centroid1 > centroid2:
        min_temp,centroid_temp,max_temp = min1,centroid1,max1
        min1,centroid1,max1 = min2,centroid2,max2
        min2,centroid2,max2 = min_temp,centroid_temp,max_temp
        sign_drift = -1
    elif centroid1 < centroid2:
        sign_drift = +1
    else:
        sign_drift = (max2-min2)>(max1-min1)
    ### cases I -> VI
    if centroid1 == centroid2:
        if ((max1 - min1) < (max2 - min2)):
            similarity = (max1 - min1) / (max2 - min2)
        else:
            similarity = (max2 - min2) / (max1 - min1)

    if max1 <= min2:
        similarity = 0

    if max1 <= max2 and min1 <= min2 and max1 > min2:
        interception = 0.5 * (((max1 - min2) * (max1 - min2)) / (max1 - centroid1 + centroid2 - min2))
        similarity = interception / (0.5 * (max1 - min1 + max2 - min2) - interception)

    if max1 <= max2 and min1 > min2:
        h1 = (min1 - min2) / (centroid2 - min2 + min1 - centroid1+1e-9)
        h2 = (max1 - min2) / (centroid2 - min2 + max1 - centroid1+1e-9)
        interception = 0.5*(max1 - min2)*h2 - 0.5*(min1-min2)*h1
        similarity = (interception / (0.5 * (max2 - min2 + max1 - min1) - interception))

    if max1 > max2 and min1 <= min2:
        h1 = (max1 - min2) / (max1 - centroid1 + centroid2 - min2)
        h2 = (max1 - max2) / (max1 - centroid1 + centroid2 - max2)
        interception = 0.5*(max1-min2)*h1 - 0.5*(max1-max2)*h2
        similarity = interception / (0.5 * (max1 - min1 + max2 - min2) - interception)

    if max1 > max2 and min1 > min2:
        h1 = (min1 - min2) / (centroid2 - min2 + min1 - centroid1)
        h2 = (max1 - max2) / (max1 - centroid1 + centroid2 - max2)
        h3 = (max1 - min2) / (max1 - centroid1 + centroid2 - min2)
        interception = 0.5*(max1 - min2)*h3 - 0.5*(min1-min2)*h1 - 0.5*(max1-max2)*h2
        similarity = interception / (0.5 * (max2 - min2 + max1 - min1) - interception)

    if similarity > 1:
        similarity=1 # Similarity greater than 1
    if similarity < 0:
        similarity=0 # Similarity less than 0

    return round(similarity,2), round(interception,2), sign_drift == 1

def membership_atleast(x,p,A):
    mu = 0
    p = p - 1
    if x < A[p][0]:
        mu = 0
    elif x >= A[p][1]:
        mu = 1
    else:
        mu = float((A[p][0] - x)) / (A[p][0] - A[p][1])
    return round(mu,2)

def membership_atmost(x,p,A):
    mu = 0
    p = p - 1
    if x <= A[p][1]:
        mu = 1
    elif x > A[p][2]:
        mu = 0
    else:
        mu = float((x - A[p][2])) / (A[p][1] - A[p][2])
    return round(mu,2)

def wa_operator(D, criteria, level, LV):
    D = list(D)
    LV = list(LV)
    criteria = list(criteria)
    level = list(level)
    R = []
    for ii in range(len(D[0])):
        R.append([])
        for jj in range(n_att):
            if criteria[jj] == "least":
                R[-1].append(membership_atleast(D[jj][ii],user_required_level[jj],LV[jj]))
            elif criteria[jj] == "most":
                R[-1].append(membership_atmost(D[jj][ii],user_required_level[jj],LV[jj]))
    return R

def drift_symptom(LV_time, attribute, p, tau, Delta, rho, tolerance):
    counter = 0
    jj = 0
    flag=0
    bbool=0
    drift = []
    for tt in range(tau-Delta+1, tau):
#        if tt+1 >= T:
#            break
        tr1 = list(LV_time[tt][attribute][p])
        tr2 = list(LV_time[tt+1][attribute][p])
        if tr1.count(tr1[0]) == 3:
            continue
        similarity,interception, sign_drift = fsimilarity(tr2,tr1)
        drift.append(1-similarity)
        if abs(drift[jj] * sign_drift) > rho:
            if flag == sign_drift:
                counter += 1
            else:
                counter = 0
                flag = sign_drift
        jj += 1
    if counter >= tolerance:
        bbool = 1
    return bbool,drift

def exponential_weight(tau,delta,alpha):
    alpha = list(alpha)
    delta = list(delta)
    ini = list(substract_list(list(mult_scalar([1,1,1,1],[tau])), delta))
    ini = add_scalar(ini,[1])
    fin = tau
    TW = []
    for a in range(len(alpha)):
        TW.append([])
        for k in range(ini[a],fin+1):
            aux = exp(alpha[a]*(k-tau+delta[a])/delta[a])*(1-exp(-alpha[a]/delta[a]))/(exp(alpha[a])-1)
            TW[-1].append(round(aux,2))
    return TW

def dynamicAggregation(R_time,tau,delta,alpha):
    alpha = list(alpha)
    delta = list(delta)
    ini = list(substract_list(list(mult_scalar([1,1,1,1],[tau])), delta))
    ini = add_scalar(ini,[1])
    fin = tau
    TW = list(exponential_weight(tau, delta, alpha))
    Rt = {}
    for k in range(n_att):
        Rt[k] = []
        for tt in range(ini[k],fin+1):
            Rt[k].append([])
            for j in range(len(R_time[tt])):
                Rt[k][-1].append(R_time[tt][j][k])
    R_agg = []
    for k in range(n_att):
        R_agg.append([])
        for j in range(len(Rt[k][0])):
            summ = 0
            for t in range(len(Rt[k])):
         
                summ += Rt[k][t][j] * TW[k][t]
            R_agg[-1].append(summ)
    return R_agg


criptomonedas = {}
valores = {}



def algo(n,tolerance,rho,Nombre):
    

    
    k=0
    index=0
    etiquetas = {}
    for i in range(1,n+1):
        cuenta_lineas = 0
        print("la n es ",n)
      # settings.MEDIA_DIR+'/datos/'+str(conf.Nombre)+'/'
        archivo = open(os.path.join(settings.MEDIA_DIR+'/datos/'+str(Nombre)+'/',""+str(i)+".csv"))
        for linea in archivo:
            linea = linea.replace(",","").replace("-","0")
            datos = linea.strip().split(";")
            if cuenta_lineas == 0:
                sigla = datos[-1]
                criptomonedas[k] = datos[0]
                etiquetas[k]=datos[0]
                k=k+1
               # print(datos[1])
                valores[sigla] = {}
            if cuenta_lineas == 1:
               # etiquetas[index]= datos[1]
                index=index+1
            elif datos[-1][-1].isdigit():
                periodo = "/".join([datos[0].split()[-1],datos[0].split()[0]])
                apertura,cierre,cap,vol = float(datos[1]),float(datos[4]),int(datos[-1]),int(datos[-2])
                high,low = float(datos[2]),float(datos[3])
                if periodo not in valores[sigla]:
                    valores[sigla][periodo] = []
                valores[sigla][periodo].append((cierre/apertura,high/low,vol,cap,cierre,apertura))
                aux = list(valores[sigla][periodo])
                aux.reverse()
    
                valores[sigla][periodo] = list(aux)
            cuenta_lineas += 1
        archivo.close()
    
    #print("lista",valores[sigla][periodo])
    months = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
    years = list(range(2017,2019))
    i = 1
    for divisa in list(valores.keys()):
        #archivo = open(os.path.join(settings.MEDIA_DIR+'/datos/'+str(Nombre)+'/',""+str(i)+".csv"))
        #archivo = open(os.path.join(settings.MEDIA_DIR+'/datos/'+'asd'+'/',""+'y'+str(i))+".txt","w")
        #archivo = open(""+"".join(["y",str(i)])+".txt","w")
        archivo = open(""+"".join(["y",str(i)])+".txt","w")
        archivo.write(divisa + "\n")
        for y in years:
            for m in months:
                llave = "/".join([str(y),m])
                if llave in valores[divisa]:
                    for tupla in valores[divisa][llave]:
                        archivo.write(" ".join(map(str,tupla)) + "\n")
        archivo.close()
        i += 1
        print("lista valor,",list(valores.keys()))
    alpha_ini = 10
    alpha = mult_scalar([1,1,1,1],[alpha_ini])

    max_vl_cambian=1
    delta = [1,1,1,1]
    #drift_detectado = [0,0,0,0]
    criptos = {}
    ids = {}
    n_resources = n

    W_user = [0.25, 0.25, 0.25, 0.25]
    criteria = ["least","most","least","least"]


    #_resources = 76
    resources = []
    for i in range(1,n_resources+1):
        resources.append("".join(["y",str(i)]))

    decision = []
    all_data = {}
    for resource in resources:
        t = 0
        data = open(os.path.join(settings.BASE_DIR,""+"-".join([resource + ".txt"])))
        for line in data:
            criptos[line.strip()] = []
            ids[int(resource[1:])] = line.strip()
            break
        for time in data: # time = [a1,a2,...,an] each line is a different t
            if t not in all_data:
                all_data[t] = []
    #        all_data[t].append(map(float,time.strip().split()[:-2]))
            all_data[t].append(list(map(float,time.strip().split()[:-4]))+[log(float(time.strip().split()[-4])+sys.float_info.min),
                                                                    log(float(time.strip().split()[-3])+sys.float_info.min)])
            criptos[line.strip()].append(tuple(map(float,time.strip().split()[-2:])))
            t += 1
        data.close()

#T = 5


    T = len(all_data)
 
    n_resources = len(all_data[0])
    n_att = len(all_data[0][0])
    print("la t es",n_resources)
    for t in range(T):
        decision.append([])
        for a in range(n_att):
            decision[-1].append([])
            for x in range(n_resources):
                decision[-1][-1].append(all_data[t][x][a])

    normal_decision = decision_normalization(format(decision))

    LV_time = {}
    R_time = {}
    for tt in range(T):
        LV_time[tt] = linguistic_values(normal_decision[tt],linguistic_var_number) 
    dws_f_obj = {}
    for tau in range(T):
        dws_f_obj[tau] = []
        for tt in range(tau+1):
            R_time[tt] = list(wa_operator(normal_decision[tt],criteria,user_required_level,LV_time[tt]))
            #print tt, R_time[tt]
        for k in range(n_att):
            bbool = 0
            for p in range(linguistic_var_number):
                bbool += drift_symptom(LV_time, k, p, tau, delta[k], rho, tolerance)[0]
            if bbool >= max_vl_cambian:
                alpha[k] = alpha_ini
                delta[k] = 1
            else:
                alpha[k] = 0.1
        R_agg = list(dynamicAggregation(R_time,tau,delta,alpha))
        for j in range(len(R_agg[0])):
            count = 0
            for k in range(n_att):
                count += R_agg[k][j] * W_user[k]
            dws_f_obj[tau].append(round(count,2))
        for jj in range(n_att):
            delta[jj] += 1

    aux = list(dws_f_obj.items())
    aux.sort()
    elegida2 = {}
    x=0
    for t,_ in aux:
        elegida2[x]=(max(dws_f_obj[t]))+1
        elegida = dws_f_obj[t].index(max(dws_f_obj[t]))+1
        x=x+1
   # print(elegida2)
    #for t in dws_f_obj:
        
    y = [0,1,0]
    atributo = 3
    f, ax = plt.subplots(2, sharex = True)
    axes = plt.gca()
    axes.set_xlim([0.9,1])
    for i in range(linguistic_var_number):
        ax[0].plot(LV_time[0][atributo][i],[0,1,0])
        ax[1].plot(LV_time[4][atributo][i],[0,1,0])
    ax[0].grid(True)
    ax[1].grid(True)
    #plt.show()
  
    plt.savefig('books_read.png')
   # f.savefig('a'+str(atributo+1)+'mf_zoom.eps')   #print ("Mes",t+1,":",dws_f_obj[t].index(max(dws_f_obj[t]))+1)
    return dws_f_obj
#print(algo())
#

   # 
    
