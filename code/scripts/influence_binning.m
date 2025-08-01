% PREX DEOS 03 - Evaluation de la qualité d'image d'une caméra
% d'astrophysique

% Code par Florian Topeza

% Influence du binning

clc;
PathProg = pwd;

% Chemin du dossier avec les images
chemin_dossier = "..\..\images\Séance 3\Binning";

% Tableau des binning
binning = ["1x1", "2x2", "3x3", "4x4"];

% Définir la plage de couleur en ADU pour les images
min = 5000;
max = 19000;

% Obtenir la liste de tous les fichiers dans le dossier
fichiers = dir(fullfile(chemin_dossier, '*.fit')); % Modifier "*.fit" selon votre format d'image
    
% Initialiser le tableau d'images
nombre_images = numel(fichiers);

% Paramètres du courant d'obscurité
nombre_points = 4; % Nombre de points de mesure
nombre_acquisitions = 20; % Nombre d'acquisitions par point

% Boucle sur les points de mesure
for i = 1:nombre_points

    % Récupérer les dimensions de l'image (qui changent avec le binning)
    chemin_image = fullfile(chemin_dossier, fichiers((i - 1) * nombre_acquisitions + 1).name);
    image = fitsread(chemin_image);
    taille_image = size(image);

    % Initialisation de la matrice pour stocker les données des images
    donnees_images = zeros([taille_image, nombre_acquisitions]);

    % Boucle sur les acquisitions pour ce point de mesure
    % Chargement les images dans la matrice
    for j = 1:nombre_acquisitions
        chemin_image = fullfile(chemin_dossier, fichiers((i - 1) * nombre_acquisitions + j).name);
        donnees_images(:,:,j)  = fitsread(chemin_image);% Charger l'image dans la matrice
    end

    % Calcul de l'image moyenne
    image_moyenne = mean(donnees_images, 3);

    % Affichage de la cartographie de Jobs de l'image moyenne pour ce point
    % de mesure
    figure;
    imagesc(image_moyenne);
    cb = colorbar;
    clim manual;
    clim([min max]);
    xlabel("Numéro des pixels en abscisse");
    ylabel("Numéro des pixels en ordonnée");
    cb.Title.String = "ADU";
    title("Réponse des pixels à binning " + binning(i));

end