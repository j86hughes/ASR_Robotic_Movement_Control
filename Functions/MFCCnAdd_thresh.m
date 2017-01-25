function [ mfcc_matrix ] = MFCCnAdd_thresh( file,fs,noise,snr,lowMat,highMat )

%   Returns a thresholded MFCC matrix of an audio file that 
%   has added noise at a specified SNR

[audio,fs1]=audioread(file);
 
nAudio = addnoise2(audio,noise,snr);     % need to add noise here

MFCC = getMFCC(nAudio,fs);               % get MFCCs
MFCC(~isfinite(MFCC))=0;                % turn inf values to 0s

% two copis of MFCC matrix
mfcc_high = MFCC;
mfcc_low = MFCC;

% create a matrix were only negative values below a threshold are kept
for counter = 1:12  
thisRow = mfcc_low(counter,:);    
idmax = (thisRow >= lowMat(counter)/1.5);       % 66.7% of threshold values
%idmax = (thisRow >= lowMat(counter));          % 100% of threshold values
thisRow(idmax) = 0;
mfcc_low(counter,:) = thisRow;
end

% create a matrix were only positive values above a threshold are kept
for counter = 1:12  
thisRow = mfcc_high(counter,:);    
idmax = (thisRow <= highMat(counter)/1.5);      % 66.7% of threshold value
%idmax = (thisRow <= highMat(counter));      
thisRow(idmax) = 0;
mfcc_high(counter,:) = thisRow;
end

% add matrices together
mfcc_new = mfcc_low + mfcc_high;
mfcc_matrix = mfcc_new;

% make sure MFCC matrix is correct length
if length(mfcc_matrix) < 85
    addOn = 85 - length(mfcc_matrix);
    addOnMat = zeros(12,addOn);
    mfcc_matrix = [mfcc_matrix,addOnMat];
end

mfcc_matrix = mfcc_matrix(:,1:85);

end

