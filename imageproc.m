% for k = 1:9
%   jpgFilename = strcat('sygic', num2str(k), '.jpg');
%   imageData = imread(jpgFilename);
% end
demo = 'C:\Users\Parth-PC\Desktop\demo\';
if ~isdir(demo)
  errorMessage = sprintf('Error: The following folder does not exist:\n%s', demo);
  uiwait(warndlg(errorMessage));
  return;
end
%filePattern = fullfile(spiders, '*.jpg');
%jpegFiles = dir(filePattern);

% images = dir(demo);
% count = size(images,1)
% for k = 1:count-2
k=1;
while(1);
  pngFilename = strcat(demo, 'droidAtScreen-', num2str(k), '.png');
  if ( exist(pngFilename, 'file') == 0)
      continue;
  end
      
  k=k+1;
  
  %baseFileName = strcat('sygic', num2str(k));
  %fullFileName = fullfile(spiders, baseFileName);
  fprintf(1, 'Now reading %s\n', pngFilename);

I=imread(pngFilename);
I(:,:,1) = medfilt2(I(:,:,1));
I(:,:,2) = medfilt2(I(:,:,2));
I(:,:,3) = medfilt2(I(:,:,3));



bw1 = 1.*((I(:,:,3) > 200) & (I(:,:,3) < 237) & (I(:,:,2) > 7) & (I(:,:,2) < 25) & (I(:,:,1) > 128) & (I(:,:,1) < 160));
bw2 = 1.*((I(:,:,1) > 220) & (I(:,:,2) > 220) & (I(:,:,3) > 220));
bw3 = 1.*((I(:,:,3) > 0) & (I(:,:,3) < 30) & (I(:,:,2) > 128) & (I(:,:,2) <180) & (I(:,:,1) > 187) & (I(:,:,1) < 255));
bw4 = 1.*((I(:,:,3) > 175) & (I(:,:,2) > 177) & (I(:,:,1) > 172));
bw5 = 1.*((I(:,:,3) == 239) & (I(:,:,2) == 16) & (I(:,:,1) == 156));
bw6 = 1.*((I(:,:,3) == 0) & (I(:,:,2) == 134) & (I(:,:,1) == 206));
bw7 = 1.*((I(:,:,3) == 0) & (I(:,:,2) == 146) & (I(:,:,1) == 230));
bw8 = 1.*((I(:,:,3) == 0) & (I(:,:,2) == 170) & (I(:,:,1) == 255));

bw = bw1 | bw2 | bw3 | bw4 | bw5 | bw6 | bw7 | bw8;
figure;
mask = I;
mask(:,:,1) = bw;
mask(:,:,2) = bw;
mask(:,:,3) = bw;
p=mask.*I;
% k = imread('file.p', 'BackgroundColor',[1 1 1]);
% % imwrite(I, 'file.')
% M = repmat(all(p<20,3),[1 1 3]); 
% p(M) = 0;



set(gcf, 'color', 'white');
set(gca, 'color', 'white');


imshow(p);

pause(1);
end
