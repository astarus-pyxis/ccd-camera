% PREX DEOS 03 - Evaluation de la qualité d'image d'une caméra
% d'astrophysique

% Code par Florian Topeza

% Calcul et affiche la caractéristique du courant d'obscurité

clc;
PathProg = pwd;
addpath("..\fonctions")

% Chemin du dossier avec les images
chemin_dossier = "..\..\images\Séance 3\Courant obs";

% Obtenir la liste de tous les fichiers dans le dossier
fichiers = natsortfiles(dir(fullfile(chemin_dossier, '*.fit'))); % Modifier "*.fit" selon votre format d'image

% Récupérer les dimensions de l'image
chemin_image = fullfile(chemin_dossier, fichiers(1).name);
image = fitsread(chemin_image);
taille_image = size(image);

% Paramètres du courant d'obscurité
nombre_points = 5; % Nombre de points de mesure
nombre_acquisitions = 20; % Nombre d'acquisitions par point
Tint_min = 0; %temps d'intégration minimal
Tint_max = 20; % temps d'intégration maximal
tension_Peltier = 0; % tension du module Peltier

% Paramètres du CAN
plage_entree_CAN = 10;
N_bits_CAN = 15;
Gain = 10;

% Initialisation des vecteurs pour stocker les temps d'intégration et les
% réponses moyennes
Tint = zeros(1, nombre_points);
reponse_moyenne_ADU = zeros(1, nombre_points);

% Boucle sur les points de mesure
for i = 1:nombre_points

    % Calcul de la tension pour ce point de mesure
    Tint(i) = Tint_min + (i - 1) * (Tint_max - Tint_min) / (nombre_points - 1);

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

    % Calcul de l'intensité moyenne de l'image moyenne
    reponse_moyenne_ADU(i) = mean(image_moyenne(:));

end

reponse_moyenne_tension = reponse_moyenne_ADU * plage_entree_CAN / ((2^(N_bits_CAN) - 1) * Gain);

% Courant d'obscurité avec temps d'intégration en abscisse et ADU en
% ordonnée
figure;
scatter(Tint, reponse_moyenne_ADU, '+');
lsline;
xlabel("Temps d'intégration (s)");
ylabel('Réponse Lumineuse Moyenne (ADU)');
title("Courant d'obscurité - tension du Peltier à " + tension_Peltier + "V");
grid on;

% Courant d'obscurité avec temps d'intégration en abcisse et V en ordonnée
figure;
scatter(Tint, reponse_moyenne_tension, '+');
lsline;
xlabel("Temps d'intégration (s)");
ylabel('Réponse Lumineuse Moyenne (V)');
title("Courant d'obscurité - tension du Peltier à " + tension_Peltier + "V");
grid on;


