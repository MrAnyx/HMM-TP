function [A] = matrice_transition(fichier)
    
    fileID = fopen(fichier,'r');
    formatSpec = '%c';
    fileContent = fscanf(fileID,formatSpec); 
    
    liste = strsplit(fileContent, ' ');
    
    len = length(liste);
    
    A = zeros(26,26);
    
    nbLettres = zeros(1, 26);
    
    for i = 1:1:len % on parcourt les mots
        mot = cell2mat(liste(i));
       
        if strlength(mot) > 1
            
            for j = 1:1:strlength(mot)-1 % on parcourt les lettres d'un mot
                etatDep = double(mot(j))-96; % lettre n
                etatArr = double(mot(j+1))-96; % lettre qui suit (n+1)
                A(etatDep, etatArr) = A(etatDep, etatArr) + 1; % on compte de nombre de 'y' après 'x'
                nbLettres(etatDep) = nbLettres(etatDep) + 1; % on compte le nombre de lettres après 'x'
            end
        end
    end
    
    for k = 1:1:26
       for m = 1:1:26
          A(k, m) = A(k, m) / nbLettres(k); % on divise le tout pour ramener la somme à 1
       end
    end
    fclose(fileID);
    
    for n = 1:1:26
       if round(sum(A(n, 1:26)), 5) ~= 1,00000
          disp("Erreur: la matrice ne vérifie pas la propriété des matrice stochastiques");
          return;
       end
    end
    
end

