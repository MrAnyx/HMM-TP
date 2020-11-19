clear all;
clc

%% I - b1
% creation de la matrice d'emission 
B = matrice_emission("./TP/matrice_emission.xls");
% B = eye(length(B));

%% I - b2
% creation de la matrice de transition
Afr = matrice_transition('./TP/matrice_transition_FR.txt');
Aen = matrice_transition('./TP/matrice_transition_EN.txt');

%% I - c1
% Algorthme de Forward
PI = ones(26, 1) ./ 26;

% [P1, alpha] = forward('probablement', Afr, B, PI);

%% I - c2
% Algorthme de Backward

% [P2, beta] = backward('probablement', Afr, B, PI);

%% I - c3
[P1, alpha1] = forward('probablement', Aen, B, PI);	% 3.1745e-15
[P2, alpha2] = forward('probably', Aen, B, PI);      % 4.2232e-11

%% I - c4
[P3, beta1] = backward('probablement', Afr, B, PI);	% 4.7530e-14
[P4, beta2] = backward('probably', Afr, B, PI);      % 1.8184e-12

%% I - c4-bis
probablementPourcentage = [P1 P3]/sum([P1, P3]);
probablyPourcentage = [P2 P4]/sum([P2, P4]);

%% I - c5
confusion = [P1, P2; P3, P4];

%% I - c6
fprintf("Le mot 'probablement' est fran�ais � %.2f %%\n", probablementPourcentage(2)*100); 
fprintf("Le mot 'probablement' est anglais � %.2f %%\n", probablementPourcentage(1)*100); 

if P1 > P3
   fprintf("Donc le mot 'probablement' est anglais\n\n"); 
else
   fprintf("Donc le mot 'probablement' est fran�ais\n\n"); 
end

fprintf("Le mot 'probably' est fran�ais � %.2f %%\n", probablyPourcentage(2)*100); 
fprintf("Le mot 'probably' est anglais � %.2f %%\n", probablyPourcentage(1)*100); 

if P2 > P4
   fprintf("Donc le mot 'probably' est anglais\n\n"); 
else
   fprintf("Donc le mot 'probably' est fran�ais\n\n"); 
end

%% I - c7a
Ofr = lire_fichier("./TP/texte_1.txt");     % texte fran�ais
Oen = lire_fichier("./TP/texte_2.txt");     % texte anglais
Otest = lire_fichier("./TP/texte_3.txt");   % texte avec uniquement des lettres

%% I - c7b
[confusionFr, en1, fr1, lang1] = guessLang(Ofr, Aen, Afr, B, PI);
[confusionEn, en2, fr2, lang2] = guessLang(Oen, Aen, Afr, B, PI);
[confusionTest, en3, fr3, lang3] = guessLang(Otest, Aen, Afr, B, PI);

% confusionFr
% confusionEn

%% I - d1
[Pfr, qfr] = viterbi('prohabhememf', Afr, B, PI);
[Pen, qen] = viterbi('prohabhememf', Aen, B, PI);

%% I - d2
fprintf("\nLe mot le plus proche de 'prohabhememf' en fran�ais est '%s' avec une probabilit� de %d %% \n", char(qfr+96), Pfr*100);

%% I - d3
fprintf("Le mot le plus proche de 'prohabhememf' en anglais est '%s' avec une probabilit� de %d %% \n", char(qen+96), Pen*100);

%% I - d4
% La matrice d'emission a une grande importance sur le r�sultat que l'on
% obtient

B = eye(26);
[Pfr, qfr] = viterbi('prohabhememf', Afr, B, PI);
[Pen, qen] = viterbi('prohabhememf', Aen, B, PI);
fprintf("\nLe mot le plus proche de 'prohabhememf' en fran�ais avec la matrice identit� est '%s' avec une probabilit� de %d %% \n", char(qfr+96), Pfr*100);
fprintf("Le mot le plus proche de 'prohabhememf' en anglais avec la matrice identit� est '%s' avec une probabilit� de %d %% \n", char(qen+96), Pen*100);
