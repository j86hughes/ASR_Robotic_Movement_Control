function [ mfcc_matrix ] = getMFCC( audio , frequency )

%   Returns of matrix of MFCCs from a given audio file
%   at a specified frequency

%[s,fs]=audioread('../b0022.wav');
s=audio;
fs=frequency;
Ws=1024;
Ol=512;
L=floor((length(s)-Ol)/Ol);
N=12;

mfcc_matrix=zeros(N,L);
for n=1:L
    seg=s(1+(n-1)*Ol:Ws+(n-1)*Ol);
    mfcc_matrix(:,n)=mfcc_model(seg.*hamming(1,Ws), 40, N, fs);
end
% waterfall([1:L]*length(s)/(L*fs),[1:N],mfcc_matrix)
% xlabel('Time, s')
% ylabel('Amplitude')
% ylabel('Band')
% zlabel('Amplitude')


end

