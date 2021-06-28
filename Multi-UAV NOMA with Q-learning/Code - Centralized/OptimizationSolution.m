% Find the optimal solution for the two-cluster problem via optimization
optimalPositions = zeros(2,1);
maxVal = zeros(2,1);
user_Xs = [4, 5, 6; 14, 15, 16];


for i=1:1:2
    
    for k =1:1:200
        val = 0;
       
        uav_Y = mod(k, 10);
        if (uav_Y==0)
            uav_Y = 10;
        end
        uav_X = (k-uav_Y)/10 + 1;
        uav_Y = 25 + (uav_Y-1)*50;
        uav_X = 25 + (uav_X-1)*50;
        
        for user_Y = 3:7
            for user_X = user_Xs(i,:)
                y = 25 + (user_Y-1)*50;
                x = 25 + (user_X-1)*50;
                
                d = sqrt((y-uav_Y)^2+(x-uav_X)^2+100^2);
                
                val = val + 0.7*1/(d^2);
                
            end           
        end
        
        if (val >= maxVal)
            maxVal = val;
            optimalPositions(i) = k;
        end
    end
    
end

%%
% Testing Phase
duration = 300;

% Position of each drone
yA = mod(optimalPositions(1), 10);
if (yA==0)
     yA = 10;
end
xA = (optimalPositions(1)-yA)/10 + 1;
yA = 25 + (yA-1)*50;
xA = 25 + (xA-1)*50;
    
yB = mod(optimalPositions(2), 10);
if (yB==0)
     yB = 10;
end
xB = (optimalPositions(2)-yB)/10 + 1;
yB = 25 + (yB-1)*50;
xB = 25 + (xB-1)*50;

instSumRate = zeros(duration, 1);

for t=1:1:duration
    snrA = 0;
    snrB = 0;
    prob = unifrnd(0, 1, 10, 20);
    
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
    instSumRate(t) = log2(1+141.24*snrA)+log2(1+141.24*snrB);

end