classdef State < Equity
    
% Class State: Subclass of Equity. Idea is to have a class, which saves all
% the available data of the world bank or similiar data in one object. Has the properties of
% State and the properties gini_data, year_of_data, GDP and total_pop.
    
    properties

        gini_data                % Gini-Index as received from World Bank
        year_of_data            % Year of World Bank Data Set
        gdp                     % GDP of the country (values in excel table are given in constant 2010 US Dollar)
        total_pop               % Total population
        
    end
    
    
    methods
        
        function obj = State(country,dist_vector,gini_data,share_pop,year_of_data,gdp,total_pop) %Constructor
                 obj@Equity(country, dist_vector, share_pop);                  
                 obj.gini_data = gini_data;
                 obj.year_of_data = year_of_data;
                 obj.gdp = gdp;
                 obj.total_pop = total_pop;             
        end
        
        function eps = epsilon(obj)
            %Calculates equity parameter with data set's gini index
            eps = (1-obj.gini_data)/(1+obj.gini_data); 
        end
        
        function y = gdp_per_head(obj)
            %Calculates the GDP per head
            y = obj.gdp/obj.total_pop;
        end
        
        function y = income_per_head_in_share(obj) 
            % Calculates the income for a given share of the population
            
            values = zeros(length(obj.share_pop)-1,1);
            for i = 1 : length(obj.share_pop) - 1
                
       
                values(i) = obj.gdp * obj.dist_vector(i+1) / ((obj.share_pop(i+1)- obj.share_pop(i))*obj.total_pop); 
                
                
            end
            
            y = values;
        
        end
        
        function y = persons_in_share(obj) 
 
            result = diff(obj.share_pop) * obj.total_pop;
            y = result;
            
        end
        
        
        
    end
    
end

    
   
    