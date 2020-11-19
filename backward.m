function [P, beta] = backward(O, A, B, PI)
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
       beta(T, i) = 1;
    end
    
     % Induction
    for t = T-1:-1:1
        for i = 1:1:N
            tmp = 0;
            for j = 1:1:N
              tmp = tmp + (beta(t+1, j)*A(i, j)*B(j, O2(t+1)));
            end
            beta(t, i) = tmp;
        end
    end
   
    for i = 1:1:N
        P = P + (PI(i, 1)*B(i, O2(1))*beta(1, i));
    end
end

