%% Setup
% Directory where the images are located (they should be named, for
% example, xx001-xx999 or yy01-yy99)
workingDir = 'C:\Users\Matias\Desktop\Facu\TC\5C1\Proyecto\Videos\video4gaussian';
% Extension of the images
imagesExtension = '*.jpeg';
% Framerate
framgeRate = 24;
% Directory where the output video will located
outputDir = 'C:\Users\Matias\Desktop\Facu\TC\5C1\Proyecto\Videos';
% Name of the video
videoName = 'woman_gaussian.avi';

%% Find Image File Names
imageNames = dir(fullfile(workingDir,imagesExtension));
imageNames = {imageNames.name}';

%% Create New Video with the Image Sequence
outputVideo = VideoWriter(fullfile(outputDir,videoName));
outputVideo.FrameRate = framgeRate;
open(outputVideo)

for ii = 1:length(imageNames)
   img = imread(fullfile(workingDir,imageNames{ii}));
   writeVideo(outputVideo,img)
end

close(outputVideo)