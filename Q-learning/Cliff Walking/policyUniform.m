function [ action ] = policyUniform( Qstate, currentPossActions,  epsilon )
    % Given state and state-action values for this state choose an action
    % from that state. Action is an integer in [1,4]. This is an
    % alternative policy for behavior determination that maintains the
    % exploration requirement. However, due to that uniform randonmess of
    % actions choices it does not terminate each episode fast.
    [~, greedyAction] = max(Qstate);
    nActions = length(currentPossActions);
    prob = rand;

    action = datasample(currentPossActions, 1);
    
end
