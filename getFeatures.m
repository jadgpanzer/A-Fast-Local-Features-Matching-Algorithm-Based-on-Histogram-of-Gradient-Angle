function [image_features , key_points] = getFeatures(input_image ,is_smoothing,is_enhancement)
    % Obtain Features of the Given Image 
    % is_smothing : use edge preserving filtering or not
    % is_enhancement : use edge enhancement or not
    
    %Some parameters for image processing
    gamma = 0.6 ;
    threshold = 12;
    lambda = 1; 
    sigma = 0.2 ;
    rotation_match_angle = 180 ;

    input_image = rgb2gray(input_image);
    image  = gammaCorrection(input_image,gamma);
    
    if is_smoothing == true
        image  = edgePreservingSmoothing(image,lambda, sigma);
    end
    if is_enhancement == true
        image = edgeEnhancement(image);
    end
    [key_points,~] = fast(image,threshold);
    addMarkers(input_image, key_points);
    
    rotation_matrix = rotationMatrix(image,rotation_match_angle);

    image_features = getImageFeatures(key_points, image ,rotation_matrix);