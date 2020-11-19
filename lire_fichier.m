function [O] = lire_fichier(fichier)

    fileID = fopen(fichier,'r');
    formatSpec = '%c';
    fileContent = fscanf(fileID,formatSpec); 
    
    O = strsplit(fileContent, ' ');
   
end

