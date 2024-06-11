clear; clc; close all

load eye.mat

% first image
figure;
imshow(I(:,:,1))

% mean image 
approx = mean(I,3);
figure
imshow(approx); 

% noise added to each image
noise = I - repmat(approx,[1,1,size(I,3)]);

%calculate the noise statistics
mean_noise = mean(noise(:)); 
std_noise = std(noise(:));

% noise distribution
figure;
histogram(noise(:),100);

K = length(I(:,:,1))^2; %the number of noise samples for each image
                        %equals the number of pixels  
for j=1:100
    %for each image create a sample to check the c.l.theorem
    sample(j) = sum(sum(noise(:,:,j)-mean_noise))/(std_noise*sqrt(K));
end
    

% check the central limit theorem from the above
% each random variable generated from above is a sample
mean_ = mean(sample);
std_ = std(sample);


figure; 
histogram(sample(:),100); % looks more or less like a gaussian

