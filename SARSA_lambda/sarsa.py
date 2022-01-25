######################################################################
#                   SARSA(lambda)                                    #
######################################################################
"""
    This script contains the SARSA(lambda) implementation for a discrete 
    state-action-observation POMDP problem, as implemented in the paper
    Loch et al. Object oriented programming is used. 
    The class includes the POMDP's entities, an update function and a step transition function.
"""

import numpy as np
from random import choices

class Sarsa:

    # Constructor of Class
    def __init__(self, setOfStates, setOfObservs, setOfActions, prob_o_s, prob_s_sa, r, gamma, lamda, alpha):
        self.setOfStates = setOfStates # set of states as list of integers
        self.setOfObservs = setOfObservs # set of observations as list of integers
        self.setOfActions = setOfActions # set of actions as list of integers
        self.prob_o_s = prob_o_s # observation distribution as a 2D numpy array of size |S||O|
        self.prob_s_sa = prob_s_sa # transition distribution as a 3D numpy array of size |S||S||A|
        self.Q_o_a = np.zeros((len(self.setOfObservs),len(setOfActions))) # Q value table of size |O||A|
        self.reward = r
        self.eligibTraces = np.zeros((len(self.setOfObservs),len(setOfActions))) # initialization of eligibility traces for each (o,a) pair
        self.gamma = gamma # discount factor
        self.lamda = lamda # eligibility trace decay
        self.alpha = alpha # learning rate
        self.exploration = 0.2 # exploration rate in epsilon greedy exploration strategy

    # Q update
    """
        The following function updates the Q table based on a tuple (o_t, a_t, r_t, o_{t+1}, a_{t+1})
    """
    def update(self, o_current, a_current, r_current, o_next, a_next):
        
        # update eligibility traces
        self.eligibTraces *= self.gamma*self.lamda
        self.eligibTraces[self.setOfObservs.index(o_current), self.setOfActions.index(a_current)] = 1

        # update Q table
        self.Q_o_a += self.alpha*self.eligibTraces*(r_current+\
                        self.gamma*self.Q_o_a[self.setOfObservs.index(o_next), self.setOfActions.index(a_next)]-\
                        self.Q_o_a[self.setOfObservs.index(o_current), self.setOfActions.index(a_current)])

    # One-step transition
    """
        The following function performs a one-step update from the tuple (s_t, o_t, a_t) 
    """
    def step(self, s_current, o_current, a_current):
        s_next = choices(self.setOfStates, self.prob_s_sa[:,self.setOfStates.index(s_current), self.setOfActions.index(a_current)])[0]
        r_current = self.reward(s_next)
        o_next = choices(self.setOfObservs, self.prob_o_s[:,self.setOfStates.index(s_next)])[0]
        print(self.setOfActions[np.where(self.Q_o_a[self.setOfObservs.index(o_next),:]==np.max(self.Q_o_a[self.setOfObservs.index(o_next),:]))[0][0]])
        a_greedyNext = self.setOfActions[np.where(self.Q_o_a[self.setOfObservs.index(o_next),:]==np.max(self.Q_o_a[self.setOfObservs.index(o_next),:]))[0][0]]
        
        # create exploration distribution
        prob = []
        for i in range(len(self.setOfActions)):
            if i==self.setOfActions.index(a_greedyNext):
                prob.append(1-self.exploration)
            else:
                prob.append(self.exploration/(len(self.setOfActions)-1))
        
        a_next = choices(self.setOfActions, prob)[0]
        if self.exploration>0:
            self.exploration =- self.exploration/200000

        return r_current, s_next, o_next, a_next
