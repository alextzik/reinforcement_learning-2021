# reinforcement_learning-2021
Implementation of various reinforcement learning algorithms in examples obtained from the book "Reinforcement Learning: An Introduction", by Sutton and Barto.

Up until now, the following algorithms have been implemented:
- Q-learning algorithm
  - Cliff Walking Example of pg. 132 of the book's 2nd edition.
    The algorithm implemented (with both epsilon-greedy and uniform behaivioral policy) gives the optimal policy as:
    [up, right, right, right, right, right, right, right, right, right, right, right, down], which is expected given the following figure for the environment and the fact that the estimated Q reaches the optimal Q, given any behavioral policy (as long as it explores all state-action pairs). The uniform policy is howver not used due to the greater time it requires to terminate in each episode, since it picks an action uniformly from the available actions at each step. Its online performance is also worse, due to this exploratory nature. It nevertheless manages to approximate Q* with the Q it updates. ![Online Performance](https://github.com/alextzik/reinforcement_learning-2021/blob/main/Figures/Rewards_Q_Cliff.png) ![Game's Environment](https://github.com/alextzik/reinforcement_learning-2021/blob/main/Figures/CliffEnvironment.png)

