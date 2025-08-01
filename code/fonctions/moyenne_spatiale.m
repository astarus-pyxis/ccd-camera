% PREX DEOS 03 - Evaluation de la qualité d'image d'une caméra
% d'astrophysique

% Code par Florian Topeza

% Moyenne spatial sur des régions de l'image
% Arguments : image, taille de la fenêtre de la moyenne spatiale
% Sortie : image (au format png) moyennée

function image_filtree = moyenne_spatiale(image, taille_fenetre)

% Taille de l'image
    [rows, cols] = size(image);
    
    % Initialisation de l'image filtrée
    image_filtree = zeros(rows, cols);
    
    % Calcul de la demi-taille de la fenêtre
    demi_taille_fenetre = floor(taille_fenetre / 2);

    % Parcours de l'image
    for i = 1:rows
    
        for j = 1:cols
        
        % Calcul des indices de la fenêtre
            i_debut = max(1, i - demi_taille_fenetre);
            i_fin = min(rows, i + demi_taille_fenetre);
            j_debut = max(1, j - demi_taille_fenetre);
            j_fin = min(cols, j + demi_taille_fenetre);
            
            % Extraction de la région de l'image
            region = image(i_debut:i_fin, j_debut:j_fin);
            
            % Calcul de la moyenne de la région
            moyenne_region = mean(region, 'all');
            
            % Attribution de la moyenne à l'image filtrée
            image_filtree(i, j) = moyenne_region;
        end
    end
end
