######################################################################
#                   Simulation                                       #
######################################################################
"""
    In this script, we set up the simulation environment and run the 
    SARSA(lambda) algorithm until convergence.
"""

######################################################################
# Environment definition - Sutton's Grid World

from sarsa import *
import matplotlib.pyplot as plt

numOfStates = 4*3
setOfStates = []
for i in range(0,numOfStates):
    setOfStates.append(i)

numOfActions = 4
setOfActions = ['N', 'S', 'E', 'W']

numOfObservs = 6
setOfObservs = [0,1,2,3,4,5]


prob_o_s = np.zeros((len(setOfObservs), len(setOfStates)))

prob_o_s[0,0]=1
prob_o_s[2,1]=1
prob_o_s[2,2]=1
prob_o_s[5,3]=1
prob_o_s[3,4]=1
prob_o_s[0,6]=1
prob_o_s[4,7]=1
prob_o_s[0,8]=1
prob_o_s[2,9]=1
prob_o_s[2,10]=1
prob_o_s[1,11]=1

prob_s_sa = np.zeros((len(setOfStates),len(setOfStates), len(setOfActions)))
for i in range(4):
    for j in range(3):
        for a in range(4):
            if a==0:
                if j>0:
                    if i==0:
                        prob_s_sa[i+(j-1)*4, i+j*4, a] = 0.9
                        prob_s_sa[(i+1)+(j-1)*4, i+j*4, a] = 0.1
                    elif i==3:
                        prob_s_sa[i+(j-1)*4, i+j*4, a] = 0.9
                        prob_s_sa[(i-1)+(j-1)*4, i+j*4, a] = 0.1
                    else:
                        prob_s_sa[i+(j-1)*4, i+j*4, a] = 0.8
                        prob_s_sa[(i+1)+(j-1)*4, i+j*4, a] = 0.1
                        prob_s_sa[(i-1)+(j-1)*4, i+j*4, a] = 0.1
                else:
                    prob_s_sa[i+j*4, i+j*4, a] = 1
            elif a==1:
                if j<2:
                    if i==0:
                        prob_s_sa[i+(j+1)*4, i+j*4, a] = 0.9
                        prob_s_sa[(i+1)+(j+1)*4, i+j*4, a] = 0.1
                    elif i==3:
                        prob_s_sa[i+(j+1)*4, i+j*4, a] = 0.9
                        prob_s_sa[(i-1)+(j+1)*4, i+j*4, a] = 0.1
                    else:
                        prob_s_sa[i+(j+1)*4, i+j*4, a] = 0.8
                        prob_s_sa[(i+1)+(j+1)*4, i+j*4, a] = 0.1
                        prob_s_sa[(i-1)+(j+1)*4, i+j*4, a] = 0.1
                else:
                    prob_s_sa[i+j*4, i+j*4, a] = 1
            elif a==2:
                if i<3:
                    if j==0:
                        prob_s_sa[(i+1)+j*4, i+j*4, a] = 0.9
                        prob_s_sa[(i+1)+(j+1)*4, i+j*4, a] = 0.1
                    elif j==2:
                        prob_s_sa[(i+1)+j*4, i+j*4, a] = 0.9
                        prob_s_sa[(i+1)+(j-1)*4, i+j*4, a] = 0.1
                    else:
                        prob_s_sa[(i+1)+j*4, i+j*4, a] = 0.8
                        prob_s_sa[(i+1)+(j+1)*4, i+j*4, a] = 0.1
                        prob_s_sa[(i+1)+(j-1)*4, i+j*4, a] = 0.1
                else:
                    prob_s_sa[i+j*4, i+j*4, a] = 1
            else:
                if i>0:
                    if j==0:
                        prob_s_sa[(i-1)+j*4, i+j*4, a] = 0.9
                        prob_s_sa[(i-1)+(j+1)*4, i+j*4, a] = 0.1
                    elif j==2:
                        prob_s_sa[(i-1)+j*4, i+j*4, a] = 0.9
                        prob_s_sa[(i-1)+(j-1)*4, i+j*4, a] = 0.1
                    else:
                        prob_s_sa[(i-1)+j*4, i+j*4, a] = 0.8
                        prob_s_sa[(i-1)+(j+1)*4, i+j*4, a] = 0.1
                        prob_s_sa[(i-1)+(j-1)*4, i+j*4, a] = 0.1
                else:
                    prob_s_sa[i+j*4, i+j*4, a] = 1

for i in range(numOfStates):
    for j in range(numOfActions):
        if prob_s_sa[5, i, j]!=0:
            prob_s_sa[np.where(prob_s_sa[:,i,j]==np.max(prob_s_sa[:,i,j])), i, j]+=prob_s_sa[5, i, j]
            prob_s_sa[5, i, j]=0

for i in range(numOfStates):
    if i!=5 and i!=3 and i!=7:
        prob_s_sa[i,3,:]=1/11
        prob_s_sa[i,7,:]=1/11

lamda = 0.9
alpha = 0.01
gamma = 0.9

def r(s):
    if s==3:
        reward = 1
    elif s==7:
        reward = -1
    else:
        reward = -0.04
    return reward

######################################################################
# SARSA(lambda) deployment

sarsa = Sarsa(setOfStates, setOfObservs, setOfActions, prob_o_s, prob_s_sa, r, gamma, lamda, alpha)

s = 0
o = 0
a = 'S'
reward = np.zeros(300000)
r = 0
for t in range(300000):
    r_current, s_next, o_next, a_next = sarsa.step(s, o, a)
    sarsa.update(o, a, r_current, o_next, a_next)
    r += r_current
    s = s_next
    o = o_next
    a = a_next
    reward[t]=r/(t+1)



plt.plot([i for i in range(300000)], reward)
plt.show()

print(sarsa.Q_o_a[0,:])