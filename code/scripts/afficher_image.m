% PREX DEOS 03 - Evaluation de la qualité d'image d'une caméra
% d'astrophysique

% Code par Florian Topeza

% Chargement et affichage d'une image

clc;

PathProg = pwd;

% Chemin d'accès à l'image
image = fitsread("..\..\images\Séance 5\net_1x1\corr1x1.fit");

% Optionnel : afficher la réponse moyenne en ADU
% reponse_moyenne_ADU = mean(image(:));
% disp(reponse_moyenne_ADU);

figure;
imshow(image, []);

% Optionnel : visualiser la réponse des pixels avec colorbar
% clim manual;
% clim([14000 20000]); % Choix de l'échelle de pixels représentés sur le colorbar
% colorbar;

% Optionnel : afficher les axes
axis ij;
axis on;