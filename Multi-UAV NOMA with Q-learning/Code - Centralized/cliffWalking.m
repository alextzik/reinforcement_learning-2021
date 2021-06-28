% Q-learning for 2-UAV NOMA in grid space

% Algorithm parameters
alpha = 0.2;
epsilon = 0.6;
gamma = 0.9;
Q = rand(200, 200, 16); % Q(S,a)
                        % a: left, up, right, down
                     
% Initialize expected return for impossible actions at borders of
% environment for each drone
Q(1:10,:, 1:4)=NaN;
Q(10:10:200, :, 5:8)=NaN;
Q(191:200, :, 9:12)=NaN;
Q(1:10:191, :, 13:16)=NaN;

Q(:, 1:10, 1:4:13)=NaN;
Q(:, 10:10:200, 2:4:14)=NaN;
Q(:, 191:200, 3:4:15)=NaN;
Q(:, 1:10:191, 4:4:16)=NaN;


% Q-learning loop
nEpisodes = 20000;
duration = 300;
sumRewards = zeros(nEpisodes, 1);

for i=1:1:nEpisodes
    currentState = [randi([1,200]), randi([1,200])];
    currentPossActions = setActions(currentState);
    disp(i);
    for t = 1:1:duration
       currentAction = policy(Q(currentState(1), currentState(2),:), currentPossActions, epsilon);
       
       [nextState, reward] = move(currentState, currentAction);
       
       Q(currentState(1), currentState(2), currentAction) = ...
           Q(currentState(1), currentState(2), currentAction) + alpha*(reward +...
           gamma*max(Q(nextState(1), nextState(2), :)) -  Q(currentState(1), currentState(2), currentAction));
      
       currentState = nextState;
       currentPossActions = setActions(currentState);
       
       sumRewards(i) = sumRewards(i) + reward;
    end
    disp(sumRewards(i));
end


plot(1:nEpisodes, sumRewards);

%%
% Optimal path starting from an inefficient formation.
currentState = [191, 200];
optimalPath = [];
instSumRate = zeros(duration, 1);

for k = 1:1:duration
    optimalPath = [optimalPath; currentState];
    [~, currentAction] = max(Q(currentState(1), currentState(2), :));
    [nextState, reward] = move(currentState, currentAction);
    instSumRate(k) = reward;
    currentState = nextState;
    
end





