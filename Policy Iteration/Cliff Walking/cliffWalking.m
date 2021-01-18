% Policy Iteration for Cliff Walking example of Barto & Sutton Book (pg. 132)

% Algorithm parameters
gamma = 0.9;
V = rand(4, 12); % V(s)
policy = randi([1, 4], 4, 12);
% a=1: left, a=2: up, a=3: right, a=4: down

% Initialize expected return for terminal state
V(1,12) = 0;

% Initialize policy for each state
policy(1, :) = 2;
policy(:, 1) = 3;
policy(4, :) = 4;
policy(:, 12) = 1;

% Policy Iteration Loop
policy_stable = 0;
theta = 0.001;

while policy_stable==0
    
    % Policy Evaluation
    delta = 2*theta;
    while delta>theta
        delta = 0;
        for i=1:1:size(V,1)
            for j=1:1:size(V,2)
                if i==1 && j==size(V,2)
                    V(i,j) = 0;
                else
                    currentState = [i,j];
                    v = V(i, j);
                    [nextState, r] = move(currentState, policy(i,j));
                    V(i,j) = r+gamma*V(nextState(1), nextState(2));
                    delta = max([delta, abs(v-V(i,j))]);
                end
            end
        end
    end
    
    % Policy Iteration
    policy_stable = 1;
    for i=1:1:size(V,1)
        for j=1:1:size(V,2)
            currentState = [i,j];
            old_action = policy(i,j);
            currentPossActions = setActions(currentState);
            expReturn = zeros(length(currentPossActions),1);
            for l=1:1:length(currentPossActions)
                [nextState, reward] = move(currentState, currentPossActions(l));
                expReturn(l) = reward + gamma*V(nextState(1), nextState(2));
            end
            
            [val, indexAction] = max(expReturn);
            policy(i, j) = currentPossActions(indexAction);
            
            if old_action~=policy(i, j)
                policy_stable = 0;
            end  
            
        end
    end
    
end
