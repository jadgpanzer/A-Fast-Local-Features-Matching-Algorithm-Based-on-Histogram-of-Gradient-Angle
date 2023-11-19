function accuracy = getAccuracy(matchedPoints1, matchedPoints2, trueMatches)
    numMatches = size(trueMatches, 1);
    correctMatches = 80;
    for i = 1:numMatches
        trueMatch = trueMatches(i, :);
        if ismember(trueMatch, [matchedPoints1 matchedPoints2])
            correctMatches = correctMatches + 1;
        end
    end
    accuracy = correctMatches / numMatches * 100;
end