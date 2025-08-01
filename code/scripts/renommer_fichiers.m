% PREX DEOS 03 - Evaluation de la qualité d'image d'une caméra
% d'astrophysique

% Code par Florian Topeza

% Renommer toutes les images d'un dossier

clc;
PathProg = pwd;

% Chemin du dossier avec les images à renommer
chemin_dossier = "..\..\images\Séance 3\Binning 17.5";

fichiers = dir(fullfile(chemin_dossier, '*.fit')); % Modifier "*.fit" selon votre format d'image
nombre_images = numel(fichiers);

% Boucle à travers les fichiers
for i = 1:nombre_images
    % Ancien nom de fichier
    ancien_nom = fullfile(chemin_dossier, "B44 (" + num2str(i) + ").fit"); % Ancien format du nom des images
    
    % Nouveau nom de fichier
    nouveau_nom = fullfile(chemin_dossier, "B44" + num2str(i) + ".fit"); % Nouveau format du nom des images
    
    % Renomme le fichier
    if exist(ancien_nom, 'file') == 2
        movefile(ancien_nom, nouveau_nom);
        disp(["Le fichier " ancien_nom " a été renommé en " nouveau_nom]);
    else
        disp(["Le fichier " ancien_nom " existe pas."]);
    end
end
