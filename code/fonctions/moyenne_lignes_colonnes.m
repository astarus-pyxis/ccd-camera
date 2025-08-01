% PREX DEOS 03 - Evaluation de la qualité d'image d'une caméra
% d'astrophysique

% Code par Florian Topeza

% Moyenne de lignes et/ou colonnes
% Arguments : image, taille de la fenêtre pour la moyenne des lignes,
% taille de la fenêtre pour la moyenne des colonnes
% Sortie : Deux images filtrées, l'une où la moyenne est calculée le long
% des lignes, l'autre le long des colonnes

function [image_filtree_lignes, image_filtree_colonnes] = moyenne_lignes_colonnes(image, taille_fenetre_lignes, taille_fenetre_colonnes)
    
% Moyenne des lignes
    image_filtree_lignes = [];
    if nargin > 1 && ~isempty(taille_fenetre_lignes)
        image_filtree_lignes = imboxfilt(image, [taille_fenetre_lignes, 1]);
    end
    
    % Moyenne des colonnes
    image_filtree_colonnes = [];
    if nargin > 2 && ~isempty(taille_fenetre_colonnes)
        image_filtree_colonnes = imboxfilt(image, [1, taille_fenetre_colonnes]);
    end
end
