function downsampledImage = imageDownsample(image, factor)
    [rows, cols, ~] = size(image);
    newRows = floor(rows / factor);
    newCols = floor(cols / factor);
    downsampledImage = zeros(newRows, newCols);
    for i = 1:newRows
        for j = 1:newCols
            origRow = (i-1) * factor + 1;
            origCol = (j-1) * factor + 1;
            downsampledImage(i, j, :) = image(origRow, origCol, :);
        end
    end
    downsampledImage = uint8(downsampledImage);