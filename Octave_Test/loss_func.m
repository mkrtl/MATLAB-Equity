function y = loss_func(x,eps,a)

%Calculates the value of the loss function depending on a and Equity parameter
%epsilon at all points of x and gives it back as a vector.

    f=@(x) a.*eps.*(1-x).^(eps-1)+(1-a)*(1/eps).*(x.^((1/eps)-1)) - ...
        (a.*(eps-.01).*(1-x).^((eps-.01)-1)+(1-a)*(1/(eps-.01)).*(x.^((1/(eps-.01))-1)));
    y=f(x);
    
end