name1 = '/Users/apple/Desktop/positiveTrain.txt';

imgSet = imageSet('/Users/apple/Desktop/CV/AnimalProject/OpossumPositiveTrainImgs');
[setA1] = partition(imgSet, 400, 'randomized');

a = setA1.ImageLocation;
b = a';

fileID = fopen(name1, 'w');
format = '%s\n';
[nrows, ncols] = size(b);
for row = 1:nrows
   fprintf(fileID, format, b{row,:});
end
