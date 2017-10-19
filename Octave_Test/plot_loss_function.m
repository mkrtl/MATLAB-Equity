function y=plot_loss_function(curve_type,varargin)

% Plots loss function for different epsilons and a certain curve type. 
% Curve_types are "Polynomial","Pareto" and "Mixed".


x = linspace(0,1,1000);     % linspace for plotting
a = [0,0.6,1];              % possible values of a, depending on choice of curve_type
switch curve_type
    case "Pareto"
        
        for i = 1:length(varargin)
 
            loss=loss_func(x,varargin{i},a(3));  % set a = 1 and calculate values of loss function via loss_func 
            figure;
            y=plot(x(loss>=0),loss(loss>=0));    
            title(['Verlustfunktionen, Pareto, ','(eps1 = ' num2str(varargin{i}) ', eps2 = ' num2str(varargin{i}-.01) ')'])
            axis([0,1,0,max(loss)*1.05])
            xlabel('Einkommensposition')
            ylabel('Einkommensverluste')
            grid on
            hold on  
        end
        hold off 
    
        
        
    case "Mixed"
        
        for i = 1:length(varargin)
 
            loss=loss_func(x,varargin{i},a(2));  % set a = 0.6 and calculate values of loss function via loss_func
            figure;
            y=plot(x(loss>=0),loss(loss>=0));
            title(['Verlustfunktionen, Mixed, ','(eps1 = ' num2str(varargin{i}) ', eps2 = ' num2str(varargin{i}-.01) ')'])
            axis([0,1,0,max(loss)*1.05])
            xlabel('Einkommensposition')
            ylabel('Einkommensverluste')
            grid on
            hold on  
        end
        hold off

    case "Polynomial"
        
        for i = 1:length(varargin)
 
            loss=loss_func(x,varargin{i},a(1));  % set a = 0 and calculate values of loss function via loss_func
            figure;
            y=plot(x(loss>=0),loss(loss>=0));
            title(['Verlustfunktionen, Polynomial, ','(eps1 = ' num2str(varargin{i}) ', eps2 = ' num2str(varargin{i}-.01) ')'])
            axis([0,1,0,max(loss)*1.05])
            xlabel('Einkommensposition')
            ylabel('Einkommensverluste')
            grid on
            hold on  
        end
        hold off

end

end
