# reinforcement_learning-2021
Implementation of various reinforcement learning algorithms in examples from the book "Reinforcement Learning: An Introduction, by Sutton and Barto".

Up until now, the following algorithms have been implemented:
- Q-learning algorithm
  - Cliff Walking Example of pg. 132 of the book's 2nd edition.
    The algorithm implemented (with both epsilon-greedy and uniform behavioral policy) gives the optimal policy as:
    [up, right, right, right, right, right, right, right, right, right, right, right, down], which is expected given the following figure for the environment and the fact that the estimated Q reaches the optimal Q, given any behavioral policy (as long as it explores all state-action pairs). The uniform policy is however not used due to the greater time it requires to terminate in each episode, since it picks an action uniformly from the available actions at each step. Its online performance is also worse, due to this exploratory nature. It nevertheless manages to approximate Q* with the Q it updates. ![Online Performance](https://github.com/alextzik/reinforcement_learning-2021/blob/main/Figures/Rewards_Q_Cliff.png) ![Game's Environment](https://github.com/alextzik/reinforcement_learning-2021/blob/main/Figures/CliffEnvironment.png)
    
- SARSA algorithm
  - Cliff Walking Example of pg. 132 of the book's 2nd edition. SARSA is an on-policy algorithm: it estimates the Q for the policy it follows and tries to move that policy towards the optimal policy. SARSA can only reach the optimal policy if the value epsilon is reduced to 0, as the algorithm progresses. If epsilon does not reach 0 and is constant, then SARSA only finds the best epsilon-greedy policy. In this project two versions of SARSA were implemented: (a) the simple version with constant epsilon=0.1 that converges to the best epsilon-greedy policy, (b) the version with epsilon decreasing in each episode with SARSA finally converging to the optimal policy. The optimal policy track (greedy track) in the two cases is: (a) [up, up, right, right, right, right, right, right, right, right, right, right, right, down, down], (b) [up, right, right, right, right, right, right, right, right, right, right, right, down]. In case (b) we reach the optimal policy Q (greedy) and thus when the optimal greedy policy is applied the true optimal path is derived. In (a) Q has not reached the optimal policy Q and thus when the optimal policy is applied, the track is different, moving towards the safer path of the figure above. In the following figure, the sum of rewards per episode is shown for the two cases. The implementation (a) exhibits worse online performance due to the constant exploratory nature, while (b) loses its exploratory inclination as the number of episodes increases. ![Online Performance](https://github.com/alextzik/reinforcement_learning-2021/blob/main/Figures/Rewards_Sarsa_Cliff.png)

