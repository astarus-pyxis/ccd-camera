% PREX DEOS 03 - Evaluation de la qualité d'image d'une caméra
% d'astrophysique

% Code par Florian Topeza

clc;
PathProg = pwd;
addpath("..\..\matlab\fonctions")

% Binning choisi pour image la nuit étoilée
b = 1;

% Chemin du dossier avec les images
chemin_dossier = "..\..\images\Séance 5\ciel\ciel" + num2str(b) + "x" + num2str(b);

% Obtenir la liste de tous les fichiers dans le dossier
fichiers = natsortfiles(dir(fullfile(chemin_dossier, '*.fit'))); % Modifier "*.fit" selon votre format d'image
    
% Nombre d'images dans le dossier
nombre_images = numel(fichiers);

% Récupérer les dimensions de l'image
chemin_image = fullfile(chemin_dossier, fichiers(1).name);
image = fitsread(chemin_image);
taille_image = size(image);

% Temps d'intégration et plage de réponse
if b==1
    Tint = [5, 20, 40, 60, 120];
    min = 4500;
    max = 5000;
elseif b==2
    Tint = [5, 10, 20, 30, 40];
    min = 4700;
    max = 5000;
elseif b==3
    Tint = [5, 10, 20];
    min = 4800;
    max = 5000;
else
    Tint = [0.5, 1, 2, 4, 6, 10, 20];
    min = 4800;
    max = 5100;
end

% Affichage des images pour les différents binning et temps d'intégration
figure;
for i=1:nombre_images
    chemin_image = fullfile(chemin_dossier, fichiers(i).name);
    image = fitsread(chemin_image);
    subplot(3, floor(nombre_images / 3) + 1, i);
    imagesc(image);
    clim manual;
    clim([min, max]);
    colorbar;
    axis ij;
    axis on;
    title(["Ciel binning " + num2str(b) + "x" + num2str(b); "Temps d'intégration de " + num2str(Tint(i)) + "s"]);
end
