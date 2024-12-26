x = linspace(-3.14,3.14,256);
y = sin(x);
z = noise(y, 'gaussian', 0.25, 0);
z = im2mat(z);
f = z; 

% f = [1 4 -3 0];
n = size(f,2);
h = [ 1 1]/sqrt(2);  % lowpass filter,  h_phi(n) in the book 7-146
g = [-1 1]/sqrt(2);  % highpass filter, h_psi(-n) in the book 7-147
out = [];
% -1/sqrt(2)
% -3/sqrt(2)
% 7/sqrt(2)
for i = 1:log2(n)
    lpf = conv(f,g); 
    Tpsi= downsample(lpf,2,1);  
    hpf = conv(f,h); 
    Tphi = downsample(hpf,2,1);
    out = [Tpsi out] ;
    f = Tphi; 
end
wf = [f out]
A = [1 4 -3/sqrt(2) -3/sqrt(2)]
%%
h = [1 1]/sqrt(2);     % lowpass filter,  h_phi(n) in the book
g = [1 -1]/sqrt(2);     % highpass filter, h_psi(-n) in the book     
for j = 1:log2(n)
    Coarse = wf(1:2^(j-1)); %1
    Detail = wf(2^(j-1)+1:2^j); %4
    % phi Coarse 1 0
    upc= upsample(Coarse,2);
    Wphi = conv(upc,h) ;
    % psi Detail 4 0
    upd = upsample(Detail,2);
    Wpsi = conv(upd,g);
    % sum
    wf(1:2^j) = Wphi(1:2^j) + Wpsi(1:2^j);
end
out = wf