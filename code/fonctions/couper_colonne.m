% PREX DEOS 03 - Evaluation de la qualité d'image d'une caméra
% d'astrophysique

% Code par Florian Topeza

% Coupe une colonne donnée de l'image et retourne l'image avec la colonne
% coupée
% Arguments : image, indice de la colonne à couper
% Sortie : image avec la colonne spécifiée en moins

function image_coupee = couper_colonne(image, indice_colonne)
    % Vérifier l'indice de la colonne
    if indice_colonne < 1 || indice_colonne > size(image, 2)
        error('L''indice de colonne est en dehors des limites de l''image.');
    end
    
    % Copier l'image
    image_coupee = image;
    
    % Couper la colonne
    image_coupee(:, indice_colonne) = [];
end
