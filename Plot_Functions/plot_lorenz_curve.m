function y = plot_lorenz_curve(states,type,model_data)


type_values = {'standard','pareto','polynomial'};
model_data_values = {'model','data'};
if  ~ismember(type,type_values)
    disp("This is no valid type")
    return
elseif ~ismember(model_data,model_data_values)
    disp("Tell, whether to plot with gini of model or data")
    return
end


switch type
    
    case 'standard'
        switch model_data
            case 'model'
                y = plot_mixed_mult_model(states);
        
            case 'data'
                y = plot_mixed_mult_data(states);
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    case 'pareto'
        switch model_data
            case 'model'
                y = plot_pareto_mult_model(states);
            case 'data'
                y = plot_pareto_mult_data(states);
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    case 'polynomial'
        switch model_data
            case 'model'
                y = plot_polynomial_mult_model(states);
            case 'data'
                y = plot_polynomial_mult_data(states);
                
        end
        
  
end

    
