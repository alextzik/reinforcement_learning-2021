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

# Set of States
numOfStates = 4*3
setOfStates = []
for i in range(0,numOfStates):
    setOfStates.append(i)

# Set of Actions
numOfActions = 4
setOfActions = ['N', 'S', 'E', 'W']

# Set of Observations
numOfObservs = 6
setOfObservs = [0,1,2,3,4,5]

# Observation Distribution
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

# Transition Distribution
prob_s_sa = np.zeros((len(setOfStates),len(setOfStates), len(setOfActions)))
for i in range(4):
    for j in range(3):
        for a in range(4):
            if a==0:
                if j>0:
                    if i==0:
                        prob_s_sa[i+(j-1)*4, i+j*4, a] = 0.8
                        prob_s_sa[(i+1)+j*4, i+j*4, a] = 0.1
                        prob_s_sa[i+j*4, i+j*4, a] = 0.1
                    elif i==3:
                        prob_s_sa[i+(j-1)*4, i+j*4, a] = 0.8
                        prob_s_sa[(i-1)+j*4, i+j*4, a] = 0.1
                        prob_s_sa[i+j*4, i+j*4, a] = 0.1
                    else:
                        prob_s_sa[i+(j-1)*4, i+j*4, a] = 0.8
                        prob_s_sa[(i+1)+j*4, i+j*4, a] = 0.1
                        prob_s_sa[(i-1)+j*4, i+j*4, a] = 0.1
                else:
                    if i==0:
                        prob_s_sa[(i+1)+j*4, i+j*4, a] = 0.1
                        prob_s_sa[i+j*4, i+j*4, a] = 0.9
                    elif i==3:
                        prob_s_sa[(i-1)+j*4, i+j*4, a] = 0.1
                        prob_s_sa[i+j*4, i+j*4, a] = 0.9
                    else:
                        prob_s_sa[i+j*4, i+j*4, a] = 0.8
                        prob_s_sa[(i+1)+j*4, i+j*4, a] = 0.1
                        prob_s_sa[(i-1)+j*4, i+j*4, a] = 0.1
            elif a==1:
                if j<2:
                    if i==0:
                        prob_s_sa[i+(j+1)*4, i+j*4, a] = 0.8
                        prob_s_sa[(i+1)+j*4, i+j*4, a] = 0.1
                        prob_s_sa[i+j*4, i+j*4, a] = 0.1
                    elif i==3:
                        prob_s_sa[i+(j+1)*4, i+j*4, a] = 0.8
                        prob_s_sa[(i-1)+j*4, i+j*4, a] = 0.1
                        prob_s_sa[i+j*4, i+j*4, a] = 0.1
                    else:
                        prob_s_sa[i+(j+1)*4, i+j*4, a] = 0.8
                        prob_s_sa[(i+1)+j*4, i+j*4, a] = 0.1
                        prob_s_sa[(i-1)+j*4, i+j*4, a] = 0.1
                else:
                    if i==0:
                        prob_s_sa[(i+1)+j*4, i+j*4, a] = 0.1
                        prob_s_sa[i+j*4, i+j*4, a] = 0.9
                    elif i==3:
                        prob_s_sa[(i-1)+j*4, i+j*4, a] = 0.1
                        prob_s_sa[i+j*4, i+j*4, a] = 0.9
                    else:
                        prob_s_sa[(i+1)+j*4, i+j*4, a] = 0.1
                        prob_s_sa[(i-1)+j*4, i+j*4, a] = 0.1
                        prob_s_sa[i+j*4, i+j*4, a] = 0.8
            elif a==2:
                if i<3:
                    if j==0:
                        prob_s_sa[(i+1)+j*4, i+j*4, a] = 0.8
                        prob_s_sa[i+(j+1)*4, i+j*4, a] = 0.1
                        prob_s_sa[i+j*4, i+j*4, a] = 0.1
                    elif j==2:
                        prob_s_sa[(i+1)+j*4, i+j*4, a] = 0.8
                        prob_s_sa[i+(j-1)*4, i+j*4, a] = 0.1
                        prob_s_sa[i+j*4, i+j*4, a] = 0.1
                    else:
                        prob_s_sa[(i+1)+j*4, i+j*4, a] = 0.8
                        prob_s_sa[i+(j+1)*4, i+j*4, a] = 0.1
                        prob_s_sa[i+(j-1)*4, i+j*4, a] = 0.1
                else:
                    if j==0:
                        prob_s_sa[i+(j+1)*4, i+j*4, a] = 0.1
                        prob_s_sa[i+j*4, i+j*4, a] = 0.9
                    elif j==2:
                        prob_s_sa[i+(j-1)*4, i+j*4, a] = 0.1
                        prob_s_sa[i+j*4, i+j*4, a] = 0.9
                    else:
                        prob_s_sa[i+(j+1)*4, i+j*4, a] = 0.1
                        prob_s_sa[i+(j-1)*4, i+j*4, a] = 0.1
                        prob_s_sa[i+j*4, i+j*4, a] = 0.9                
            else:
                if i>0:
                    if j==0:
                        prob_s_sa[(i-1)+j*4, i+j*4, a] = 0.8
                        prob_s_sa[i+(j+1)*4, i+j*4, a] = 0.1
                        prob_s_sa[i+j*4, i+j*4, a] = 0.1
                    elif j==2:
                        prob_s_sa[(i-1)+j*4, i+j*4, a] = 0.8
                        prob_s_sa[i+(j-1)*4, i+j*4, a] = 0.1
                        prob_s_sa[i+j*4, i+j*4, a] = 0.1
                    else:
                        prob_s_sa[(i-1)+j*4, i+j*4, a] = 0.8
                        prob_s_sa[i+(j+1)*4, i+j*4, a] = 0.1
                        prob_s_sa[i+(j-1)*4, i+j*4, a] = 0.1
                else:
                    if j==0:
                        prob_s_sa[i+(j+1)*4, i+j*4, a] = 0.1
                        prob_s_sa[i+j*4, i+j*4, a] = 0.9
                    elif j==2:
                        prob_s_sa[i+(j-1)*4, i+j*4, a] = 0.1
                        prob_s_sa[i+j*4, i+j*4, a] = 0.9
                    else:
                        prob_s_sa[i+j*4, i+j*4, a] = 0.8
                        prob_s_sa[i+(j+1)*4, i+j*4, a] = 0.1
                        prob_s_sa[i+(j-1)*4, i+j*4, a] = 0.1

# Make it impossible to transition to cell 5
for i in range(numOfStates):
    for j in range(numOfActions):
        if prob_s_sa[5, i, j]!=0:
            prob_s_sa[i, i, j] += prob_s_sa[5, i, j]
            prob_s_sa[5, i, j] = 0

# From goal and penalty state only able to transition to start state (8)
for i in range(numOfStates):
    prob_s_sa[i,3,:]=0
    prob_s_sa[i,7,:]=0
prob_s_sa[8,3,:]=1
prob_s_sa[8,7,:]=1

# Parameter Initialization
lamda = 0.9
alpha = 0.01
gamma = 1

# Reward function
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
reward = np.zeros(300)
numOfTrials = 30

for i_ in range(numOfTrials): # run the training for numOfTrials to smooth data
    # define sarsa instance
    sarsa = Sarsa(setOfStates, setOfObservs, setOfActions, prob_o_s, prob_s_sa, r, gamma, lamda, alpha)
    
    # set initial state, observation and action
    s = 8
    o = 0
    a = sarsa.setOfActions[np.where(sarsa.Q_o_a[sarsa.setOfObservs.index(o),:]==np.max(sarsa.Q_o_a[sarsa.setOfObservs.index(o),:]))[0][0]]

    # run for 300000 steps
    for t_ in range(300000):
        # perform a step
        r_current, s_next, o_next, a_next, a_greedyNext = sarsa.step(s, o, a)

        # update Q values 
        sarsa.update(o, a, r_current, o_next, a_next)

        # update current state, observation and action
        s = s_next
        o = o_next
        a = a_next

        # zero eligibility trace at end of episode
        if s==3 or s==7:
            sarsa.zero_elig_trace()

        print(t_)

        # deploy greedy strategy every 1000 steps
        if t_%1000==0:
            ret = 0
            steps = 0
            for j_ in range(101): # 101 runs 
                count = 1
                s_ = 8
                o_ = 0
                a_ = sarsa.setOfActions[np.where(sarsa.Q_o_a[sarsa.setOfObservs.index(o_),:]==np.max(sarsa.Q_o_a[sarsa.setOfObservs.index(o_),:]))[0][0]]
                steps += 1
                
                # perform each run until we reach a terminal state or we reach maximum number of steps per episode (count)
                while s_!=3 and s_!=7 and count<101:
                    r_current, s_next, o_next, a_next, a_greedyNext = sarsa.step(s_, o_, a_)
                    s_ = s_next
                    o_ = o_next
                    a_ = a_greedyNext
                    ret += r_current
                    count +=1
                    steps +=1

            # update reward with the average return of the 101 trials for this run
            reward[int(t_/1000)] += ret/steps
    
reward /= (numOfTrials)

# Print policy
print(sarsa.Q_o_a)
for o in range(len(setOfObservs)-2):
    print(o, setOfActions[np.where(sarsa.Q_o_a[sarsa.setOfObservs.index(o),:]==np.max(sarsa.Q_o_a[sarsa.setOfObservs.index(o),:]))[0][0]])


# Plot greedy policy's reward 
plt.plot([1000*i for i in range(300)], reward)
plt.xlabel("Number of Actions")
plt.ylabel("Average Reward per Action of Greedy Policy")
plt.show()
