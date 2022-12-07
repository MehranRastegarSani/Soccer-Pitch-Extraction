function Img_mask = Lab_Svm_Playfield_Extraction(Img)

load data/Lab_svm.mat

[r,c] = size(Img(:,:,1));

lab_Img = rgb2lab(Img);

imgd = reshape( lab_Img, r*c, 3 ); 

[grassMask] = predict(SVMModel,imgd);

grassMask = reshape( grassMask, r, c);

stats = regionprops(logical(imfill(imclose(imopen(grassMask,strel('disk',10)),strel('disk',10)),'holes')),'Area','ConvexHull');

mask = zeros(r,c);

[i,j]=max([stats.Area]);

mask = xor(poly2mask(stats(j).ConvexHull(:,1),stats(j).ConvexHull(:,2),r,c),mask);

mask = imerode(mask,strel('disk',10));

Img_mask = Img;

mask_3d = cat(3,mask,mask,mask);

Img_mask(~mask_3d) = 0;

mask = imerode(mask,strel('disk',2));
end