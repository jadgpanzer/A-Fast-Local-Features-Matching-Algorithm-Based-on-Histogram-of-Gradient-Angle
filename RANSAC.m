function [filteredFeatures1, filteredFeatures2] = RANSAC(features1, features2)
    % Random Sample Consensus (RANSAC) for translation
    
    numIterations = 1000; % Number of iterations
    maxDistance = 100; % Maximum distance threshold between matching points
    minInlierRatio = 0.5; % Minimum inlier ratio to consider the model as good
    bestInlierIdx = []; % Inlier indices of the best model
    for i = 1:numIterations
        % Randomly select two matching points as model parameters
        sampleIndices = randperm(size(features1, 1), 2);
        samplePoints1 = features1(sampleIndices, :);
        samplePoints2 = features2(sampleIndices, :);
        
        % Calculate transformation model parameters based on the two sets of matching points
        model = estimateTransformModel(samplePoints1, samplePoints2);
        
        % Calculate distances between all matching points
        distances = calculateDistances(features1, features2, model);
        
        % Determine inlier indices based on the maximum distance threshold
        inlierIdx = find(distances <= maxDistance);
        
        % If the number of inliers exceeds the threshold, consider the model as good
        if numel(inlierIdx) >= minInlierRatio * size(features1, 1)
            if numel(inlierIdx) > numel(bestInlierIdx)
                bestInlierIdx = inlierIdx;
            end
        end
    end
    
    % Output the filtered features after removing incorrect matches
    filteredFeatures1 = features1(bestInlierIdx, :);
    filteredFeatures2 = features2(bestInlierIdx, :);
    end

% Define the function to estimate the transformation model
function model = estimateTransformModel(points1, points2)
    model.translation = mean(points2 - points1);
    model.scale = std(points2 - points1) / std(points1);
end

% Calculate distances between matching points
function distances = calculateDistances(points1, points2, model)
    transformedPoints1 = points1 * model.scale + model.translation;
    distances = sqrt(sum((points2 - transformedPoints1).^2, 2));
end