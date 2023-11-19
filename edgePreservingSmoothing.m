function output_image = edgePreservingSmoothing(input_image, lambda, sigma)
    % Edge preserving smoothing based on weighted least squares
    
    % Convert input image to double precision
    input_image = im2double(input_image);
    
    % Compute gradient of the input image
    [gx, gy] = gradient(input_image);
    
    % Initialize output image with the same values as the input image
    output_image = input_image;
    
    % Get the size of the input image
    [M, N] = size(input_image);
    
    % Iterate over each pixel in the input image
    for i = 1:M
        for j = 1:N
            % Determine the boundaries of the local window
            xmin = max(i - sigma, 1);
            xmax = min(i + sigma, M);
            ymin = max(j - sigma, 1);
            ymax = min(j + sigma, N);
            
            % Extract the local window of the input image, gx, and gy
            window = input_image(round(xmin:xmax), round(ymin:ymax));
            gx_window = gx(round(xmin:xmax), round(ymin:ymax));
            gy_window = gy(round(xmin:xmax), round(ymin:ymax));
            
            % Construct the matrix A and vector b for solving the linear system
            A = [gx_window(:), gy_window(:)];
            b = window(:) - input_image(i, j);
            
            % Compute the weight vector w based on the difference between the window and the central pixel
            w = exp(-(b.^2) / lambda^2);
            
            % Solve the linear system to obtain the coefficients
            coeffs = pinv(A' * diag(w) * A) * (A' * diag(w) * b);
            
            % Compute the smoothed value for the central pixel
            output_image(i, j) = input_image(i, j) + [gx(i, j), gy(i, j)] * coeffs;
        end
    end
    
    % Convert the output image to 8-bit unsigned integer format
    output_image = im2uint8(output_image);
end