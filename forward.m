function [P, alpha] = forward(O, A, B, PI)

    N = 26;
    O2 = zeros(1, length(O));
    P = 0;
    T = length(O);
    
    % conversion du mot en array de nombre
    for j = 1:1:T
       O2(j) = double(O(j))-96; 
    end
    
    % Initialisation
    for i = 1:1:N
       alpha(1, i) = PI(i, 1)*B(i, O2(1));
    end
    
    % Induction
    for t = 1:1:T-1
        for j = 1:1:N
            tmp = 0;
            for k = 1:1:N
               tmp = tmp + (alpha(t, k)*A(k, j));
            end
            alpha(t+1, j) = B(j, O2(t+1))*tmp;
        end
    end
   
    for m = 1:1:N
        P = P + alpha(T, m);
    end
end

