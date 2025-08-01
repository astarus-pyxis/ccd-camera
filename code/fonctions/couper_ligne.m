% PREX DEOS 03 - Evaluation de la qualité d'image d'une caméra
% d'astrophysique

% Code par Florian Topeza

% Coupe une ligne donnée de l'image et retourne l'image avec la ligne
% coupée
% Arguments : image, indice de la ligne à couper
% Sortie : image avec la ligne spécifiée en moins

function image_coupee = couper_ligne(image, indice_ligne)
    % Vérifier l'indice de la ligne
    if indice_ligne < 1 || indice_ligne > size(image, 2)
        error('L''indice de la ligne est en dehors des limites de l''image.');
    end
    
    % Copier l'image
    image_coupee = image;
    
    % Couper la colonne
    image_coupee(:, indice_ligne) = [];
end
