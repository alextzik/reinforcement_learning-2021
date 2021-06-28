function [nextState, reward] = move(currentState, currentAction)
    % Given current Action and State, find next State and reward
    nextState = currentState;
    if currentAction >= 1 && currentAction<=4
        nextState(1) = currentState(1)-10;
        
        if currentAction == 1
            nextState(2) = currentState(2)-10;
        elseif currentAction == 2
            nextState(2) = currentState(2)+1;
        elseif currentAction == 3
            nextState(2) = currentState(2)+10;
        else
            nextState(2) = currentState(2)-1;
        end
        
    elseif currentAction >= 5 && currentAction<=8
        nextState(1) = currentState(1)+1;
        
        if currentAction == 5
            nextState(2) = currentState(2)-10;
        elseif currentAction == 6
            nextState(2) = currentState(2)+1;
        elseif currentAction == 7
            nextState(2) = currentState(2)+10;
        else
            nextState(2) = currentState(2)-1;
        end
        
    elseif currentAction >= 9 && currentAction<=12
        nextState(1) = currentState(1)+10;
        
        if currentAction == 9
            nextState(2) = currentState(2)-10;
        elseif currentAction == 10
            nextState(2) = currentState(2)+1;
        elseif currentAction == 11
            nextState(2) = currentState(2)+10;
        else
            nextState(2) = currentState(2)-1;
        end
        
    elseif currentAction >= 13 && currentAction<=16
        nextState(1) = currentState(1)-1;
        
        if currentAction == 13
            nextState(2) = currentState(2)-10;
        elseif currentAction == 14
            nextState(2) = currentState(2)+1;
        elseif currentAction == 15
            nextState(2) = currentState(2)+10;
        else
            nextState(2) = currentState(2)-1;
        end
    
    end

    
    reward = sumRate(nextState);
    
    if (nextState(1) == nextState(2)) 
        reward = -50;
        nextState(1) = currentState(1);
        nextState(2) = currentState(2);
    end
    
end

