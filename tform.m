function output_image = tform(input_image, rotation_angle)
    % Affine transformation
    % rotation_angle :Angle of image rotation
    tform = affine2d([cosd(rotation_angle) -sind(rotation_angle) 0; sind(rotation_angle) cosd(rotation_angle) 0; 0 0 1]);
    output_image = imwarp(input_image, tform);
    s = size(input_image);
    output_image = imresize(output_image,[s(1),s(2)]);