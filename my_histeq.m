function [outputImage , change_table]  = my_histeq(inputImage)
    outputImage = inputImage ;
    image_size = size(inputImage);
    h = image_size(1) ; w = image_size(2) ;
    image_hist = zeros(256,1);
    for x = 1:h
        for y = 1:w
            image_hist(inputImage(x,y)+1) = image_hist(inputImage(x,y)+1) + 1;
        end
    end
    change_table = zeros(256,1) ;
    L = 256 ;
    pixel_number = h*w ;
    for p = 1:256
        sum = 0 ;
        for n = 1:p
            sum = sum + image_hist(n) ;
        end
        change_table(p) = round((L/pixel_number)*sum);
    end
        
    for x = 1:h
        for y = 1:w
            outputImage(x,y) = change_table(inputImage(x,y)+1);
        end
    end