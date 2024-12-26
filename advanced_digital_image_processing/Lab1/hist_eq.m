function out = hist_eq(in)

    [N, M] = size(in);
    out = zeros(N, M);

    % TODO3
    % compute the image histogram
    hist  = zeros(1, 256);        
    for i=1:M
        for j=1:N
            grayValue = in(j,i)+1;
            hist(grayValue) =hist(grayValue)+1;%TODO3a
        end
    end

    % perform histogram equalization
    for i = 1:M
        for j = 1:N
            sum = 0;
            grayValue = in(j,i)+1;
            % here the CDF is compute
            for pp=1:grayValue
               sum=sum+hist(pp);
            end
            out(j,i) = sum/N/M;
        end
    end

    % rescale the intensities to [0, 255]
    %TODO3d
    maxvalue=max(max(out));
    minvalue=min(min(out));
     for i = 1:M
        for j = 1:N
            out(j,i) =out(j,i)-minvalue;
            out(j,i) = out(j,i)/(maxvalue-minvalue)*255;
        end
    end
end