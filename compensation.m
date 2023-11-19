function new_layers_angle = compensation(layers,old_layers_angle ,shift_num)
    weight = [0.1,0.4,0.4,0.1];
    weight = circshift(weight,[0 shift_num]);
    weight = weight' ;
    [H,W] = size(layers);
    layers = double(layers);
    new_layers_angle = double(old_layers_angle) ;
    for x = 2:H-1
        for y = 2:W-1
            %p0 = layers(x,y);
            %p1 = layers(x-1,y-1);
            %p2 = layers(x-1,y);
            %p3 = layers(x-1,y+1);
            %p4 = layers(x,y+1);
            %p5 = layers(x+1,y+1);
            %p6 = layers(x+1,y);
            %p7 = layers(x+1,y-1);
            %p8 = layers(x,y-1);
            P_0 = reshape(layers(x:x+1,y-1:y), [], 1)';
            P_1 = reshape(layers(x-1:x,y:y+1), [], 1)';
            P_2 = reshape(layers(x-1:x,y-1:y), [], 1)';
            P_3 = reshape(layers(x:x+1,y:y+1), [], 1)';
            dx = double(P_1*weight - P_0*weight) ;
            dy = double(P_3*weight - P_2*weight) ;
            new_layers_angle(x,y) = dy./dx ;
        end
    end
            
    
    