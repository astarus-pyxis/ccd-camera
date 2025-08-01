% PREX DEOS 03 - Evaluation de la qualité d'image d'une caméra
% d'astrophysique

% Code par Florian Topeza

% Calcul du contraste

clc;
PathProg = pwd;

% Binning
b = 4;

% Image nette ? 1 si oui, 0 sinon
net = 0;

% Chemin de l'image darknet
if net == 1
    chemin_dark = ";.\..\images\Séance 5\net_" + num2str(b) + "x" + num2str(b) + "\dark"+ num2str(b) + "x" + num2str(b) + ".fit";
else
    chemin_dark = "..\..\images\Séance 5\flou_" + num2str(b) + "x" + num2str(b) + "\dark"+ num2str(b) + "x" + num2str(b) + ".fit";
end

% Chemin de l'image

if net == 1
    chemin_image = "..\..\images\Séance 5\net_" + num2str(b) + "x" + num2str(b) + "\net"+ num2str(b) + "x" + num2str(b) + ".fit";
else
    chemin_image = "..\..\images\Séance 5\flou_" + num2str(b) + "x" + num2str(b) + "\flou"+ num2str(b) + "x" + num2str(b) + ".fit";
end


% Zone de l'imge à choisir

% Image net et binning 1x1
if (net ==1) && (b == 1) 
    x_min = 345;
    x_max = 395;
    y_min = 110;
    y_max = 140;
end

% Image nette et binning 2x2
if (net ==1) && (b == 2) 
    x_min = 173;
    x_max = 197;
    y_min = 58;
    y_max = 74;
end

% Image nette et binning 3x3
if (net ==1) && (b == 3) 
    x_min = 116;
    x_max = 132;
    y_min = 38;
    y_max = 48;
end

% Image nette et binning 4x4
if (net ==1) && (b == 4) 
    x_min = 87;
    x_max = 99;
    y_min = 30;
    y_max = 37;
end

% Image floue et binning 1x1
if (net ==0) && (b == 1) 
    x_min = 345;
    x_max = 392;
    y_min = 110;
    y_max = 140;
end

% Image floue et binning 2x2
if (net ==0) && (b == 2) 
    x_min = 168;
    x_max = 195;
    y_min = 68;
    y_max = 85;
end

% Image floue et binning 3x3
if (net ==0) && (b == 3) 
    x_min = 114;
    x_max = 128;
    y_min = 45;
    y_max = 54;
end

% Image floue et binning 4x4
if (net ==0) && (b == 4) 
    x_min = 88;
    x_max = 98;
    y_min = 34;
    y_max = 41;
end

% Récupérer les dimensions de l'image
image = fitsread(chemin_image);
taille_image = size(image);

% Récupérer les dimensions de l'image dark
image_dark = fitsread(chemin_dark);
taille_dark = size(image_dark);

% Soustraire l'image dark de l'image
image_corrigee = image - image_dark;
disp(image_corrigee);

% Afficher les images d'origine et corrigée pour comparaison
figure;
subplot(1, 3, 1);
imshow(image, []);
title('Image');
axis ij;
axis on;
subplot(1, 3, 2);
imshow(image_dark, []);
title('darknet');
axis ij;
axis on;
subplot(1, 3, 3);
imshow(image_corrigee, []);
title('Image corrigée');
axis ij;
axis on;

% Enregistrer l'image corrigée en fichier FIT
if net == 1
    fitswrite(image_corrigee, "..\..\images\Séance 5\net_" + num2str(b) + "x" + num2str(b) + "\corr" + num2str(b) + "x" + num2str(b) + ".fit");
else
    fitswrite(image_corrigee, "..\..\images\Séance 5\flou_" + num2str(b) + "x" + num2str(b) + "\corr" + num2str(b) + "x" + num2str(b) + ".fit");
end

% Les résultats sont enregistrés dans un fichier texte.
if net == 1
    fileID = fopen("..\resultats\Séance 5\contraste_" + num2str(b) + "x" + num2str(b) + "_net.txt",'w');
else
    fileID = fopen("..\resultats\Séance 5\contraste_" + num2str(b) + "x" + num2str(b) + "_flou.txt",'w');
end

% Calcul de la réponse moyenne de chaque colonne de la zone de l'image où
% le contraste est calculé

% Initialisation des vecteurs x pour l'abscisse et reponse_moyenne_colonne
% pour l'ordonnée
nombre_colonnes = x_max - x_min;
nombre_pixels_colonne = y_max - y_min;
x = zeros(1, nombre_colonnes);
reponse_moyenne_colonne = zeros(1, nombre_colonnes);

% Calcul de la réponse moyenne de chaque colonne
for j=0:nombre_colonnes

    % Calcul de la réponse moyenne de la colonne j
    somme_reponses_pixels_colonne = 0;
    for i=0:nombre_pixels_colonne
        somme_reponses_pixels_colonne = somme_reponses_pixels_colonne + image_corrigee(y_min + i, x_min + j);
    end
    reponse_moyenne_colonne(j + 1) = somme_reponses_pixels_colonne / nombre_pixels_colonne;
    x(j+1) = x_min + j;
end

% Affichage de la courbe des réponses moyennes des colonnes

figure;
plot(x, reponse_moyenne_colonne,"-+");
xlabel("Abscisse des colonnes sur l'image");
ylabel('Réponse Lumineuse Moyenne de chaque colonne (ADU)');
if net == 1
    title("Calcul du contraste, image nette, binning " + num2str(b) + "x" + num2str(b));
else
    title("Calcul du contraste, image floue, binning " + num2str(b) + "x" + num2str(b));
end
grid on;

% Calcul du contraste
reponse_max = max(reponse_moyenne_colonne);
reponse_min = min(reponse_moyenne_colonne);

c = (reponse_max - reponse_min) / (reponse_max + reponse_min);
clc;
disp("Le contraste vaut " + num2str(c));

