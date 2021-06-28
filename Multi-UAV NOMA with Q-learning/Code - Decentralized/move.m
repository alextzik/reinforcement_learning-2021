function [nextStates, rewards] = move(currentStates, currentActions)
    % Given current Action and State, find next State and reward
    nextStates = currentStates;
    for i = 1:1:2
        if currentActions(i) == 1 
            nextStates(i) = currentStates(i) - 10;        
        elseif currentActions(i) == 2 
            nextStates(i) = currentStates(i) + 1;        
        elseif currentActions(i) == 3
            nextStates(i) = currentStates(i) + 10;       
        elseif currentActions(i) == 4 
            nextStates(i) = currentStates(i) - 1;    
        end
    end
    
    rewards = sumRate(nextStates);
    
    if (nextStates(1) == nextStates(2)) 
        rewards(1) = -5;
        rewards(2) = -5;
        nextStates(1) = currentStates(1);
        nextStates(2) = currentStates(2);
    end
    
end

