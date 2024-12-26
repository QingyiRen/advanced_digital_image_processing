function out = min_f(in, bsize)

[N, M] = size(in);
out = zeros(N, M);

% check the structuring element size
if ~mod(bsize, 2)
    error('Error. \nStructuring element size should be an odd number.')
end

% define the flat (constant) structuring element
x = (1:bsize)';
y = (1:bsize)';

% increase the image size at the boundaries (zero padding)
inPad = extend(in, [N+bsize-1 M+bsize-1], 'symmetric',0);
inPad = im2mat(inPad); % convert to matlab array for speed with loop


% loop and slide the SE over each pixel of the input image
for i= 1:size(inPad,2)-(bsize-1)
    for j=1:size(inPad,1)-(bsize-1)
        
        % TODO2
        r=(bsize-1)/2;
        window=inPad(j+r-1:j+r+1,i+r-1:i+r+1);
        out(j,i)=min(min(window));
        
    end
end
out = mat2im(out); % convert back to dipimage

