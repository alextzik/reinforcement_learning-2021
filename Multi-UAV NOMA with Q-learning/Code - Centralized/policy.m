function [ action ] = policy( Qstate, currentPossActions,  epsilon )
    % Given state and state-action values for this state choose an action
    % from that state. Action is an integer in [1,16].
    
    [~, greedyAction] = max(Qstate);
    
    
    nActions = length(currentPossActions);
    prob = rand;
    if prob < 1-epsilon
        action = greedyAction;
    else
        action = datasample(currentPossActions, 1);
    end
    
end

