function y = mixed_lorenz(x,epsilon,a)
% Standard Lorenz curve for given a, epsilon and x. x can be vector.

f = @(x) a* (1-(1-x).^epsilon) + (1-a) * x.^(1/epsilon);
y = f(x);