function rotated_image = rotateImage(input_image, angle)
    % Rotate image counterclockwise
    input_image = im2double(input_image);
    [rows, cols] = size(input_image);
    center_x = (cols + 1) / 2;
    center_y = (rows + 1) / 2;
    rotation_matrix = [cos(angle), -sin(angle); sin(angle), cos(angle)];
    [X, Y] = meshgrid(1:cols, 1:rows);
    X = X - center_x;
    Y = Y - center_y;
    rotated_coords = rotation_matrix * [X(:)'; Y(:)'];
    rotated_coords(1, :) = rotated_coords(1, :) + center_x;
    rotated_coords(2, :) = rotated_coords(2, :) + center_y;
    X_rotated = reshape(rotated_coords(1, :), rows, cols);
    Y_rotated = reshape(rotated_coords(2, :), rows, cols);
    rotated_image = interp2(X, Y, input_image, X_rotated, Y_rotated, 'linear', 0);
end