function [foot] = separate_foot(img)
% SEPARATE_FOOT Separates left and right foot from input image and
% generates foot structure for storing information of further processing.
% 
% Input Parameter :
%       img         Raw Truecolor image of Foot
%
% Output Parameter:
%       foot        Struct storing left and right foot information
%                   It has two members
%                       left
%                       right
%                   left is a Structure for left foot having following
%                   members
%                       img     Truecolor Processed Image of Left
%                               Foot Only.
%                       aimg    Truecolor Image without any Preprocessing
%                               of Left Foot Only.
%                       id      Varaible to identify left and right foot.
%                               Id 1 is assigned to left foot and Id 2 is
%                               assigned to right foot.

        im = img;
%       Removing Noise from Image and Generating Mask
        img = generate_mask(img);
        mask = im2bw(img,0.20);
        
%       Identifing Left and Right Foot
        tmp = mask;
        tmp_l = bwconncomp(tmp);
        tmp_numPix = cellfun(@numel,tmp_l.PixelIdxList);
        [~, tmp_big1 ] = max(tmp_numPix);
        tmp_numPix(tmp_big1) = 0;
        [~, tmp_big2 ] = max(tmp_numPix);
        
%       Seperating both foot using identified mask        
        [row, col, ~] = size(img);
        tmp2 = uint8(zeros(row,col));
        tmp2(tmp_l.PixelIdxList{min(tmp_big1, tmp_big2)}) = 1;
        l_img(:,:,1) = uint8(im(:,:,1) .* uint8(tmp2(:,:)));
        l_img(:,:,2) = uint8(im(:,:,2) .* uint8(tmp2(:,:)));
        l_img(:,:,3) = uint8(im(:,:,3) .* uint8(tmp2(:,:)));
        
        tmp2 = uint8(zeros(row,col));
        tmp2(tmp_l.PixelIdxList{max(tmp_big1, tmp_big2)}) = 1;
        r_img(:,:,1) = uint8(im(:,:,1) .* uint8(tmp2(:,:)));
        r_img(:,:,2) = uint8(im(:,:,2) .* uint8(tmp2(:,:)));
        r_img(:,:,3) = uint8(im(:,:,3) .* uint8(tmp2(:,:)));

%       Generating Foot Structure with necessary members at the moment
        foot.left.img = generate_mask(l_img);
        foot.left.aimg = l_img;
        foot.right.img = generate_mask(r_img);
        foot.right.aimg = r_img;
        foot.left.id = 1;
        foot.right.id = 2;
end