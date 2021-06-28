function [ rewards ] = sumRate( State )
    % This function returns the reward for the centralized 2-UAV problem
    % The reward is the sum-rate achieved by the two drones
    
    rewards = zeros(2,1);
    % Grid probabilities for user appearance
    prob = unifrnd(0, 1, 10, 20);
    
    % Position of each drone
    yA = mod(State(1), 10);
    if (yA==0)
        yA = 10;
    end
    xA = (State(1)-yA)/10 + 1;
    yA = 25 + (yA-1)*50;
    xA = 25 + (xA-1)*50;
    
    yB = mod(State(2), 10);
    if (yB==0)
        yB = 10;
    end
    xB = (State(2)-yB)/10 + 1;
    yB = 25 + (yB-1)*50;
    xB = 25 + (xB-1)*50;
    
    
    % Calculate sum-rate
    % Each user is assigned to the drone that is closer, because 
    % log(a+b)+log(c)>log(a)+log(c+d) for b>d
    snrA = 0;
    snrB = 0;
    
    for i = 3:1:7
        for j = 4:1:16
            y = 25 + (i-1)*50;
            x = 25 + (j-1)*50;
            
            dA = sqrt((y-yA)^2+(x-xA)^2+100^2);
            dB = sqrt((y-yB)^2+(x-xB)^2+100^2);
            
            if prob(i,j)<=0.7 && (j<=6 || j>=14) % For check consider two clusters. In the optimal solution, one drone to each cluster.
                if  dA <= dB
                    snrA = snrA + 1/(dA^2);
                else
                    snrB = snrB + 1/(dB^2);
                end
            end
            
            
        end
    end

    % P = 23 dBm, noise = -80 dBm -> constant = 141.24
    rewards(1) = log2(1+141.24*snrA);
    rewards(2) = log2(1+141.24*snrB);

end

