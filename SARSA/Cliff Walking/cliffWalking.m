% SARSA for Cliff Walking example of Barto & Sutton Book (pg. 132)

% Algorithm parameters
alpha = 0.1;
epsilon = 0.1; %This needs to reach 0 for SARSA to converge to optimal policy
gamma = 0.9;
Q = rand(4, 12, 4); % Q(S,a)
                     % a=1: left, a=2: up, a=3: right, a=4: down
% Initialize expected return for impossible actions at borders of environment
Q(1,:, 4)=NaN;
Q(4, :, 2)=NaN;
Q(:, 1, 1)=NaN;
Q(:, 12, 3)=NaN;
% Initialize expected return of terminal state
Q(1, 12, :)=0;

% SARSA loop
nEpisodes = 500;
sumRewards = zeros(nEpisodes, 1);

for i=1:1:nEpisodes
    epsilon=0.1/i; % required in order for e-greedy policy to converge to greedy and thus Q to converge to Q of optimal.
    currentState = [1, 1];
    currentPossActions = setActions(currentState);
    currentAction = policy(Q(currentState(1), currentState(2),:), currentPossActions, epsilon);
    
    stop = 0;
   
    disp(i);
    
    while stop==0
       [nextState, reward] = move(currentState, currentAction);
       nextPossActions = setActions(nextState);
       nextAction = policy(Q(nextState(1), nextState(2),:), nextPossActions, epsilon);
       
       Q(currentState(1), currentState(2), currentAction) = ...
           Q(currentState(1), currentState(2), currentAction) + alpha*(reward +...
           gamma*Q(nextState(1), nextState(2), nextAction) -  Q(currentState(1), currentState(2), currentAction));
       
       currentState = nextState;
       currentAction = nextAction;
       
       if currentState(1)==1 && currentState(2)==12
           stop = 1;
       end
      
       sumRewards(i) = sumRewards(i) + reward;
    
    end
    
end

hold on;
plot(1:1:nEpisodes, sumRewards, 'b');

% Find optimal policy, given optimal value-action function
stop = 0;
currentState = [1, 1];
optimalPolicy = [];


while stop==0
   [~, currentAction] = max(Q(currentState(1), currentState(2), :));
   optimalPolicy = [optimalPolicy, currentAction];
   currentState = move(currentState, currentAction);

    if currentState(1)==1 && currentState(2)==12
           stop = 1;
    end
end

disp(optimalPolicy);
