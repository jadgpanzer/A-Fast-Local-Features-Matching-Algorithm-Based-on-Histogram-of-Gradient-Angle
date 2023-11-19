function plotMatchingPoints(image1, image2,matchedPoints1, matchedPoints2)
    figure;
    s = size(image1) ;
    image2 = imresize(image2 ,[s(1),s(2)]);
    combinedImage = cat(2, image1, image2);
    imshow(combinedImage);
    hold on;
    offset = size(image1, 2);
    for i = 1:size(matchedPoints1, 1)

        x1 = matchedPoints1(i, 1);
        y1 = matchedPoints1(i, 2);
        x2 = matchedPoints2(i, 1) + offset;
        y2 = matchedPoints2(i, 2);

        if x1 && x2 && y1 && y2 ~= 0
            plot([x1 x2], [y1 y2], 'r-', 'LineWidth', 1);
            scatter(x1, y1, 'blue', 'filled');
            scatter(x2, y2, 'green', 'filled');
        end
    end
    
    hold off;
end