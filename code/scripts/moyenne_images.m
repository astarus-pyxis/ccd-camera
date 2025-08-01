% PREX DEOS 03 - Evaluation de la qualité d'image d'une caméra
% d'astrophysique

% Code par Florian Topeza

% Affiche l'image moyenne des images d'un dossier

clc;
PathProg = pwd;

% Chemin du dossiet avec les images à moyenner
chemin_dossier = "..\..\images\FTEO TEST";

% Obtenir la liste de tous les fichiers dans le dossier
fichiers = dir(fullfile(chemin_dossier, '*.fit')); % Modifier "*.fit" selon votre format d'image
    
% Initialiser le tableau d'images
nombre_images = numel(fichiers);

% Récupérer les dimensions de l'image
chemin_image = fullfile(chemin_dossier, fichiers(1).name);
image = fitsread(chemin_image);
taille_image = size(image);

% Initialisation de la matrice pour stocker les données des images
donnees_images = zeros([taille_image, nombre_images]);

% Charger chaque image dans le tableau
for i = 1:nombre_images
    chemin_image = fullfile(chemin_dossier, fichiers(i).name);
    donnees_images(:,:,i)  = fitsread(chemin_image);
end

% Calcule de l'image moyenne
image_moyenne = mean(donnees_images, 3);

% Afficher l'image moyenne
imshow(image_moyenne, []);
title('Image Moyenne');
