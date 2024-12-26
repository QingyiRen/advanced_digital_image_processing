function out = inv_haar_wavelet1D(f)

    n = size(f,2);          % input signal length
    h = [ 1 1]/sqrt(2);     % lowpass filter,  h_phi(n) in the book
    g = [-1 1]/sqrt(2);     % highpass filter, h_psi(-n) in the book  
    
    for j=1:log2(n)
        
        % select coarse part of the input
        Coarse = f(1:2^(j-1));
        
        % select detail part of the input
        Detail = f(2^(j-1)+1:2^j);
        
        % TODO 2
        
        % upsampling, TODO 2a
        upc= upsample(Coarse,2);

        % lowpass filtering, TODO 2b
        Wphi = conv(upc,h);

        % upsampling, TODO 2c
        upd = upsample(Detail,2);

        % highpass filtering, TODO 2d
        Wpsi = conv(upd,g);

        % summing up
        f(1:2^j) = Wphi(1:2^j) + Wpsi(1:2^j);
        
    end
    out = f;

end