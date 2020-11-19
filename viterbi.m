function [P, s] = viterbi(O, A, B, PI)

    N = 26;
    T = length(O);
    
    for j = 1:1:T
       O2(j) = double(O(j))-96; 
    end
    
    for i = 1:1:N
        delta(1, i) = PI(i, 1)*B(i, O2(1));
        psi(1, i) = 0;
    end
    
    for t = 1:1:T-1
        for j = 1:1:N
            [maxi, psi(t+1, j)] = max(delta(t, :).*transpose(A(:, j)));
            delta(t+1, j) = B(j, O2(t+1))*maxi;
        end
    end
    
    [P, s(T)] = max(delta(T, :));
    
    for t = T-1:-1:1
        s(t) = psi(t+1, s(t+1));
    end

end