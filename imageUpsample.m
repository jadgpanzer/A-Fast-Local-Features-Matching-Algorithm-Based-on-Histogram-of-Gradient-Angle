function upsampledImage = imageUpsample(image, factor)
    [rows, cols, ~] = size(image);
    newRows = rows * factor;
    newCols = cols * factor;
    upsampledImage = zeros(newRows, newCols, 3);
    for i = 1:newRows
        for j = 1:newCols
            origRow = ceil(i / factor);
            origCol = ceil(j / factor);
            upsampledImage(i, j, :) = image(origRow, origCol, :);
        end
    end
    upsampledImage = uint8(upsampledImage);
end