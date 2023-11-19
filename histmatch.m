function [outputImage]  = histmatch(inputImage , reference_image)
    [~ , change_table_1] = my_histeq(inputImage) ;
    [~ , change_table_2] = my_histeq(reference_image) ;
    
    change_table = zeros(256,1);
    [h,w] = size(inputImage);
    outputImage = inputImage ;
    for i = 1:256
        target = change_table_1(i);
        last = 0 ;
        for j = 1:256
            if change_table_2(j) == target 
                change_table(i) = j - 1;
                break 
            else 
                if abs(change_table_2(j) - target) < abs(last - target)
                    change_table(i) = j - 1;
                    last =  change_table_2(j);
                end
            end
        end
    end
    for x = 1:h
        for y = 1:w
            outputImage(x,y) = change_table(inputImage(x,y)+1);
        end
    end
            





