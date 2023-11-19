% Image feature extraction based on gradient angle compensation
original_image = 'example_image.jpg' ;
target_image = 'target5.jpg';


image2 = imread(original_image);
image1 = imread(target_image);

is_smothing = false ;
is_enhancement = true ;
rotation_angle = 0;

% Some Pre_process
image2 = tform(image2, rotation_angle);



[features_1 , key_point1] = getFeatures(image1,is_smothing,is_enhancement);
[features_2 , key_point2] = getFeatures(image2,is_smothing,is_enhancement);

match_points    = featureMatch(features_1 , features_2 , key_point1, key_point2 );
original_points = key_point1 ;

[original_points,match_points] = RANSAC(original_points,match_points);
plotMatchingPoints(image1,image2,original_points,match_points);