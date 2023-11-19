function marked_image = addMarkers(original_image, marker_points)
    % add features points on the image
    figure;
    imshow(original_image);
    hold on;
    plot(marker_points(:, 1), marker_points(:, 2), 'r+', 'MarkerSize', 10);
    marked_image = getframe(gcf);
    marked_image = marked_image.cdata;
end