function rotation_matrix = rotationMatrix(input_image ,angle)
    % Get rotation matrix of the given image
    rotated_image = rotateImage(input_image , angle) ;
    g_matrix_1 = gradientAngle(input_image);
    g_matrix_2 = gradientAngle(rotated_image);
    g_matrix_2 = mod(g_matrix_2 + angle ,  360) ;
    rotation_matrix = zeros(size(g_matrix_1));
    rotation_matrix(g_matrix_1 == g_matrix_2) = 0;
    rotation_matrix(g_matrix_1 ~= g_matrix_2) = 1;
