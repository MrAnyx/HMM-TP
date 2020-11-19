function [confusion, en, fr, lang] = guessLang(O, Aen, Afr, B, PI)

    T = length(O);
    marker = [0, 0];
    fr = [];
    en = [];
    
    for i = 1:1:T
        mot = cell2mat(O(i));
        numberMot = double(mot)-96;
        
        Pen = 0;
        Pfr = 0;
        
        if max(numberMot) <= 26 && min(numberMot) >= 1 && length(mot) > 1
            [Pen, alphaEn] = forward(mot, Aen, B, PI);
            [Pfr, alphaFr] = forward(mot, Afr, B, PI);
        end
        
        if Pen > Pfr 
            marker(1) = marker(1) + 1;
            en = [en, [mot, ' ']];
        elseif Pen < Pfr
            marker(2) = marker(2) + 1;
            fr = [fr, [mot, ' ']];
        else
            marker = marker + 1;
        end
            
    end
    
    fprintf("\nLe texte est anglais avec un probabilit� de %.2f %% et fran�ais avec une probabilit� de %.2f %%\n", marker(1)/sum(marker)*100, marker(2)/sum(marker)*100);
    confusion = [marker(1)/sum(marker), marker(2)/sum(marker)];
    
    if marker(1) > marker(2)
        lang = "anglais";
        fprintf("Les mots mal class�s sont : %s\n", fr);
    elseif marker(1) < marker(2)
        lang = "fran�ais";
        fprintf("Les mots mal class�s sont : %s\n", en);
    else
        lang = "ind�termin�";
    end
    
    
end

