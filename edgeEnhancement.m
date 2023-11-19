function output_image = edgeEnhancement(input_image)
    % Using Sobel operator for edge enhancement
    sobel_x = [-1 0 1; -2 0 2; -1 0 1]; % Sobel X operator
    sobel_y = [-1 -2 -1; 0 0 0; 1 2 1]; % Sobel Y operator
    edge_x = conv2(double(input_image), sobel_x, 'same');
    edge_y = conv2(double(input_image), sobel_y, 'same');
    edge_intensity = sqrt(edge_x.^2 + edge_y.^2);
    max_intensity = max(edge_intensity(:));
    edge_intensity = edge_intensity / max_intensity * 255;
    output_image = uint8(edge_intensity);