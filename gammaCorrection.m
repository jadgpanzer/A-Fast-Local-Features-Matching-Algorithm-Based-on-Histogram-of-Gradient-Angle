function output_image = gammaCorrection(input_image, gamma )
    % Function for gamma correction and contrast adjustment
    input_image = imadjust(input_image, [0.2, 1], [0, 1]);
    input_image = im2double(input_image);
    output_image = input_image.^gamma;
    output_image = im2uint8(output_image);
end