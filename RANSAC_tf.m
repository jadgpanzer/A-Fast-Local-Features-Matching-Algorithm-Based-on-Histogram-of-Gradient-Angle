function [filteredFeatures1, filteredFeatures2] = RANSAC_tf(features1, features2)
    % Random Sample Consensus (RANSAC) for affine transformation model

    % Set parameters for RANSAC algorithm
    numIterations = 3000; % Number of iterations
    numMatches = size(features1, 1); % Number of matching point pairs
    inlierThreshold = 150; % Inlier threshold used to determine correct points
    bestInlierCount = 0;  % Best inlier count
    bestAffineMatrix = [];  % Best affine transformation matrix
    filteredFeatures1 = [];  % Filtered features 1
    filteredFeatures2 = [];  % Filtered features 2
    
    for i = 1:numIterations
        % Ensure at least 3 matching point pairs
        if numMatches < 3
            break;
        end
    
        % Randomly select four matching point pairs
        indices = randperm(numMatches, 3);
        sampleFeatures1 = features1(indices, :);
        sampleFeatures2 = features2(indices, :);
    
        % Calculate affine transformation matrix using selected point pairs
        affineMatrix = estimateAffineMatrix(sampleFeatures1, sampleFeatures2);
    
        % Calculate projected points for all matching point pairs using the current affine transformation matrix
        projectedFeatures2 = transformPoints(features2, affineMatrix);
    
        % Calculate residuals for each matching point pair
        residuals = abs(features1 - projectedFeatures2);
    
        % Check which point pairs have residuals less than the threshold to determine inliers
        inliers = sum(residuals, 2) < inlierThreshold;
        inlierCount = sum(inliers);
    
        % Update the best inlier count and affine transformation matrix
        if inlierCount > bestInlierCount
            bestInlierCount = inlierCount;
            bestAffineMatrix = affineMatrix;
            filteredFeatures1 = features1(inliers, :);
            filteredFeatures2 = features2(inliers, :);
        end
    end
end

function affineMatrix = estimateAffineMatrix(features1, features2)
    % Calculate affine transformation matrix using selected point pairs
    numPoints = size(features1, 1);
    A = [features1, ones(numPoints, 1)];
    b = features2(:)';
    s = size(b);
    A = reshape(A,[],s(1))';
    x = A \ b;
    affineMatrix = reshape(x(1,:), 3, 2)';
end

function projectedFeatures = transformPoints(features, affineMatrix)
    % Project the features using the affine transformation matrix
    numPoints = size(features, 1);
    homogenousFeatures = [features, ones(numPoints, 1)];
    projectedFeatures = (affineMatrix * homogenousFeatures')';
end