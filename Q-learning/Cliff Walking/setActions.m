function [ possibleActions ] = setActions( currentState )
    % Find possible actions from state
    possibleActions = [];
    if currentState(1)~=1
        possibleActions = [possibleActions, 4];
    end
    
    if currentState(1)~=4
        possibleActions = [possibleActions, 2];
    end

    if currentState(2)~=1
        possibleActions = [possibleActions, 1];
    end
    
    if currentState(2)~=12
        possibleActions = [possibleActions, 3];
    end

end

