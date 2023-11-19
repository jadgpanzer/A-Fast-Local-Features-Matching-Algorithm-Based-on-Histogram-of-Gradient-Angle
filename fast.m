function [keypoints , numKeypoints] = fast(image, threshold)
    % FAST feature points detection
    [M,N,D] = size(image);
    if D == 3 
        image = rgb2gray(image); 
    end  
    mask = [0 0 1 1 1 0 0;...  
            0 1 0 0 0 1 0;...  
            1 0 0 0 0 0 1;...  
            1 0 0 0 0 0 1;...  
            1 0 0 0 0 0 1;...  
            0 1 0 0 0 1 0;...  
            0 0 1 1 1 0 0];   
    mask = uint8(mask);
    numPixels = (M - 18) * (N - 18);
    keypoints = zeros(numPixels, 2);
    numKeypoints = 0;
    
    for i = 10:M-9  
        for j = 10:N-9
            delta1 = abs(image(i-3,j) - image(i,j)) > threshold;  
            delta9 = abs(image(i+3,j) - image(i,j)) > threshold;  
            delta5 = abs(image(i,j+3) - image(i,j)) > threshold;  
            delta13 = abs(image(i,j-3) - image(i,j)) > threshold;  
            
            if sum([delta1 delta9 delta5 delta13]) >= 3
                block = image(i-3:i+3,j-3:j+3);  
                block = block .* mask; 
                pos = find(block);  
                block1 = abs(block(pos) - image(i,j)) / threshold;  
                block2 = floor(block1);
                res = find(block2);  
                
                if size(res,1) >= 12
                   
                    numKeypoints = numKeypoints + 1;
                    keypoints(numKeypoints, :) = [j, i];
                    
                end  
            end  
        end  
    end  
    
    keypoints = keypoints(1:numKeypoints-1, :);
end
