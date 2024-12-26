function [indices, newMean, stop_flag] = MoveMean(data, oldMean, radius, stopThreshold)

        % get the number of data points (data is dimxN where dim is the
        % dimension)
        [~,N] = size(data); 
        
        % TODO 5
        % compute the sum of the squared differences of the mean 
        % (oldMean) to all data points (data)
        dif = zeros(3,N);
%         distances = zeros(1,N);
        for j = 1:N
            dif(:,j) = abs( data(:,j) - oldMean );
%             distances(:,j) = sum( (data(:,j) - oldMean).*(data(:,j) - oldMean),1 );
        end         
        distances = sum(dif.^2,1);
%         distances = sum((data - oldMean).^2,1);
        
        % TODO 6
        % find all the data points within the neighbourhood defined by the
        % oldMean and the radius
        indices = find(distances - radius < 0); 
        
        % TODO 7        
        % compute the mean (newMean) of the points within that neighborhood  
        newMean = mean(data(:,indices),2);
%         newMean = sum(data(:,indices),2)./length(indices);
        
        % TODO 8
        % set stop_flag to 1 if the Euclidean distance between the newMean and oldMean 
        % is below stopThreshold. Look at norm() funcion in MATLAB docs.  
        if norm(newMean - oldMean) < stopThreshold
            stop_flag = 1;
        else 
            stop_flag = 0;
        end
        
end