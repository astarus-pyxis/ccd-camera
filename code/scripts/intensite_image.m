% PREX DEOS 03 - Evaluation de la qualité d'image d'une caméra
% d'astrophysique

% Code par Florian Topeza

% Intensité d'un pixel et moyenne d'une image

clc;
PathProg = pwd;

% Chemin d'accès de l'image
image = fitsread("..\..\images\FTEO TEST Binning 1x1\T81.fit");

x = 10; % Coordonnée x du pixel
y = 15; % Coordonnée y du pixel

% Intensité lumineuse sur le pixel donné
intensite_pixel = image(y, x);
disp(['L''intensité lumineuse sur le pixel (', num2str(x), ',', num2str(y), ') est : ', num2str(intensite_pixel)]);

% Intensité lumineuse de l'image moyenne
intensite_moyenne = mean(image(:));
disp(['L''intensité moyenne de l''image moyenne est : ', num2str(intensite_moyenne)]);