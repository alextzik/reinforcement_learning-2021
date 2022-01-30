# reinforcement_learning-2021
Implementation of various reinforcement learning algorithms in examples from the book "Reinforcement Learning: An Introduction, by Sutton and Barto".

Up until now, the following algorithms have been implemented:
- Q-learning algorithm
  - Cliff Walking Example of pg. 132 of the book's 2nd edition.
    The algorithm implemented (with both epsilon-greedy and uniform behavioral policy) gives the optimal policy as:
    [up, right, right, right, right, right, right, right, right, right, right, right, down], which is expected given the following figure for the environment (v*(state=Start) is the maximum possible return starting from Start and it is achieved by following the optimal policy p*, i.e, the optimal path, from state Start; the max possible return from Start is evidently given by the shortest path from Start to Goal, because of the -1 reward and thus p* should reflect this) and the fact that the estimated Q reaches the optimal Q, given any behavioral policy (as long as it explores all state-action pairs). The uniform policy is however not used due to the greater time it requires to terminate in each episode, since it picks an action uniformly from the available actions at each step. Its online performance is also worse, due to this exploratory nature. It nevertheless manages to approximate Q* with the Q it updates. ![Online Performance](https://github.com/alextzik/reinforcement_learning-2021/blob/main/Figures/Rewards_Q_Cliff.png) ![Game's Environment](https://github.com/alextzik/reinforcement_learning-2021/blob/main/Figures/CliffEnvironment.png) 

    It is important to note that the grid-shaped problem formulation and Q-learning algorithm of this example are also present in various drone-trajectory planning problems with NOMA, for example as in the paper "Online Maneuver Design for UAV-Enabled NOMA Systems via Reinforcement Learning". The general outline of this code is therefore applicable in such problems as well.
    
- SARSA algorithm
  - Cliff Walking Example of pg. 132 of the book's 2nd edition. SARSA is an on-policy algorithm: it estimates the Q for the policy it follows and tries to move that policy towards the optimal policy. SARSA can only reach the optimal policy if the value epsilon is reduced to 0, as the algorithm progresses. If epsilon does not reach 0 and is constant, then SARSA only finds the best epsilon-greedy policy. In this project two versions of SARSA were implemented: (a) the simple version with constant epsilon=0.1 that converges to the best epsilon-greedy policy, (b) the version with epsilon decreasing in each episode with SARSA finally converging to the optimal policy. The optimal policy track (greedy track) in the two cases is: (a) [up, up, right, right, right, right, right, right, right, right, right, right, right, down, down], (b) [up, right, right, right, right, right, right, right, right, right, right, right, down]. In case (b) we reach the optimal policy Q (greedy) and thus when the optimal greedy policy is applied the true optimal path is derived. In (a) Q has not reached the optimal policy Q and thus when the optimal policy is applied, the track is different, moving towards the safer path of the figure above. In the following figure, the sum of rewards per episode is shown for the two cases. The implementation (a) exhibits worse online performance due to the constant exploratory nature, while (b) loses its exploratory inclination as the number of episodes increases. ![Online Performance](https://github.com/alextzik/reinforcement_learning-2021/blob/main/Figures/Rewards_Sarsa_Cliff.png)
  - SARSA(lambda) on the partially observable 4x3 grid world described in the paper "Using Eligibility Traces to Find the Best Memoryless Policy in Partially Observable Markov Decision Processes", by Loch et al. The grid world described in the paper is based on the 4x3 grid world from the "Artificial Intelligence: A Modern Approach", pg. 648. There are two terminal cells/states and one obstacle cell. The agent is able to only observe if it has a wall immediatley to its left or to its right. This results in different cells/states appearing identical to the agent. For each action that does not lead the agent to a terminal state, the agent receives a reward of -0.04. If the agent reaches the goal state it receives a reward of -1 and if it reaches the penalty state it receives a reward of -1. The agent can move up, down, right or left and with a probability of 0.8 it will reach its desired cell. With a probability of 0.1 it will move to a perpendicular direction. Impossible transitions lead to no movement with the same probability. We assume that if the agent reaches a terminal state it transitions to the initial state to start a new episode. SARSA(lambda) was implemented for this POMDP. Hence the Q function assigns a value to observation, action pairs. The resulting greedy policy is: (0, N), (1, W), (2,E), (3,N) and its average reward (in the same set-up as in Loch et al.) is shown below: ![SARSA lambda](https://github.com/alextzik/reinforcement_learning-2021/blob/main/Figures/SARSA_l.png)
  
- Policy Iteration
  - Cliff Walking Example of pg. 132 of the book's 2nd edition. Policy Iteration is a Dynamic Programming reinforcement learning algorithm that is based on the improvement of the value function of a state via estimations of the value function for upcoming states. It therefore does not learn from experiece, but rather works in the state space by constantly updating the policy and the value function via previous estimates. It requires knowledge of the environment's model. In this example, this is easy to determine, since given any state and an action, there is only one possible next state and one possible reward. In the following figure, the optimal policy determined via Policy Iteration is shown. It is the same policy determined with the previous two algorithms for this example.  ![Optimal Policy](https://github.com/alextzik/reinforcement_learning-2021/blob/main/Figures/PI_OptimalPolicy.png) By running Policy Iteration, SARSA and Q-learning for the Cliff Walking example we are able to observe the consistency of the three techniques by looking at the V output table. This V is actualy V* (the optimal value function) and in Q-learning and SARSA (where only Q* is the output of the algorithms) it can be easily obtained by implementing the equation of pg. 63 (v*(s) = arg max_{a} q*(s,a)). In the existing code, this is only implemented in the Q-learning file (lines 66-72), but it applies for SARSA as well.

