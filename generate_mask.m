function [ img ] = generate_mask(img)
    % img must be truecolor of size m-by-n-by-3
    h = fspecial('average', 20);
	img = imfilter(img,h);
end