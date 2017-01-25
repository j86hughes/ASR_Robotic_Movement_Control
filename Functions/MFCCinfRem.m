function [ MFCC ] = MFCCinfRem( file,fs )

%   Get MFCC matrix from audio 
%   Change all infinite values to zero
%   Resize matrix length to 85 columns

[noise1,fs1]=audioread(file);
noise=resample(noise1,fs,fs1);           % resample to fs
MFCC = getMFCC(noise,fs);                % get MFCCs
MFCC(~isfinite(MFCC))=0;                 % turn inf values to 0s


if length(MFCC) < 85                     % make sure MFCC matrix in correct length
    addOn = 85 - length(MFCC);
    addOnMat = zeros(12,addOn);
    MFCC = [MFCC,addOnMat];
end
 
MFCC = MFCC(:,1:85);

end

