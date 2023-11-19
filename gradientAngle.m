function gradient_angle = gradientAngle(input_image)
    input_image = im2double(input_image);
    [gx, gy] = gradient(input_image);
    gradient_angle = atan2(gy, gx);
    gradient_angle = rad2deg(gradient_angle);
    gradient_angle = mod(gradient_angle, 360);
end