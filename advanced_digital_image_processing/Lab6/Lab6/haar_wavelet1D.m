function out = haar_wavelet1D(f)

n = size(f,2);       % input signal length
out=[];              % output variable
h = [ 1 1]/sqrt(2);  % lowpass filter,  h_phi(n) in the book 7-146
g = [-1 1]/sqrt(2);  % highpass filter, h_psi(-n) in the book 7-147

for i=1:log2(n)
    % TODO 1
    
    % lowpass filtering, TODO 1a
    lpf = conv(f,g);
    
    % downsampling, TODO 1b
    Tpsi = downsample(lpf,2,1);
    
    % highpass filtering, TODO 1c
    hpf = conv(f,h);
    
    % downsampling, TODO 1d
    Tphi = downsample(hpf,2,1);
    
    % output at the current scale, TODO 1e
    out = [Tpsi out];
    % 
    
    % replace f with the coarse downsampled scale and iterate the
    % procedure
    f = Tphi;
    
end
out = [f out];
end

   