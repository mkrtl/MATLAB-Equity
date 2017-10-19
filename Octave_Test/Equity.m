classdef Equity
%Equity class: Has country and dist_vector as properties. 
%Idea is to give users a class, where only the minimum information is
%needed. 
%Also, combination of objects in the state class are considered to end up
%as an Equity object. Therefore, a year of data might be needed here as well. 
    properties
        country
        dist_vector
        share_pop
        
        
    end
    methods 
        
        function obj = Equity(country,dist_vector,share_pop)        %constructor
                    obj.country = country;
                    obj.dist_vector = dist_vector;   
                    obj.share_pop = share_pop;
                    
        end
        
        
        function y=epsilon_model(obj)
            
            %Calculates equity parameter through minimizing mean square errror of mixed curve with a=0.6
            %and with given data points. See find_epsilon function. 
            fit_result = find_epsilon_mixed(obj);
            y = fit_result.epsilon;
            
                    
        end
                    
       
        function y=gini_model(obj)
        
            %Calculates Gini-index with epsilon of model
            epsilon = obj.epsilon_model;
            y=(1-epsilon)/(1+epsilon); 
        
        end
        
        function y = cumulated_dist_vector(obj)
            
            %calculates the cumulated share of the income. 
            
            y = cumsum(  obj.dist_vector)/sum(obj.dist_vector); 
            
            % Because of rounding of by World Bank for the income data the
            % sum of obj.dist_vector might be unequal to 1. We compensate
            % that by normalizing the vector.
            
        end
        
        function y = gini_trapezoid(obj) 
        
            % Calculates the value with given data points using the
            % trapezoid rule. It is especially useful, if the number of
            % data points is high. 
            
            integral = trapz(obj.share_pop,obj.cumulated_dist_vector);
            y = 2*(0.5-integral);
        
        end
        
    
        
    end
end


        