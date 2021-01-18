function [nextState, reward] = move(currentState, currentAction)
    % Given current Action and State, find next State and reward
    nextState = currentState;
    if currentState(1)==1 && currentState(2)>1 && currentState(2)<12
        nextState(1)=1;
        nextState(2)=1;
        reward=-100;
    else
        if currentAction == 1
            nextState(2) = currentState(2)-1;
        elseif currentAction == 2
            nextState(1) = currentState(1)+1;
        elseif currentAction == 3
            nextState(2) = currentState(2)+1;
        else
            nextState(1) = currentState(1)-1;
        end

        reward = -1;

        if nextState(1)==1 && nextState(2)>1 && nextState(2)<12
            nextState(1)=1;
            nextState(2)=1;
            reward=-100;
        end
    end
end

