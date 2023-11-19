function matchedPoints2 = featureMatch(feature1 , feature2 ,~, kp2 )    
    distances = pdist2(feature1, feature2, 'euclidean');
    [~, indices] = min(distances, [], 2);
    matchedPoints2 = kp2(indices, :);
end
           