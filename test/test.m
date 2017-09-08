clear all

filename = 'SampleVideoBunny.mp4';
videofile = VideoReader(filename);

while hasFrame(videofile)
    frame = readFrame(videofile);
    imshow(frame);
%     pause(.5);
end