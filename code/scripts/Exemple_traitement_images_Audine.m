%% INITIALISATION

clearvars;
close all;
clc;

PathProg = pwd;

%% DEFINITION DES DONNEES A TRAITER

% Emplacement des fichiers %
MeasurementFolder = 'D:\PREX\2023\DonneesTest';

% Definition de la variable d'entree
InputVariable = 1:1:60; % ici, le numéro du fichier

% Définition de la Region of interest (ROI)
ROI_Coord = [10 500 20 740]; % ROI_Coord = [premiere_ligne derniere_ligne premiere_colonne derniere_colonne];

% Nombre de fichiers à traiter %
FileNumber = size(InputVariable,2);

%% EXEMPLE : CHARGEMENT D'UNE SERIE D'IMAGES + CALCULS MOY

% Début du nom du fichier %
FileName_Start = 'TestCamera';

for ind_file = 1:FileNumber
    
    % Construction du nom du fichier en utilisant l'indice de la boucle %
    FileName = [FileName_Start num2str(ind_file) '.fit'];
    
    % Chargement des fichiers et remplissage du cube de données
    Data(:,:,ind_file)=fitsread(fullfile(MeasurementFolder,FileName));
    
    % Calcul de la moyenne de réponse sur une ROI
    Mean_Signal(ind_file,1)=mean2(Data(ROI_Coord(1,1):ROI_Coord(1,2),ROI_Coord(1,3):ROI_Coord(1,4),ind_file));
    
    % Calcul de la moyenne par colonne dans la ROI (--> vecteur ligne)
    Mean_Row(ind_file,:)=mean(Data(ROI_Coord(1,1):ROI_Coord(1,2),ROI_Coord(1,3):ROI_Coord(1,4),ind_file),1);
    
    % Calcul de la moyenne par ligne dans la ROI (--> vecteur colonne)
    Mean_Column(:,ind_file)=mean(Data(ROI_Coord(1,1):ROI_Coord(1,2),ROI_Coord(1,3):ROI_Coord(1,4),ind_file),2);
    
end


figure;
plot(InputVariable,Mean_Signal,'-x');
title(FileName_Start)
