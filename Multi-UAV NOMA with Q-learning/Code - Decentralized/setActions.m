function [ possibleActions ] = setActions(currentState )
% Find possible actions from state
    possibleActions = [];
    if currentState>10
        possibleActions = [possibleActions, 1];


    end

    if any(10:10:200==currentState)==0
        possibleActions = [possibleActions, 2];


    end

    if currentState < 191

        possibleActions = [possibleActions, 3];


    end

    if any(1:10:191==currentState)==0

        possibleActions = [possibleActions, 4];

    end
end



