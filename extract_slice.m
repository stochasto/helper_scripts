% Extract a slice along z. snum is the slice number, for example if nz = 10
% then the center slice is snum = 5.
% fmt is the format, if single is given its 4 bytes, if uint8 its 1, etc

function [A, I] = extract_slice(x,y,snum,fname,fmt)

switch fmt
    case 'single'
        numbytes = 4;
    case 'uint16'
        numbytes = 2;
    case 'uint8'
        numbytes = 1;
end

fid = fopen(fname,'r');
fseek(fid,x*y*snum*numbytes,'bof');
%A = fread(fid,x*y,'single=>single');
A = fread(fid,x*y,fmt);
I = reshape(A,x,y);
fclose(fid);
%save Z.mat Z