% PREX DEOS 03 - Evaluation de la qualité d'image d'une caméra
% d'astrophysique

% Code par Florian Topeza

% Calcul et affiche les caractéristiques des courants d'obscurité avec le module Petlier à 0V et
% 4V sur un même graphique

clc;
PathProg = pwd;
addpath("..\fonctions")

%% Courant d'obscurité avec une tension nulle pour le module Peltier

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
tension_Peltier_0V = 0; % tension du module Peltier

% Paramètres du CAN
plage_entree_CAN = 10;
N_bits_CAN = 15;
Gain = 10;

% Initialisation des vecteurs pour stocker les temps d'intégration et les
% réponses moyennes
Tint_0V = zeros(1, nombre_points);
reponse_moyenne_ADU_0V = zeros(1, nombre_points);

% Boucle sur les points de mesure
for i = 1:nombre_points

    % Calcul du temps d'intégration pour ce point de mesure
    Tint_0V(i) = Tint_min + (i - 1) * (Tint_max - Tint_min) / (nombre_points - 1);

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
    reponse_moyenne_ADU_0V(i) = mean(image_moyenne(:));

end

reponse_moyenne_tension_0V = reponse_moyenne_ADU_0V * plage_entree_CAN / ((2^(N_bits_CAN) - 1) * Gain);


%% Courant d'obscurité avec une tension de 4V pour le module Peltier

% Chemin du dossier avec les images
chemin_dossier = "..\..\images\Séance 4\Courant obs";

% Obtenir la liste de tous les fichiers dans le dossier
fichiers = natsortfiles(dir(fullfile(chemin_dossier, '*.fit'))); % Modifier "*.fit" selon votre format d'image
    
% Nombre d'images dans le dossier
nombre_images = numel(fichiers);

% Récupérer les dimensions de l'image
chemin_image = fullfile(chemin_dossier, fichiers(1).name);
image = fitsread(chemin_image);
taille_image = size(image);

% Paramètres du courant d'obscurité
nombre_points = 5; % Nombre de points de mesure
nombre_acquisitions = 3; % Nombre d'acquisitions par point
Tint_min = 0.01; %temps d'intégration minimal
Tint_max = 40; % temps d'intégration maximal
tension_Peltier_4V = 4; % tension du module Peltier

% Paramètres du CAN
plage_entree_CAN = 10;
N_bits_CAN = 15;
Gain = 10;

% Initialisation des vecteurs pour stocker les temps d'intégration et les
% réponses moyennes
Tint_4V = zeros(1, nombre_points);
reponse_moyenne_ADU_4V = zeros(1, nombre_points);

% Boucle sur les points de mesure
for i = 1:nombre_points

    % Calcul du temps d'intégration pour ce point de mesure
    Tint_4V(i) = Tint_min + (i - 1) * (Tint_max - Tint_min) / (nombre_points - 1);

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
    reponse_moyenne_ADU_4V(i) = mean(image_moyenne(:));

end

reponse_moyenne_tension_4V = reponse_moyenne_ADU_4V * plage_entree_CAN / ((2^(N_bits_CAN) - 1) * Gain);


% Courant d'obscurité avec temps d'intégration en abscisse et ADU en
% ordonnée
figure;
scatter(Tint_0V, reponse_moyenne_ADU_0V, '+')

hold on
scatter(Tint_4V, reponse_moyenne_ADU_4V, '+')
hold off

lsline
legend("0V","4V")
xlabel("Temps d'intégration (s)");
ylabel('Réponse Lumineuse Moyenne (ADU)');
title("Courants d'obscurité à 0V et 4V");
grid on;

% Courant d'obscurité avec temps d'intégration en abcisse et V en ordonnée
figure;
scatter(Tint_0V, reponse_moyenne_tension_0V, '+');

hold on
scatter(Tint_4V, reponse_moyenne_tension_4V, '+');
hold off

lsline
legend("0V","4V")
xlabel("Temps d'intégration (s)");
ylabel('Réponse Lumineuse Moyenne (V)');
title("Courants d'obscurité à 0V et 4V");
grid on;


