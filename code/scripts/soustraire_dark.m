% PREX DEOS 03 - Evaluation de la qualité d'image d'une caméra
% d'astrophysique

% Code par Florian Topeza

% Soustraire l'image de dark

clc;
PathProg = pwd;

% Chemin du dossier avec les images de dark
chemin_dossier_dark = "..\..\images\Séance 4\partie mire\miretestdark";

% Chemin du dossier avec les autres images
chemin_dossier_images = "..\..\images\Séance 4\partie mire\mire_test";

% Obtenir la liste de tous les fichiers dans les dossiers
fichiers_images = dir(fullfile(chemin_dossier_images, '*.fit')); % Modifier "*.fit" selon votre format d'image
fichiers_dark = dir(fullfile(chemin_dossier_dark, '*.fit')); % Modifier "*.fit" selon votre format d'image
    
% Initialiser les tableaux d'images
nombre_images = numel(fichiers_images);
nombre_images_dark = numel(fichiers_dark);

% Récupérer les dimensions des images
chemin_images = fullfile(chemin_dossier_images, fichiers_images(1).name);
image_test = fitsread(chemin_images);
taille_images = size(image_test);

% Récupérer les dimensions des images dark
chemin_dark = fullfile(chemin_dossier_dark, fichiers_dark(1).name);
image_dark = fitsread(chemin_dark);
taille_dark = size(image_dark);

% Initialisation des matrices des images
donnees_images = zeros([taille_images, nombre_images]);
donnees_images_dark = zeros([taille_dark, nombre_images_dark]);

% Chargement les images dans la matrice
for i = 1:nombre_images
    chemin_image = fullfile(chemin_dossier_images, fichiers_images(i).name);
    donnees_images(:,:,i)  = fitsread(chemin_image);% Charger l'image dans la matrice
end

% Calcul de l'image moyenne
image_moyenne = double(mean(donnees_images, 3));

% Chargement des images dark dans la matrice
for i = 1:nombre_images_dark
    chemin_image = fullfile(chemin_dossier_dark, fichiers_dark(i).name);
    donnees_images_dark(:,:,i)  = fitsread(chemin_image);% Charger l'image dans la matrice
end

% Calcul de l'image moyenne
image_moyenne_dark = double(mean(donnees_images_dark, 3));

% Soustraire l'image dark de l'image
image_corrigee = image_moyenne - image_moyenne_dark;

% Afficher les images d'origine et corrigée pour comparaison
figure;
subplot(1, 3, 1);
imshow(image_moyenne, []);
title('Image moyenne test');
subplot(1, 3, 2);
imshow(image_moyenne_dark, []);
title('Dark moyen');
subplot(1, 3, 3);
imshow(image_corrigee, []);
title('Image corrigée');

% Enregistrer l'image corrigée en fichier FIT
fitswrite(image_corrigee, "..\..\images\Séance 4\partie mire\images_corrigees\image_corrigee");

