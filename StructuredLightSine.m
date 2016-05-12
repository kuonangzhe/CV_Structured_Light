% Image Issues
% Sin Image for testing
% Author: Chongzhao Mao

% Prepare parameter
% I_bright(Pc) = alpha(Pc, xl) + A(Pc)
% I_dark(Pc) = A(Pc)
alpha = I_bright - I_dark;
A = I_dark;

% Projection Patterns
% P(xl) = op + ap * cos(phi + 2 * pi * (i-1) / 3) 
N = 3;
m = 400;
n = 100;
op = 0.5;
ap = 0.5;
p = zeros(m,10*n);
for a = 1:N
    for xl = 1:10*n
        p(1:m,xl) = ones(m,1) * cos(2*pi*xl/n + 2*pi*(a-1)/N);
    end
    P{a} = p;
end


% Captured Intensities
% I_i(Pc) = oc(Pc) + ac(Pc) * cos(phi_p + 2 * pi * (i-1) / 3)
% oc = alpha(Pc,xl) * op + A(Pc)
% ac = alpha(Pc,xl) * ap
oc = alpha * op + A;
ac = alpha * ap;

% do calibration

% Calculate phase phi and xl
% I = M*X
% X = [oc, ac*cos(phi), ac*sin(phi)]'
% xl = N * phi_p / (2*pi)
N = 3;
phi = zeros(m,n);
for p = 1:m
    for q = 1:n
        I = [];
        for num = 1:N
        I = [I, I{num}(p,q)];
        end
        I = I';
        for i = 1:N
            M(i,:) = [1 cos(2*pi*(i-1)/N) -sin(2*pi*(i-1)/N)];
        end
        X = pinv(M)*I;
        if X(3) >= 0
            phi_p = arccos(X(2)/sqrt(X(2)^2 + X(3)^2));
        else 
            phi_p = 2*pi - arccos(X(2)/sqrt(X(2)^2 + X(3)^2));
        end
        phi(p,q) = phi_p; 
    end
end

figure, 
plot(phi);
       
