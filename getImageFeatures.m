function image_features = getImageFeatures(key_points,image , rotation_matrix)
    block_size = 9 ;
    cell_size = (block_size-1)/2;
    [length , ~] = size(key_points);
    image_features = zeros(length,4*3*3*8);
    image_angel = gradientAngle(image);
    for i = 1 : length
        y = key_points(i,1) ;
        x = key_points(i,2) ;
        block_angle = image_angel(x-cell_size:x+cell_size,y-cell_size:y+cell_size);
        block_image = image(x-cell_size:x+cell_size,y-cell_size:y+cell_size) ;
        block_rotation_matrix = rotation_matrix(x-cell_size:x+cell_size,y-cell_size:y+cell_size) ;
        image_features(i,:) = blockFeature(block_image , block_angle , block_rotation_matrix, cell_size);
    end