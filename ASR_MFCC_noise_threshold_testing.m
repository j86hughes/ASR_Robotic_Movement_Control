%%          

%         - Get MFCCs from segment of noise 
%           and get average filterbank values above and below zero
%         - Average filterbank values are used as thresholds
%·        - Extract MFCCs from training command words
%         - Replace any inf values in all MFCC matrices with zeros
%         - Get test utterances, for each utterance: 
%           add noise
%           get MFCC matrix and replace inf values with zeros
%           apply above and below 0 thresholding to two copies of matrix
%           final MFCC matrix is the sum of both copies
%         - Compare test utterance MFCCs with training command word MFCCs using DTW
%         - Get average DTW matching score of each command class
%         - The command class with the (lowest) DTW average score is matched to the utterance
%         - Record DTW score
%         - Record matching score difference between matched command
%           and second closest matched command
%         - Record if utterance was correctly matched

 
%% set up variables 

clear;clc;close all;

disp('Start...');

mex dtw_c.c;                    % DTW
w=50;                           % DTW

fs = 44100;                     % sampling frequency
Ws=1024;                        % window size?
Ol=512;                         % 50% overlap?
N=12;                           % number of frequency bins?

SamplesPerFrame = 512;          % 


%% testing variables

snr=20;                                         % SNR value 
[noise1,fs1]=audioread('t_factory1.wav');       % get noise signal
wordSet =4;                                     % command to test

%% get MFCCs from 1 second of noisy file

         noise=resample(noise1,fs,fs1);                 % give noise file the same sample rate as everything else   
         noiseLen = length(noise);                      % get length of noise signal    
         r = randi([1 noiseLen-88200],1,1);             % generate random int between 1 and length of sig - 2 seconds   
         noise_seg = noise(r : r + 88199);              % extract 2 second random segment from noise
    
         quiet_matrix = getMFCC(noise_seg,44100);         % get MFCC feature matrix
%          quiet_matrix = getMFCC(noise,44100);               % get MFCC feature matrix
         quiet_matrix(~isfinite(quiet_matrix))=0;           % replace inf with 0s 
         
% for each row in noise matrix:
% get average value above 0
% get average value below 0
r1 = quiet_matrix(1,:);
r1Low = r1<0;
r1LowAv = median(r1(r1Low));
r1High = r1>0;
r1HighAv = median(r1(r1High));

r2 = quiet_matrix(2,:);
r2Low = r2<0;
r2LowAv = median(r2(r2Low));
r2High = r2>0;
r2HighAv = median(r2(r2High));

r3 = quiet_matrix(3,:);
r3Low = r3<0;
r3LowAv = median(r3(r3Low));
r3High = r3>0;
r3HighAv = median(r3(r3High));

r4 = quiet_matrix(4,:);
r4Low = r4<0;
r4LowAv = median(r4(r4Low));
r4High = r4>0;
r4HighAv = median(r4(r4High));

r5 = quiet_matrix(5,:);
r5Low = r5<0;
r5LowAv = median(r5(r5Low));
r5High = r5>0;
r5HighAv = median(r5(r5High));

r6 = quiet_matrix(6,:);
r6Low = r6<0;
r6LowAv = median(r6(r6Low));
r6High = r6>0;
r6HighAv = median(r6(r6High));

r7 = quiet_matrix(7,:);
r7Low = r7<0;
r7LowAv = median(r7(r7Low));
r7High = r7>0;
r7HighAv = median(r7(r7High));

r8 = quiet_matrix(8,:);
r8Low = r8<0;
r8LowAv = median(r8(r8Low));
r8High = r8>0;
r8HighAv = median(r8(r8High));

r9 = quiet_matrix(9,:);
r9Low = r9<0;
r9LowAv = median(r9(r9Low));
r9High = r9>0;
r9HighAv = median(r9(r9High));

r10 = quiet_matrix(10,:);
r10Low = r10<0;
r10LowAv = median(r10(r10Low));
r10High = r10>0;
r10HighAv = median(r10(r10High));

r11 = quiet_matrix(11,:);
r11Low = r11<0;
r11LowAv = median(r11(r11Low));
r11High = r11>0;
r11HighAv = median(r11(r11High));

r12 = quiet_matrix(12,:);
r12Low = r12<0;
r12LowAv = median(r12(r12Low));
r12High = r12>0;
r12HighAv = median(r12(r12High));


highMat = [ r1HighAv;r2HighAv;r3HighAv;r4HighAv;r5HighAv;r6HighAv;r7HighAv;r8HighAv;r9HighAv;r10HighAv;r11HighAv;r12HighAv ];
lowMat = [ r1LowAv;r2LowAv;r3LowAv;r4LowAv;r5LowAv;r6LowAv;r7LowAv;r8LowAv;r9LowAv;r10LowAv;r11LowAv;r12LowAv ];

lowMat(isnan (lowMat)) = 0; 
highMat(isnan (highMat)) = 0; 
         
%% for all training data samples:

        disp('Getting training data MFCCs...');

% 1) exctract MFCCs
% 2) convert any inf values to 0s
% 3) subtract ambient noise MFCCs
            
          % 'stop moving'
          smArray(:,:,1) = MFCCinfRem('Nsm1.wav',fs); 
          smArray(:,:,2) = MFCCinfRem('Nsm2.wav',fs); 
          smArray(:,:,3) = MFCCinfRem('Nsm3.wav',fs);
          smArray(:,:,4) = MFCCinfRem('Nsm4.wav',fs);
          smArray(:,:,5) = MFCCinfRem('Nsm5.wav',fs);
          smArray(:,:,6) = MFCCinfRem('Nsm6.wav',fs);
          smArray(:,:,7) = MFCCinfRem('Nsm7.wav',fs);
          smArray(:,:,8) = MFCCinfRem('Nsm8.wav',fs);
          smArray(:,:,9) = MFCCinfRem('Nsm9.wav',fs);
          smArray(:,:,10) = MFCCinfRem('Nsm10.wav',fs);
          smArray(:,:,11) = MFCCinfRem('Nsm11.wav',fs);
          smArray(:,:,12) = MFCCinfRem('Nsm12.wav',fs);
          smArray(:,:,13) = MFCCinfRem('Nsm13.wav',fs);
          smArray(:,:,14) = MFCCinfRem('Nsm14.wav',fs);
          smArray(:,:,15) = MFCCinfRem('Nsm15.wav',fs);
          smArray(:,:,16) = MFCCinfRem('Nsm16.wav',fs);
          smArray(:,:,17) = MFCCinfRem('Nsm17.wav',fs);
          smArray(:,:,18) = MFCCinfRem('Nsm18.wav',fs);
          smArray(:,:,19) = MFCCinfRem('Nsm19.wav',fs);
          smArray(:,:,20) = MFCCinfRem('Nsm20.wav',fs);
          smArray(:,:,21) = MFCCinfRem('Nsm21.wav',fs);
          smArray(:,:,22) = MFCCinfRem('Nsm22.wav',fs);
          smArray(:,:,23) = MFCCinfRem('Nsm23.wav',fs);
          smArray(:,:,24) = MFCCinfRem('Nsm24.wav',fs);
          smArray(:,:,25) = MFCCinfRem('Nsm25.wav',fs);
          smArray(:,:,26) = MFCCinfRem('Nsm26.wav',fs);
          smArray(:,:,27) = MFCCinfRem('Nsm27.wav',fs);
          smArray(:,:,28) = MFCCinfRem('Nsm28.wav',fs);
          smArray(:,:,29) = MFCCinfRem('Nsm29.wav',fs);
          smArray(:,:,30) = MFCCinfRem('Nsm30.wav',fs);
          
          % 'drive forwards'
          goArray(:,:,1) = MFCCinfRem('Ndf1.wav',fs); 
          goArray(:,:,2) = MFCCinfRem('Ndf2.wav',fs); 
          goArray(:,:,3) = MFCCinfRem('Ndf3.wav',fs);
          goArray(:,:,4) = MFCCinfRem('Ndf4.wav',fs);
          goArray(:,:,5) = MFCCinfRem('Ndf5.wav',fs);
          goArray(:,:,6) = MFCCinfRem('Ndf6.wav',fs);
          goArray(:,:,7) = MFCCinfRem('Ndf7.wav',fs);
          goArray(:,:,8) = MFCCinfRem('Ndf8.wav',fs);
          goArray(:,:,9) = MFCCinfRem('Ndf9.wav',fs);
          goArray(:,:,10) = MFCCinfRem('Ndf10.wav',fs);
          goArray(:,:,11) = MFCCinfRem('Ndf11.wav',fs);
          goArray(:,:,12) = MFCCinfRem('Ndf12.wav',fs);
          goArray(:,:,13) = MFCCinfRem('Ndf13.wav',fs);
          goArray(:,:,14) = MFCCinfRem('Ndf14.wav',fs);
          goArray(:,:,15) = MFCCinfRem('Ndf15.wav',fs);
          goArray(:,:,16) = MFCCinfRem('Ndf16.wav',fs);
          goArray(:,:,17) = MFCCinfRem('Ndf17.wav',fs);
          goArray(:,:,18) = MFCCinfRem('Ndf18.wav',fs);
          goArray(:,:,19) = MFCCinfRem('Ndf19.wav',fs);
          goArray(:,:,20) = MFCCinfRem('Ndf20.wav',fs);
          goArray(:,:,21) = MFCCinfRem('Ndf21.wav',fs);
          goArray(:,:,22) = MFCCinfRem('Ndf22.wav',fs);
          goArray(:,:,23) = MFCCinfRem('Ndf23.wav',fs);
          goArray(:,:,24) = MFCCinfRem('Ndf24.wav',fs);
          goArray(:,:,25) = MFCCinfRem('Ndf25.wav',fs);
          goArray(:,:,26) = MFCCinfRem('Ndf26.wav',fs);
          goArray(:,:,27) = MFCCinfRem('Ndf27.wav',fs);
          goArray(:,:,28) = MFCCinfRem('Ndf28.wav',fs);
          goArray(:,:,29) = MFCCinfRem('Ndf29.wav',fs);
          goArray(:,:,30) = MFCCinfRem('Ndf30.wav',fs);
                             
          % 'left' 
          lArray(:,:,1) = MFCCinfRem('Nl1.wav',fs);
          lArray(:,:,2) = MFCCinfRem('Nl2.wav',fs);
          lArray(:,:,3) = MFCCinfRem('Nl3.wav',fs);
          lArray(:,:,4) = MFCCinfRem('Nl4.wav',fs);
          lArray(:,:,5) = MFCCinfRem('Nl5.wav',fs);
          lArray(:,:,6) = MFCCinfRem('Nl6.wav',fs);
          lArray(:,:,7) = MFCCinfRem('Nl7.wav',fs);
          lArray(:,:,8) = MFCCinfRem('Nl8.wav',fs);
          lArray(:,:,9) = MFCCinfRem('Nl9.wav',fs);
          lArray(:,:,10) = MFCCinfRem('Nl10.wav',fs);
          lArray(:,:,11) = MFCCinfRem('Nl11.wav',fs);
          lArray(:,:,12) = MFCCinfRem('Nl12.wav',fs);
          lArray(:,:,13) = MFCCinfRem('Nl13.wav',fs);
          lArray(:,:,14) = MFCCinfRem('Nl14.wav',fs);
          lArray(:,:,15) = MFCCinfRem('Nl15.wav',fs);
          lArray(:,:,16) = MFCCinfRem('Nl16.wav',fs);
          lArray(:,:,17) = MFCCinfRem('Nl17.wav',fs);
          lArray(:,:,18) = MFCCinfRem('Nl18.wav',fs);
          lArray(:,:,19) = MFCCinfRem('Nl19.wav',fs);
          lArray(:,:,20) = MFCCinfRem('Nl20.wav',fs);
          lArray(:,:,21) = MFCCinfRem('Nl21.wav',fs);
          lArray(:,:,22) = MFCCinfRem('Nl22.wav',fs);
          lArray(:,:,23) = MFCCinfRem('Nl23.wav',fs);
          lArray(:,:,24) = MFCCinfRem('Nl24.wav',fs);
          lArray(:,:,25) = MFCCinfRem('Nl25.wav',fs);
          lArray(:,:,26) = MFCCinfRem('Nl26.wav',fs);
          lArray(:,:,27) = MFCCinfRem('Nl27.wav',fs);
          lArray(:,:,28) = MFCCinfRem('Nl28.wav',fs);
          lArray(:,:,29) = MFCCinfRem('Nl29.wav',fs);
          lArray(:,:,30) = MFCCinfRem('Nl30.wav',fs);
          
          % 'right'
          rArray(:,:,1) = MFCCinfRem('Nr1.wav',fs);
          rArray(:,:,2) = MFCCinfRem('Nr2.wav',fs);
          rArray(:,:,3) = MFCCinfRem('Nr3.wav',fs);
          rArray(:,:,4) = MFCCinfRem('Nr4.wav',fs);
          rArray(:,:,5) = MFCCinfRem('Nr5.wav',fs);
          rArray(:,:,6) = MFCCinfRem('Nr6.wav',fs);
          rArray(:,:,7) = MFCCinfRem('Nr7.wav',fs);
          rArray(:,:,8) = MFCCinfRem('Nr8.wav',fs);
          rArray(:,:,9) = MFCCinfRem('Nr9.wav',fs);
          rArray(:,:,10) = MFCCinfRem('Nr10.wav',fs);
          rArray(:,:,11) = MFCCinfRem('Nr11.wav',fs);
          rArray(:,:,12) = MFCCinfRem('Nr12.wav',fs);
          rArray(:,:,13) = MFCCinfRem('Nr13.wav',fs);
          rArray(:,:,14) = MFCCinfRem('Nr14.wav',fs);
          rArray(:,:,15) = MFCCinfRem('Nr15.wav',fs);
          rArray(:,:,16) = MFCCinfRem('Nr16.wav',fs);
          rArray(:,:,17) = MFCCinfRem('Nr17.wav',fs);
          rArray(:,:,18) = MFCCinfRem('Nr18.wav',fs);
          rArray(:,:,19) = MFCCinfRem('Nr19.wav',fs);
          rArray(:,:,20) = MFCCinfRem('Nr20.wav',fs);
          rArray(:,:,21) = MFCCinfRem('Nr21.wav',fs);
          rArray(:,:,22) = MFCCinfRem('Nr22.wav',fs);
          rArray(:,:,23) = MFCCinfRem('Nr23.wav',fs);
          rArray(:,:,24) = MFCCinfRem('Nr24.wav',fs);
          rArray(:,:,25) = MFCCinfRem('Nr25.wav',fs);
          rArray(:,:,26) = MFCCinfRem('Nr26.wav',fs);
          rArray(:,:,27) = MFCCinfRem('Nr27.wav',fs);
          rArray(:,:,28) = MFCCinfRem('Nr28.wav',fs);
          rArray(:,:,29) = MFCCinfRem('Nr29.wav',fs);
          rArray(:,:,30) = MFCCinfRem('Nr30.wav',fs);
          
%% add noise to test utterances, then apply noise MFCC thresholds
          disp('Getting utterance testing data MFCCs...');

          if wordSet == 1
          wordMatch = 1;
          disp('Processing set 1...');        
          tArray1(:,:,1) = MFCCnAdd_thresh('t_df1.wav',fs,noise,snr,lowMat,highMat);
          tArray1(:,:,2) = MFCCnAdd_thresh('t_df2.wav',fs,noise,snr,lowMat,highMat);
          tArray1(:,:,3) = MFCCnAdd_thresh('t_df3.wav',fs,noise,snr,lowMat,highMat);
          tArray1(:,:,4) = MFCCnAdd_thresh('t_df4.wav',fs,noise,snr,lowMat,highMat);
          tArray1(:,:,5) = MFCCnAdd_thresh('t_df5.wav',fs,noise,snr,lowMat,highMat);
          tArray1(:,:,6) = MFCCnAdd_thresh('t_df6.wav',fs,noise,snr,lowMat,highMat);
          tArray1(:,:,7) = MFCCnAdd_thresh('t_df7.wav',fs,noise,snr,lowMat,highMat);
          tArray1(:,:,8) = MFCCnAdd_thresh('t_df8.wav',fs,noise,snr,lowMat,highMat);
          tArray1(:,:,9) = MFCCnAdd_thresh('t_df9.wav',fs,noise,snr,lowMat,highMat);
          tArray1(:,:,10) = MFCCnAdd_thresh('t_df11.wav',fs,noise,snr,lowMat,highMat);
          tArray1(:,:,11) = MFCCnAdd_thresh('t_df11.wav',fs,noise,snr,lowMat,highMat);
          tArray1(:,:,12) = MFCCnAdd_thresh('t_df12.wav',fs,noise,snr,lowMat,highMat);
          tArray1(:,:,13) = MFCCnAdd_thresh('t_df13.wav',fs,noise,snr,lowMat,highMat);
          tArray1(:,:,14) = MFCCnAdd_thresh('t_df14.wav',fs,noise,snr,lowMat,highMat);
          tArray1(:,:,15) = MFCCnAdd_thresh('t_df15.wav',fs,noise,snr,lowMat,highMat);
          tArray1(:,:,16) = MFCCnAdd_thresh('t_df16.wav',fs,noise,snr,lowMat,highMat);
          tArray1(:,:,17) = MFCCnAdd_thresh('t_df17.wav',fs,noise,snr,lowMat,highMat);
          tArray1(:,:,18) = MFCCnAdd_thresh('t_df18.wav',fs,noise,snr,lowMat,highMat);
          tArray1(:,:,19) = MFCCnAdd_thresh('t_df19.wav',fs,noise,snr,lowMat,highMat);
          tArray1(:,:,20) = MFCCnAdd_thresh('t_df20.wav',fs,noise,snr,lowMat,highMat);
          tArray1(:,:,21) = MFCCnAdd_thresh('t_df21.wav',fs,noise,snr,lowMat,highMat);
          tArray1(:,:,22) = MFCCnAdd_thresh('t_df22.wav',fs,noise,snr,lowMat,highMat);
          tArray1(:,:,23) = MFCCnAdd_thresh('t_df23.wav',fs,noise,snr,lowMat,highMat);
          tArray1(:,:,24) = MFCCnAdd_thresh('t_df24.wav',fs,noise,snr,lowMat,highMat);
          tArray1(:,:,25) = MFCCnAdd_thresh('t_df25.wav',fs,noise,snr,lowMat,highMat);
          tArray1(:,:,26) = MFCCnAdd_thresh('t_df26.wav',fs,noise,snr,lowMat,highMat);
          tArray1(:,:,27) = MFCCnAdd_thresh('t_df27.wav',fs,noise,snr,lowMat,highMat);
          tArray1(:,:,28) = MFCCnAdd_thresh('t_df28.wav',fs,noise,snr,lowMat,highMat);
          tArray1(:,:,29) = MFCCnAdd_thresh('t_df29.wav',fs,noise,snr,lowMat,highMat);
          tArray1(:,:,30) = MFCCnAdd_thresh('t_df30.wav',fs,noise,snr,lowMat,highMat);
          tArray1(:,:,31) = MFCCnAdd_thresh('t_df31.wav',fs,noise,snr,lowMat,highMat);
          tArray1(:,:,32) = MFCCnAdd_thresh('t_df32.wav',fs,noise,snr,lowMat,highMat);
          tArray1(:,:,33) = MFCCnAdd_thresh('t_df33.wav',fs,noise,snr,lowMat,highMat);
          tArray1(:,:,34) = MFCCnAdd_thresh('t_df34.wav',fs,noise,snr,lowMat,highMat);
          tArray1(:,:,35) = MFCCnAdd_thresh('t_df35.wav',fs,noise,snr,lowMat,highMat);
          tArray1(:,:,36) = MFCCnAdd_thresh('t_df36.wav',fs,noise,snr,lowMat,highMat);
          tArray1(:,:,37) = MFCCnAdd_thresh('t_df37.wav',fs,noise,snr,lowMat,highMat);
          tArray1(:,:,38) = MFCCnAdd_thresh('t_df38.wav',fs,noise,snr,lowMat,highMat);
          tArray1(:,:,39) = MFCCnAdd_thresh('t_df39.wav',fs,noise,snr,lowMat,highMat);
          tArray1(:,:,40) = MFCCnAdd_thresh('t_df40.wav',fs,noise,snr,lowMat,highMat);
          tArray1(:,:,41) = MFCCnAdd_thresh('t_df41.wav',fs,noise,snr,lowMat,highMat);
          tArray1(:,:,42) = MFCCnAdd_thresh('t_df42.wav',fs,noise,snr,lowMat,highMat);
          tArray1(:,:,43) = MFCCnAdd_thresh('t_df43.wav',fs,noise,snr,lowMat,highMat);
          tArray1(:,:,44) = MFCCnAdd_thresh('t_df44.wav',fs,noise,snr,lowMat,highMat);
          tArray1(:,:,45) = MFCCnAdd_thresh('t_df45.wav',fs,noise,snr,lowMat,highMat);
          tArray1(:,:,46) = MFCCnAdd_thresh('t_df46.wav',fs,noise,snr,lowMat,highMat);
          tArray1(:,:,47) = MFCCnAdd_thresh('t_df47.wav',fs,noise,snr,lowMat,highMat);
          tArray1(:,:,48) = MFCCnAdd_thresh('t_df48.wav',fs,noise,snr,lowMat,highMat);
          tArray1(:,:,49) = MFCCnAdd_thresh('t_df49.wav',fs,noise,snr,lowMat,highMat);
          tArray1(:,:,50) = MFCCnAdd_thresh('t_df50.wav',fs,noise,snr,lowMat,highMat);
          end
          
          if wordSet == 2
          wordMatch = 2;
          disp('Processing set 2...');
          tArray2(:,:,1) = MFCCnAdd_thresh('t_sm1.wav',fs,noise,snr,lowMat,highMat);
          tArray2(:,:,2) = MFCCnAdd_thresh('t_sm2.wav',fs,noise,snr,lowMat,highMat);
          tArray2(:,:,3) = MFCCnAdd_thresh('t_sm3.wav',fs,noise,snr,lowMat,highMat);
          tArray2(:,:,4) = MFCCnAdd_thresh('t_sm4.wav',fs,noise,snr,lowMat,highMat);
          tArray2(:,:,5) = MFCCnAdd_thresh('t_sm5.wav',fs,noise,snr,lowMat,highMat);
          tArray2(:,:,6) = MFCCnAdd_thresh('t_sm6.wav',fs,noise,snr,lowMat,highMat);
          tArray2(:,:,7) = MFCCnAdd_thresh('t_sm7.wav',fs,noise,snr,lowMat,highMat);
          tArray2(:,:,8) = MFCCnAdd_thresh('t_sm8.wav',fs,noise,snr,lowMat,highMat);
          tArray2(:,:,9) = MFCCnAdd_thresh('t_sm9.wav',fs,noise,snr,lowMat,highMat);
          tArray2(:,:,10) = MFCCnAdd_thresh('t_sm11.wav',fs,noise,snr,lowMat,highMat);
          tArray2(:,:,11) = MFCCnAdd_thresh('t_sm11.wav',fs,noise,snr,lowMat,highMat);
          tArray2(:,:,12) = MFCCnAdd_thresh('t_sm12.wav',fs,noise,snr,lowMat,highMat);
          tArray2(:,:,13) = MFCCnAdd_thresh('t_sm13.wav',fs,noise,snr,lowMat,highMat);
          tArray2(:,:,14) = MFCCnAdd_thresh('t_sm14.wav',fs,noise,snr,lowMat,highMat);
          tArray2(:,:,15) = MFCCnAdd_thresh('t_sm15.wav',fs,noise,snr,lowMat,highMat);
          tArray2(:,:,16) = MFCCnAdd_thresh('t_sm16.wav',fs,noise,snr,lowMat,highMat);
          tArray2(:,:,17) = MFCCnAdd_thresh('t_sm17.wav',fs,noise,snr,lowMat,highMat);
          tArray2(:,:,18) = MFCCnAdd_thresh('t_sm18.wav',fs,noise,snr,lowMat,highMat);
          tArray2(:,:,19) = MFCCnAdd_thresh('t_sm19.wav',fs,noise,snr,lowMat,highMat);
          tArray2(:,:,20) = MFCCnAdd_thresh('t_sm20.wav',fs,noise,snr,lowMat,highMat);
          tArray2(:,:,21) = MFCCnAdd_thresh('t_sm21.wav',fs,noise,snr,lowMat,highMat);
          tArray2(:,:,22) = MFCCnAdd_thresh('t_sm22.wav',fs,noise,snr,lowMat,highMat);
          tArray2(:,:,23) = MFCCnAdd_thresh('t_sm23.wav',fs,noise,snr,lowMat,highMat);
          tArray2(:,:,24) = MFCCnAdd_thresh('t_sm24.wav',fs,noise,snr,lowMat,highMat);
          tArray2(:,:,25) = MFCCnAdd_thresh('t_sm25.wav',fs,noise,snr,lowMat,highMat);
          tArray2(:,:,26) = MFCCnAdd_thresh('t_sm26.wav',fs,noise,snr,lowMat,highMat);
          tArray2(:,:,27) = MFCCnAdd_thresh('t_sm27.wav',fs,noise,snr,lowMat,highMat);
          tArray2(:,:,28) = MFCCnAdd_thresh('t_sm28.wav',fs,noise,snr,lowMat,highMat);
          tArray2(:,:,29) = MFCCnAdd_thresh('t_sm29.wav',fs,noise,snr,lowMat,highMat);
          tArray2(:,:,30) = MFCCnAdd_thresh('t_sm30.wav',fs,noise,snr,lowMat,highMat);
          tArray2(:,:,31) = MFCCnAdd_thresh('t_sm31.wav',fs,noise,snr,lowMat,highMat);
          tArray2(:,:,32) = MFCCnAdd_thresh('t_sm32.wav',fs,noise,snr,lowMat,highMat);
          tArray2(:,:,33) = MFCCnAdd_thresh('t_sm33.wav',fs,noise,snr,lowMat,highMat);
          tArray2(:,:,34) = MFCCnAdd_thresh('t_sm34.wav',fs,noise,snr,lowMat,highMat);
          tArray2(:,:,35) = MFCCnAdd_thresh('t_sm35.wav',fs,noise,snr,lowMat,highMat);
          tArray2(:,:,36) = MFCCnAdd_thresh('t_sm36.wav',fs,noise,snr,lowMat,highMat);
          tArray2(:,:,37) = MFCCnAdd_thresh('t_sm37.wav',fs,noise,snr,lowMat,highMat);
          tArray2(:,:,38) = MFCCnAdd_thresh('t_sm38.wav',fs,noise,snr,lowMat,highMat);
          tArray2(:,:,39) = MFCCnAdd_thresh('t_sm39.wav',fs,noise,snr,lowMat,highMat);
          tArray2(:,:,40) = MFCCnAdd_thresh('t_sm40.wav',fs,noise,snr,lowMat,highMat);
          tArray2(:,:,41) = MFCCnAdd_thresh('t_sm41.wav',fs,noise,snr,lowMat,highMat);
          tArray2(:,:,42) = MFCCnAdd_thresh('t_sm42.wav',fs,noise,snr,lowMat,highMat);
          tArray2(:,:,43) = MFCCnAdd_thresh('t_sm43.wav',fs,noise,snr,lowMat,highMat);
          tArray2(:,:,44) = MFCCnAdd_thresh('t_sm44.wav',fs,noise,snr,lowMat,highMat);
          tArray2(:,:,45) = MFCCnAdd_thresh('t_sm45.wav',fs,noise,snr,lowMat,highMat);
          tArray2(:,:,46) = MFCCnAdd_thresh('t_sm46.wav',fs,noise,snr,lowMat,highMat);
          tArray2(:,:,47) = MFCCnAdd_thresh('t_sm47.wav',fs,noise,snr,lowMat,highMat);
          tArray2(:,:,48) = MFCCnAdd_thresh('t_sm48.wav',fs,noise,snr,lowMat,highMat);
          tArray2(:,:,49) = MFCCnAdd_thresh('t_sm49.wav',fs,noise,snr,lowMat,highMat);
          tArray2(:,:,50) = MFCCnAdd_thresh('t_sm50.wav',fs,noise,snr,lowMat,highMat);
          end
          
          if wordSet == 3
          wordMatch = 3;
          disp('Processing set 3...');
          tArray3(:,:,1) = MFCCnAdd_thresh('t_l1.wav',fs,noise,snr,lowMat,highMat);
          tArray3(:,:,2) = MFCCnAdd_thresh('t_l2.wav',fs,noise,snr,lowMat,highMat);
          tArray3(:,:,3) = MFCCnAdd_thresh('t_l3.wav',fs,noise,snr,lowMat,highMat);
          tArray3(:,:,4) = MFCCnAdd_thresh('t_l4.wav',fs,noise,snr,lowMat,highMat);
          tArray3(:,:,5) = MFCCnAdd_thresh('t_l5.wav',fs,noise,snr,lowMat,highMat);
          tArray3(:,:,6) = MFCCnAdd_thresh('t_l6.wav',fs,noise,snr,lowMat,highMat);
          tArray3(:,:,7) = MFCCnAdd_thresh('t_l7.wav',fs,noise,snr,lowMat,highMat);
          tArray3(:,:,8) = MFCCnAdd_thresh('t_l8.wav',fs,noise,snr,lowMat,highMat);
          tArray3(:,:,9) = MFCCnAdd_thresh('t_l9.wav',fs,noise,snr,lowMat,highMat);
          tArray3(:,:,10) = MFCCnAdd_thresh('t_l11.wav',fs,noise,snr,lowMat,highMat);
          tArray3(:,:,11) = MFCCnAdd_thresh('t_l11.wav',fs,noise,snr,lowMat,highMat);
          tArray3(:,:,12) = MFCCnAdd_thresh('t_l12.wav',fs,noise,snr,lowMat,highMat);
          tArray3(:,:,13) = MFCCnAdd_thresh('t_l13.wav',fs,noise,snr,lowMat,highMat);
          tArray3(:,:,14) = MFCCnAdd_thresh('t_l14.wav',fs,noise,snr,lowMat,highMat);
          tArray3(:,:,15) = MFCCnAdd_thresh('t_l15.wav',fs,noise,snr,lowMat,highMat);
          tArray3(:,:,16) = MFCCnAdd_thresh('t_l16.wav',fs,noise,snr,lowMat,highMat);
          tArray3(:,:,17) = MFCCnAdd_thresh('t_l17.wav',fs,noise,snr,lowMat,highMat);
          tArray3(:,:,18) = MFCCnAdd_thresh('t_l18.wav',fs,noise,snr,lowMat,highMat);
          tArray3(:,:,19) = MFCCnAdd_thresh('t_l19.wav',fs,noise,snr,lowMat,highMat);
          tArray3(:,:,20) = MFCCnAdd_thresh('t_l20.wav',fs,noise,snr,lowMat,highMat);
          tArray3(:,:,21) = MFCCnAdd_thresh('t_l21.wav',fs,noise,snr,lowMat,highMat);
          tArray3(:,:,22) = MFCCnAdd_thresh('t_l22.wav',fs,noise,snr,lowMat,highMat);
          tArray3(:,:,23) = MFCCnAdd_thresh('t_l23.wav',fs,noise,snr,lowMat,highMat);
          tArray3(:,:,24) = MFCCnAdd_thresh('t_l24.wav',fs,noise,snr,lowMat,highMat);
          tArray3(:,:,25) = MFCCnAdd_thresh('t_l25.wav',fs,noise,snr,lowMat,highMat);
          tArray3(:,:,26) = MFCCnAdd_thresh('t_l26.wav',fs,noise,snr,lowMat,highMat);
          tArray3(:,:,27) = MFCCnAdd_thresh('t_l27.wav',fs,noise,snr,lowMat,highMat);
          tArray3(:,:,28) = MFCCnAdd_thresh('t_l28.wav',fs,noise,snr,lowMat,highMat);
          tArray3(:,:,29) = MFCCnAdd_thresh('t_l29.wav',fs,noise,snr,lowMat,highMat);
          tArray3(:,:,30) = MFCCnAdd_thresh('t_l30.wav',fs,noise,snr,lowMat,highMat);
          tArray3(:,:,31) = MFCCnAdd_thresh('t_l31.wav',fs,noise,snr,lowMat,highMat);
          tArray3(:,:,32) = MFCCnAdd_thresh('t_l32.wav',fs,noise,snr,lowMat,highMat);
          tArray3(:,:,33) = MFCCnAdd_thresh('t_l33.wav',fs,noise,snr,lowMat,highMat);
          tArray3(:,:,34) = MFCCnAdd_thresh('t_l34.wav',fs,noise,snr,lowMat,highMat);
          tArray3(:,:,35) = MFCCnAdd_thresh('t_l35.wav',fs,noise,snr,lowMat,highMat);
          tArray3(:,:,36) = MFCCnAdd_thresh('t_l36.wav',fs,noise,snr,lowMat,highMat);
          tArray3(:,:,37) = MFCCnAdd_thresh('t_l37.wav',fs,noise,snr,lowMat,highMat);
          tArray3(:,:,38) = MFCCnAdd_thresh('t_l38.wav',fs,noise,snr,lowMat,highMat);
          tArray3(:,:,39) = MFCCnAdd_thresh('t_l39.wav',fs,noise,snr,lowMat,highMat);
          tArray3(:,:,40) = MFCCnAdd_thresh('t_l40.wav',fs,noise,snr,lowMat,highMat);
          tArray3(:,:,41) = MFCCnAdd_thresh('t_l41.wav',fs,noise,snr,lowMat,highMat);
          tArray3(:,:,42) = MFCCnAdd_thresh('t_l42.wav',fs,noise,snr,lowMat,highMat);
          tArray3(:,:,43) = MFCCnAdd_thresh('t_l43.wav',fs,noise,snr,lowMat,highMat);
          tArray3(:,:,44) = MFCCnAdd_thresh('t_l44.wav',fs,noise,snr,lowMat,highMat);
          tArray3(:,:,45) = MFCCnAdd_thresh('t_l45.wav',fs,noise,snr,lowMat,highMat);
          tArray3(:,:,46) = MFCCnAdd_thresh('t_l46.wav',fs,noise,snr,lowMat,highMat);
          tArray3(:,:,47) = MFCCnAdd_thresh('t_l47.wav',fs,noise,snr,lowMat,highMat);
          tArray3(:,:,48) = MFCCnAdd_thresh('t_l48.wav',fs,noise,snr,lowMat,highMat);
          tArray3(:,:,49) = MFCCnAdd_thresh('t_l49.wav',fs,noise,snr,lowMat,highMat);
          tArray3(:,:,50) = MFCCnAdd_thresh('t_l50.wav',fs,noise,snr,lowMat,highMat);
          end
            
          if wordSet == 4
          wordMatch = 4;
          disp('Processing set 4...');
          tArray4(:,:,1) = MFCCnAdd_thresh('t_r1.wav',fs,noise,snr,lowMat,highMat);
          tArray4(:,:,2) = MFCCnAdd_thresh('t_r2.wav',fs,noise,snr,lowMat,highMat);
          tArray4(:,:,3) = MFCCnAdd_thresh('t_r3.wav',fs,noise,snr,lowMat,highMat);
          tArray4(:,:,4) = MFCCnAdd_thresh('t_r4.wav',fs,noise,snr,lowMat,highMat);
          tArray4(:,:,5) = MFCCnAdd_thresh('t_r5.wav',fs,noise,snr,lowMat,highMat);
          tArray4(:,:,6) = MFCCnAdd_thresh('t_r6.wav',fs,noise,snr,lowMat,highMat);
          tArray4(:,:,7) = MFCCnAdd_thresh('t_r7.wav',fs,noise,snr,lowMat,highMat);
          tArray4(:,:,8) = MFCCnAdd_thresh('t_r8.wav',fs,noise,snr,lowMat,highMat);
          tArray4(:,:,9) = MFCCnAdd_thresh('t_r9.wav',fs,noise,snr,lowMat,highMat);
          tArray4(:,:,10) = MFCCnAdd_thresh('t_r11.wav',fs,noise,snr,lowMat,highMat);
          tArray4(:,:,11) = MFCCnAdd_thresh('t_r11.wav',fs,noise,snr,lowMat,highMat);
          tArray4(:,:,12) = MFCCnAdd_thresh('t_r12.wav',fs,noise,snr,lowMat,highMat);
          tArray4(:,:,13) = MFCCnAdd_thresh('t_r13.wav',fs,noise,snr,lowMat,highMat);
          tArray4(:,:,14) = MFCCnAdd_thresh('t_r14.wav',fs,noise,snr,lowMat,highMat);
          tArray4(:,:,15) = MFCCnAdd_thresh('t_r15.wav',fs,noise,snr,lowMat,highMat);
          tArray4(:,:,16) = MFCCnAdd_thresh('t_r16.wav',fs,noise,snr,lowMat,highMat);
          tArray4(:,:,17) = MFCCnAdd_thresh('t_r17.wav',fs,noise,snr,lowMat,highMat);
          tArray4(:,:,18) = MFCCnAdd_thresh('t_r18.wav',fs,noise,snr,lowMat,highMat);
          tArray4(:,:,19) = MFCCnAdd_thresh('t_r19.wav',fs,noise,snr,lowMat,highMat);
          tArray4(:,:,20) = MFCCnAdd_thresh('t_r20.wav',fs,noise,snr,lowMat,highMat);
          tArray4(:,:,21) = MFCCnAdd_thresh('t_r21.wav',fs,noise,snr,lowMat,highMat);
          tArray4(:,:,22) = MFCCnAdd_thresh('t_r22.wav',fs,noise,snr,lowMat,highMat);
          tArray4(:,:,23) = MFCCnAdd_thresh('t_r23.wav',fs,noise,snr,lowMat,highMat);
          tArray4(:,:,24) = MFCCnAdd_thresh('t_r24.wav',fs,noise,snr,lowMat,highMat);
          tArray4(:,:,25) = MFCCnAdd_thresh('t_r25.wav',fs,noise,snr,lowMat,highMat);
          tArray4(:,:,26) = MFCCnAdd_thresh('t_r26.wav',fs,noise,snr,lowMat,highMat);
          tArray4(:,:,27) = MFCCnAdd_thresh('t_r27.wav',fs,noise,snr,lowMat,highMat);
          tArray4(:,:,28) = MFCCnAdd_thresh('t_r28.wav',fs,noise,snr,lowMat,highMat);
          tArray4(:,:,29) = MFCCnAdd_thresh('t_r29.wav',fs,noise,snr,lowMat,highMat);
          tArray4(:,:,30) = MFCCnAdd_thresh('t_r30.wav',fs,noise,snr,lowMat,highMat);
          tArray4(:,:,31) = MFCCnAdd_thresh('t_r31.wav',fs,noise,snr,lowMat,highMat);
          tArray4(:,:,32) = MFCCnAdd_thresh('t_r32.wav',fs,noise,snr,lowMat,highMat);
          tArray4(:,:,33) = MFCCnAdd_thresh('t_r33.wav',fs,noise,snr,lowMat,highMat);
          tArray4(:,:,34) = MFCCnAdd_thresh('t_r34.wav',fs,noise,snr,lowMat,highMat);
          tArray4(:,:,35) = MFCCnAdd_thresh('t_r35.wav',fs,noise,snr,lowMat,highMat);
          tArray4(:,:,36) = MFCCnAdd_thresh('t_r36.wav',fs,noise,snr,lowMat,highMat);
          tArray4(:,:,37) = MFCCnAdd_thresh('t_r37.wav',fs,noise,snr,lowMat,highMat);
          tArray4(:,:,38) = MFCCnAdd_thresh('t_r38.wav',fs,noise,snr,lowMat,highMat);
          tArray4(:,:,39) = MFCCnAdd_thresh('t_r39.wav',fs,noise,snr,lowMat,highMat);
          tArray4(:,:,40) = MFCCnAdd_thresh('t_r40.wav',fs,noise,snr,lowMat,highMat);
          tArray4(:,:,41) = MFCCnAdd_thresh('t_r41.wav',fs,noise,snr,lowMat,highMat);
          tArray4(:,:,42) = MFCCnAdd_thresh('t_r42.wav',fs,noise,snr,lowMat,highMat);
          tArray4(:,:,43) = MFCCnAdd_thresh('t_r43.wav',fs,noise,snr,lowMat,highMat);
          tArray4(:,:,44) = MFCCnAdd_thresh('t_r44.wav',fs,noise,snr,lowMat,highMat);
          tArray4(:,:,45) = MFCCnAdd_thresh('t_r45.wav',fs,noise,snr,lowMat,highMat);
          tArray4(:,:,46) = MFCCnAdd_thresh('t_r46.wav',fs,noise,snr,lowMat,highMat);
          tArray4(:,:,47) = MFCCnAdd_thresh('t_r47.wav',fs,noise,snr,lowMat,highMat);
          tArray4(:,:,48) = MFCCnAdd_thresh('t_r48.wav',fs,noise,snr,lowMat,highMat);
          tArray4(:,:,49) = MFCCnAdd_thresh('t_r49.wav',fs,noise,snr,lowMat,highMat);
          tArray4(:,:,50) = MFCCnAdd_thresh('t_r50.wav',fs,noise,snr,lowMat,highMat);
          end
          
%% main loop

counter = 0;
wordCount = 0;
recCount = 0;
wordsN = [];
correct = [];
difference = [];
av = [];
time = [];

disp('Start');
                   
     for counter = 1 : 50
         fprintf('processing word : %d \n', counter);
         
         if wordSet == 1
            mfcc_matrix = tArray1(:,:,counter); 
         end
         
         if wordSet == 2
            mfcc_matrix = tArray2(:,:,counter);
         end
         
         if wordSet == 3
            mfcc_matrix = tArray3(:,:,counter);
         end
         
         if wordSet == 4
             mfcc_matrix = tArray4(:,:,counter);
         end
                                            
%% calculate DTW averages of utterance compared to stored words
                            
                    dtwGoMean = 0;
                    dtwSMMean = 0;
                    dtwLMean = 0;
                    dtwRMean = 0;
                
                    for idx = 1 : 30
                        dtwGoMean = dtwGoMean + dtw_c(mfcc_matrix,goArray(:,:,idx),w);
                    end
                
                    for idx = 1 : 30
                        dtwSMMean = dtwSMMean + dtw_c(mfcc_matrix,smArray(:,:,idx),w);
                    end
                    
                    for idx = 1 : 30
                        dtwLMean = dtwLMean + dtw_c(mfcc_matrix,lArray(:,:,idx),w);
                    end
                    
                    for idx = 1 : 30
                        dtwRMean = dtwRMean + dtw_c(mfcc_matrix,rArray(:,:,idx),w);
                    end
                    % calculate averge scores
                    goAv = dtwGoMean / 30;
                    smAv = dtwSMMean / 30;
                    lAv = dtwLMean / 30;
                    rAv = dtwRMean / 30;
                    
                
%% display data                

                  finalAv = [goAv ; smAv ; lAv ; rAv];      % all set matching value averages            
                  sorted = sort(finalAv);                   % sort the list                  
                  M = min(finalAv);                         % find best matching score
                  min2nd = sorted(2, :);                    % find second best matching score
                  dif = min2nd - M;                         % get matching score difference
                     
                  if M == goAv                              
                     fprintf('drive forwards : %f \n', M);
                     wordN = 1;
                     word = ' 1: move forwards ';
                  end
                              
                  if M == smAv                                  
                     fprintf('stop moving : %f \n', M);
                     wordN = 2;
                     word = ' 2: stop moving ';
                  end
                  
                  if M == lAv                                  
                     fprintf('left : %f \n', M); 
                     wordN = 3;
                     word = ' 3: left ';
                  end
                  
                  if M == rAv                                  
                     fprintf('right : %f \n', M);
                     wordN = 4;
                     word = ' 4: right ';
                  end

                    fprintf('match difference : %f \n', dif);
                    
                    if wordN == wordMatch                             
                        answer = 1;
                    else answer = 0;
                    end
                    
                    wordsN = [wordsN ; wordN];
                    correct = [correct ; answer];
                    difference = [difference ; dif];
                    av = [av ; M]; 

                    Results = table(wordsN,correct,av,difference,...
                    'VariableNames',{'Word' 'Correct' 'score' 'diff'});
                               
      end               
   
