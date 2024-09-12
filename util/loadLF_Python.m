%%
%% Load the light field images into a 5D array: (y, x, rgb, v, u)
%% Indices of the returned array follow Matlab's convention of (row, column):
%%                 u
%%    ---------------------------->
%%    |  ________    ________
%%    | |    x   |  |    x   |
%%    | |        |  |        |
%%  v | | y      |  | y      | ....
%%    | |        |  |        |     
%%    | |________|  |________|
%%    |           :
%%    |           :
%%    v
%%
%% The input files may be in .mat, or
%% alternately, a folder with the light field images (PNGs) may be provided.

function [LF] = loadLF_Python( fin, uCameraMovingRight, vCameraMovingRight, cspace)

  sz = size(fin);
  y = sz(1); x = sz(2); u = sz(3); v = sz(4); 
  fin = repmat(fin, [1, 1, 1, 1, 3]);

  if strcmp(cspace, 'lab')
      LF = zeros(y, x, 3, v, u);
    elseif strcmp(cspace, 'gray')
      LF = zeros(y, x, 1, v, u);		  
    else
      LF = zeros(y, x, 3, v, u);
  end

  for i = 1:v
    for j = 1:u
      
      sub_aperture = squeeze(fin(:, :, i, j, :));

      if strcmp(cspace, 'lab')
        LF(:, :, :, i, j) = rgb2lab(sub_aperture);
      elseif strcmp(cspace, 'ycbcr')
        LF(:, :, :, i, j) = rgb2ycbcr(sub_aperture);
      elseif strcmp(cspace, 'gray')
        LF(:, :, 1, i, j) = rgb2gray(sub_aperture);
      else 
        LF(:, :, :, i, j) = sub_aperture;		  
      end  
    end
  end
  
  % Flipping ensures a uniform occlusion order in EPIs
  if uCameraMovingRight
    LF = flip(LF, 5);
  end
  if vCameraMovingRight
    LF = flip(LF, 4);
  end

end
