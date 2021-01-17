% Q-learning for Cliff Walking example of Barto & Sutton Book (pg. 132)

% Algorithm parameters
alpha = 0.2;
epsilon = 0.1;
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

% Q-learning loop
nEpisodes = 500;
sumRewards = zeros(nEpisodes, 1);

for i=1:1:nEpisodes
    currentState = [1, 1];
    currentPossActions = setActions(currentState);
    stop = 0;
   
    while stop==0
       currentAction = policy(Q(currentState(1), currentState(2),:), currentPossActions, epsilon);
       [nextState, reward] = move(currentState, currentAction);
       Q(currentState(1), currentState(2), currentAction) = ...
           Q(currentState(1), currentState(2), currentAction) + alpha*(reward +...
           max(Q(nextState(1), nextState(2), :)) -  Q(currentState(1), currentState(2), currentAction));
       currentState = nextState;
       currentPossActions = setActions(currentState);
       
       if currentState(1)==1 && currentState(2)==12
           stop = 1;
       end
       
       sumRewards(i) = sumRewards(i) + reward;
    end
    
end

plot(1:1:nEpisodes, sumRewards);


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
