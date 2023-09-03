function prettify_colorblind_simulator()

% Get current figure's content
f = gcf;
all_axes = findall(f, 'Type', 'axes');

% Define transformation matrices for color blindness
% These are approximations, from https://www.inf.ufrgs.br/~oliveira/pubs_files/CVD_Simulation/CVD_Simulation.html#Tutorial

% Anamolous trichomacy: 
protanomaly = [0.458064, 0.679578, -0.137642; 0.092785, 0.846313, 0.060902; -0.007494, -0.016807, 1.024301];
deuteranomaly = [0.547494, 0.607765, -0.155259; 0.181692, 0.781742, 0.036566; -0.010410, 0.027275, 0.983136];
tritanomaly = [1.017277, 0.027029, -0.044306; -0.006113, 0.958479, 0.047634; 0.006379, 0.248708, 0.744913];

% Dichromatic:
protanopia = [0.152286, 1.052583, -0.204868; 0.114503, 0.786281, 0.099216; -0.003882, -0.048116, 1.051998];
deuteranopia = [0.367322, 0.860646, -0.227968; 0.280085, 0.672501, 0.047413; -0.011820, 0.042940, 0.968881];
tritanopia = [1.255528, -0.076749, -0.178779; -0.078411, 0.930809, 0.147602; 0.004733, 0.691367, 0.303900];

% Monochromatic: 
achromatopsia = repmat(mean(eye(3), 2)', 3, 1);

transforms = {protanomaly, deuteranomaly, tritanomaly, protanopia, deuteranopia, tritanopia, achromatopsia};
typeNames = {'Protanomaly', 'Deuteranomaly', 'Tritanomaly', 'Protanopia', 'Deuteranopia', 'Tritanopia', 'Achromatopsia'};

% Create a new figure for colorblind visualizations
figure('Color', 'w');

for j = 1:length(all_axes)
    ax = all_axes(j);
    img = getframe(ax);
    imgData = img.cdata;
    imgData = im2double(imgData); % Convert to double for matrix multiplication
    
    for i = 1:length(transforms)
        % Simulate the colorblind vision
        transformed = reshape(imgData, [], 3) * transforms{i}';
        transformed = reshape(transformed, size(imgData));
        transformed = min(max(transformed, 0), 1); % Clamp values between 0 and 1
        
        % Display in a subplot
        subplot(length(all_axes), length(transforms), (j-1)*length(transforms) + i);
        imshow(transformed);
        title(typeNames{i});
    end
end
end