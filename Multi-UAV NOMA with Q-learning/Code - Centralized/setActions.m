function [ possibleActions ] = setActions(currentState )
% Find possible actions from state
possibleActions = [];
if currentState(1)>10
    if currentState(2)>10
        possibleActions = [possibleActions, 1];
    end
    
    if any(10:10:200==currentState(2))==0
        possibleActions = [possibleActions, 2];
    end
    
    if currentState(2)< 191
        possibleActions = [possibleActions, 3];
    end
    
    if any(1:10:191==currentState(2))==0
        possibleActions = [possibleActions, 4];
    end
end

if any(10:10:200==currentState(1))==0
    if currentState(2)>10
        possibleActions = [possibleActions, 5];
    end
    
    if any(10:10:200==currentState(2))==0
        possibleActions = [possibleActions, 6];
    end
    
    if currentState(2)< 191
        possibleActions = [possibleActions, 7];
    end
    
    if any(1:10:191==currentState(2))==0
        possibleActions = [possibleActions, 8];
    end
    
end

if currentState(1)< 191
    if currentState(2)>10
        possibleActions = [possibleActions, 9];
    end
    
    if any(10:10:200==currentState(2))==0
        possibleActions = [possibleActions, 10];
    end
    
    if currentState(2)< 191
        possibleActions = [possibleActions, 11];
    end
    
    if any(1:10:191==currentState(2))==0
        possibleActions = [possibleActions, 12];
    end
end

if any(1:10:191==currentState(1))==0
    if currentState(2)>10
        possibleActions = [possibleActions, 13];
    end
    
    if any(10:10:200==currentState(2))==0
        possibleActions = [possibleActions, 14];
    end
    
    if currentState(2)< 191
        possibleActions = [possibleActions, 15];
    end
    
    if any(1:10:191==currentState(2))==0
        possibleActions = [possibleActions, 16];
    end
end
end



