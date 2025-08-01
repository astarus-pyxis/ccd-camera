% PREX DEOS 03 - Evaluation de la qualité d'image d'une caméra
% d'astrophysique

% Code par Florian Topeza

% Calcul et affiche la FTEO

clc;
PathProg = pwd;
addpath("..\fonctions")

% Chemin du dossier avec les images
chemin_dossier = "..\..\images\Séance 6\FTEO Version finale";

% Obtenir la liste de tous les fichiers dans le dossier
fichiers = natsortfiles(dir(fullfile(chemin_dossier, '*.fit'))); % Modifier "*.fit" selon votre format d'image
    
% Initialiser le tableau d'images
nombre_images = numel(fichiers);

% Récupérer les dimensions de l'image
chemin_image = fullfile(chemin_dossier, fichiers(1).name);
image = fitsread(chemin_image);
taille_image = size(image);

% Paramètres de la FTEO
nombre_points =13; % Nombre de points de mesure
nombre_acquisitions = 10; % Nombre d'acquisitions par point

% Paramètres du CAN
plage_entree_CAN = 10;
N_bits_CAN = 15;
Gain = 10;

% Initialisation des vecteurs pour stocker les tensions et les réponses moyennes
%tension = zeros(1, nombre_points);
reponse_moyenne_ADU = zeros(1, nombre_points);

% Tableau des tensions
tension = [17, 18, 18.3, 18.6, 19, 19.3, 19.6, 20, 20.3, 20.6, 21, 21.3, 21.6];

% Tableau des intensités
intensite = [0, 0.01, 0.027, 0.047, 0.078, 0.1, 0.13, 0.175, 0.2, 0.24, 0.288, 0.326, 0.36];

% Boucle sur les points de mesure
for i = 1:nombre_points

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

    % Calcul de la réponse moyenne sur l'image complète
    reponse_moyenne_ADU(i) = mean(image_moyenne(:));

end

reponse_moyenne_tension = reponse_moyenne_ADU * plage_entree_CAN / ((2^(N_bits_CAN) - 1) * Gain);

% Courbe de la FTEO avec tension en abscisse et ADU en ordonnée
figure;
scatter(tension, reponse_moyenne_ADU, '+');
xlabel('Tension (V)');
ylabel('Réponse Lumineuse Moyenne (ADU)');
title('FTEO');
grid on;

% Courbe de la FTEO avec tension en abscisse et V en ordonnée
figure;
scatter(tension, reponse_moyenne_tension, '+');
xlabel('Tension (V)');
ylabel('Réponse Lumineuse Moyenne (V)');
title('FTEO');
ylim([0, 1.1]);
grid on;

% Courbe de la FTEO avec intensité en abscisse et ADU en ordonnée
figure;
scatter(intensite, reponse_moyenne_ADU, '+');
regression_ADU = lsline;
coeff_regression_ADU = polyfit(get(regression_ADU,'xdata'),get(regression_ADU,'ydata'),1);
disp(coeff_regression_ADU);
xlabel('Intensité (mA)');
ylabel('Réponse Lumineuse Moyenne (ADU)');
title('FTEO');
grid on;

% Courbe de la FTEO avec intensité en abscisse et V en ordonnée
figure;
scatter(intensite, reponse_moyenne_tension,'+');
regression_tension= lsline;
coeff_regression_tension = polyfit(get(regression_tension,'xdata'),get(regression_tension,'ydata'),1);
disp(coeff_regression_tension);
xlabel('Intensité (mA)');
ylabel('Réponse Lumineuse Moyenne (V)');
title('FTEO');
grid on;

% Calcul des écarts à la linéarité
ecarts_ADU = zeros(1, nombre_points);
ecarts_tension = zeros(1, nombre_points);

for i=1:nombre_points

    ecarts_ADU(i) = 100 * (reponse_moyenne_ADU(i) - (coeff_regression_ADU(1)*intensite(i) + coeff_regression_ADU(2))) / (coeff_regression_ADU(1)*intensite(i) + coeff_regression_ADU(2)); 
    ecarts_tension(i) = 100 * (reponse_moyenne_tension(i) - (coeff_regression_tension(1)*intensite(i) + coeff_regression_tension(2))) / (coeff_regression_tension(1)*intensite(i) + coeff_regression_tension(2)); 

end

% Affichage des écarts en ADU
figure;
scatter(intensite, ecarts_ADU, '+','black');
yline(5);
yline(-5);
yline(1);
yline(-1);
ylim([-10 10]);
xlabel('Intensité (mA)');
ylabel('Ecart à la linéarité (%)');
title('Ecarts à la linéarité en ADU');
grid on;

% Affichage des écarts en tension
figure;
scatter(intensite, ecarts_tension, '+','black');
yline(5);
yline(-5);
yline(1);
yline(-1);
ylim([-10 10]);
xlabel('Intensité (mA)');
ylabel('Ecart à la linéarité (%)');
title('Ecarts à la linéarité en tension');
grid on;


