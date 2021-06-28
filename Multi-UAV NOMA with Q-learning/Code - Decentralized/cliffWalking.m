% Q-learning for 2-UAV NOMA in grid space (Decentralized Implementation)

% Algorithm parameters
alpha = 0.2;
epsilon = 0.6;
gamma = 0.9;
Q1 = rand(200, 4); % Q(S,a)
                        % a: left, up, right, down
Q2 = rand(200,4);
                     
% Frequency of state pairs at each drone
F1 = ones(200, 200);
F2 = ones(200, 200);

% Initialize expected return for impossible actions at borders of
% environment for each drone
Q1(1:10, 1)=NaN;
Q1(10:10:200, 2)=NaN;
Q1(191:200, 3)=NaN;
Q1(1:10:191, 4)=NaN;

Q2(1:10, 1)=NaN;
Q2(10:10:200, 2)=NaN;
Q2(191:200, 3)=NaN;
Q2(1:10:191, 4)=NaN;


% Q-learning loop
nEpisodes = 20000;
duration = 300;
sumRewards = zeros(nEpisodes, 1);

for i=1:1:nEpisodes
    currentState = [randi([1,200]), randi([1,200])];
    
    currentPossActions1 = setActions(currentState(1)); 
    currentPossActions2 = setActions(currentState(2));
    
    %%%%%%%%%%%%% Print %%%%%%%%%%%%
    disp(i);
    %%%%%%%%%%%%% Print %%%%%%%%%%%%
    
    for t = 1:1:duration
       
       currentActions = [policy(Q1(currentState(1),:), currentPossActions1, epsilon), ...
           policy(Q2(currentState(2),:), currentPossActions2, epsilon)];
       
       [nextState, rewards] = move(currentState, currentActions);
       
       %%%%%%%%%%%%%%%% Print %%%%%%%%%%%%%%%%
       sumRewards(i) = sumRewards(i) + rewards(1) + rewards(2);
       %%%%%%%%%%%%%%%% Print %%%%%%%%%%%%%%%%
       
       F1(nextState(1), nextState(2)) = F1(nextState(1), nextState(2)) + 1;
       F2(nextState(2), nextState(1)) = F2(nextState(2), nextState(1)) + 1;
       
       rewards(1) = rewards(1)*F1(nextState(1), nextState(2))/sum(F1(nextState(1),:));
       rewards(2) = rewards(2)*F2(nextState(2), nextState(1))/sum(F2(nextState(2),:));
       
       
       Q1(currentState(1), currentActions(1)) = ...
           Q1(currentState(1), currentActions(1)) + alpha*(rewards(1) +...
           gamma*max(Q1(nextState(1), :)) -  Q1(currentState(1), currentActions(1)));
       
       Q2(currentState(2), currentActions(2)) = ...
           Q2(currentState(2), currentActions(2)) + alpha*(rewards(2) +...
           gamma*max(Q2(nextState(2), :)) -  Q2(currentState(2), currentActions(2)));
      
       currentState = nextState;
       currentPossActions1 = setActions(currentState(1));
       currentPossActions2 = setActions(currentState(2));
       
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
    [~, currentAction1] = max(Q1(currentState(1), :));
    [~, currentAction2] = max(Q2(currentState(2), :));
    [nextState, rewards] = move(currentState, [currentAction1, currentAction2]);
    instSumRate(k) = rewards(1) + rewards(2);
    currentState = nextState;
    
end

figure();
plot(1:duration, instSumRate)


