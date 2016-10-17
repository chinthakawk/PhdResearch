Iin  = imread('cameraman.tif'); imshow(Iin); title('Base image');
Iout = imresize(Iin, 0.7); Iout = imrotate(Iout, 31);
figure; imshow(Iout); title('Transformed image');
% Detect and extract features from both images.

ptsIn  = detectSURFFeatures(Iin);
ptsOut = detectSURFFeatures(Iout);
[featuresIn   validPtsIn]  = extractFeatures(Iin,  ptsIn);
[featuresOut validPtsOut]  = extractFeatures(Iout, ptsOut);
% Match feature vectors.

index_pairs = matchFeatures(featuresIn, featuresOut);
% Get matching points.

matchedPtsIn  = validPtsIn(index_pairs(:,1));
matchedPtsOut = validPtsOut(index_pairs(:,2));
figure; showMatchedFeatures(Iin,Iout,matchedPtsIn,matchedPtsOut);
title('Matched SURF points, including outliers');
% Compute the transformation matrix using RANSAC.

gte = vision.GeometricTransformEstimator;
gte.Transform = 'Nonreflective similarity';
[tform inlierIdx] = step(gte, matchedPtsOut.Location, matchedPtsIn.Location);
figure; showMatchedFeatures(Iin,Iout,matchedPtsIn(inlierIdx),matchedPtsOut(inlierIdx));
title('Matching inliers'); legend('inliersIn', 'inliersOut');
 
% Recover the original image.

agt = vision.GeometricTransformer;
Ir = step(agt, im2single(Iout), tform);
figure; imshow(Ir); title('Recovered image');