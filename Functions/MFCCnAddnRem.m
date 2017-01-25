function [ MFCC ] = MFCCnAddnRem( file,fs,noiseMFCC,noise,snr )

%   Returns an MFCC matrix of an audio file that 
%   has added noise at a specified SNR. The matrix is the result of 
%   subtracting values from the given noise MFCC matrix.

[audio,fs1]=audioread(file);
 
nAudio = addnoise2(audio,noise,snr);     % need to add noise here

MFCC = getMFCC(nAudio,fs);               % get MFCCs
MFCC(~isfinite(MFCC))=0;                % turn inf values to 0s

% % get length of MFCC matrix
% l = length(MFCC);
% 
% addOn = 0;
% 
% if l < 170
%     addOn = 170 - l;
% end
% 
% tackOn = zeros(12,addOn);
% 
% MFCC = [MFCC , tackOn];
                    
                    MFCC = MFCC(:,1:85) - noiseMFCC(:,1:85);       % subtract ambient noise MFCCs

% 
%                     % need to check number of columns here
%                     if size(MFCC,2) == size(noiseMFCC,2)                   
%                         MFCC = MFCC - noiseMFCC;       % subtract ambient noise MFCCs
%                     end
%                     
%                     if size(MFCC,2) > size(noiseMFCC,2)                   
%                         MFCC = MFCC(:,1:85) - noiseMFCC(:,1:85);       % subtract ambient noise MFCCs
%                         %MFCC = MFCC(:,1:170) - noiseMFCC(:,1:170);       % subtract ambient noise MFCCs
%                     end
%                     
%                     if size(MFCC,2) < size(noiseMFCC,2)                   
%                         MFCC = MFCC(:,1:85) - noiseMFCC(:,1:85);       % subtract ambient noise MFCCs
%                         %MFCC = MFCC(:,1:170) - noiseMFCC(:,1:170);       % subtract ambient noise MFCCs
%                     end

%MFCC = MFCC - noiseMFCC;                % noise removal 

end

