%% This file is for testing the system's accuracy with ambient noise MFCC  
%  subtraction applied testing command MFCCs. Testing commands have
%  been recorded in a clean environmrnt with noise added during processing.          

%         - Get MFCCs from segment of ambient noise 
%           and put average values from each filterbank into new matrix
%·        - Extract MFCCs from training command words
%         - Replace any inf values in all MFCC matrices with zeros
%         - Get testing utterances, for each utterance:
%           Add noise
%           Extract MFCCs 
%           Replace any inf values MFCC matrix with zeros
%           Subtract ambient noise average MFCCs from test utterance MFCCs
%         - Compare utterance MFCCs with training MFCCs using DTW
%         - Get average DTW matching score of each command class
%         - The command class with the best (lowest) DTW average score is matched to the recorded utterance
%         - Record DTW score
%         - Record matching score difference between matched command and
%           second closest matched command
%         - Record if utterance was correctly matched
%         - Results collected in 'Results' table
 
%% set up variables 

clear;clc;close all;

disp('Start...');

mex dtw_c.c;                    % DTW
w=50;                           % DTW

fs = 44100;                     % sampling frequency
Ws=1024;                        % window size
Ol=512;                         % 50% overlap
N=12;                           % number of frequency bins?

SamplesPerFrame = 512;          %

%% testing variables

snr=-20;                                % SNR 
wordSet =4;                             % command to test
[noise1,fs1]=audioread('t_volvo.wav');  % get noise signal
       
%% get MFCCs from 1 second of noisy file

         disp('Getting noise file MFCCs...');


         noise=resample(noise1,fs,fs1);                 % give noise file the same sample rate as everything else   
         noiseLen = length(noise);                      % get length of noise signal    
         r = randi([1 noiseLen-88200],1,1);             % generate random int between 1 and length of sig - 2 seconds  
         noise_seg = noise(r : r + 88199);              % extract 2 second random segment from noise
    
         quiet_matrix = getMFCC(noise_seg,fs);          % get MFCC feature matrix      
%          quiet_matrix = getMFCC(noise,fs);            % get MFCC feature matrix   
         quiet_matrix(~isfinite(quiet_matrix))=0;       % replace inf with 0s      
         M = mean(quiet_matrix,2);                      % get average value for each row        
         %quiet_matrix_av = repmat(M, 1, 85);           % construct new matrix from average frequencies 
         quiet_matrix_av = repmat(M, 1, 170);           % construct new matrix from average frequencies

         disp('Playing noise file segment...');
         sound(noise_seg,44100);                        % play recording
         
%% for all training data samples:

% 1) exctract MFCCs
% 2) convert any inf values to 0s

          disp('Getting training data MFCCs...');
            
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
          
          
          %% test audio files
          
          disp('Getting utterance testing data MFCCs...');

          if wordSet == 1
          wordMatch = 1;
          tArray1(:,:,1) = MFCCnAddnRem('t_df1.wav',fs,quiet_matrix_av,noise,snr);
          tArray1(:,:,2) = MFCCnAddnRem('t_df2.wav',fs,quiet_matrix_av,noise,snr);
          tArray1(:,:,3) = MFCCnAddnRem('t_df3.wav',fs,quiet_matrix_av,noise,snr);
          tArray1(:,:,4) = MFCCnAddnRem('t_df4.wav',fs,quiet_matrix_av,noise,snr);
          tArray1(:,:,5) = MFCCnAddnRem('t_df5.wav',fs,quiet_matrix_av,noise,snr);
          tArray1(:,:,6) = MFCCnAddnRem('t_df6.wav',fs,quiet_matrix_av,noise,snr);
          tArray1(:,:,7) = MFCCnAddnRem('t_df7.wav',fs,quiet_matrix_av,noise,snr);
          tArray1(:,:,8) = MFCCnAddnRem('t_df8.wav',fs,quiet_matrix_av,noise,snr);
          tArray1(:,:,9) = MFCCnAddnRem('t_df9.wav',fs,quiet_matrix_av,noise,snr);
          tArray1(:,:,10) = MFCCnAddnRem('t_df11.wav',fs,quiet_matrix_av,noise,snr);
          tArray1(:,:,11) = MFCCnAddnRem('t_df11.wav',fs,quiet_matrix_av,noise,snr);
          tArray1(:,:,12) = MFCCnAddnRem('t_df12.wav',fs,quiet_matrix_av,noise,snr);
          tArray1(:,:,13) = MFCCnAddnRem('t_df13.wav',fs,quiet_matrix_av,noise,snr);
          tArray1(:,:,14) = MFCCnAddnRem('t_df14.wav',fs,quiet_matrix_av,noise,snr);
          tArray1(:,:,15) = MFCCnAddnRem('t_df15.wav',fs,quiet_matrix_av,noise,snr);
          tArray1(:,:,16) = MFCCnAddnRem('t_df16.wav',fs,quiet_matrix_av,noise,snr);
          tArray1(:,:,17) = MFCCnAddnRem('t_df17.wav',fs,quiet_matrix_av,noise,snr);
          tArray1(:,:,18) = MFCCnAddnRem('t_df18.wav',fs,quiet_matrix_av,noise,snr);
          tArray1(:,:,19) = MFCCnAddnRem('t_df19.wav',fs,quiet_matrix_av,noise,snr);
          tArray1(:,:,20) = MFCCnAddnRem('t_df20.wav',fs,quiet_matrix_av,noise,snr);
          tArray1(:,:,21) = MFCCnAddnRem('t_df21.wav',fs,quiet_matrix_av,noise,snr);
          tArray1(:,:,22) = MFCCnAddnRem('t_df22.wav',fs,quiet_matrix_av,noise,snr);
          tArray1(:,:,23) = MFCCnAddnRem('t_df23.wav',fs,quiet_matrix_av,noise,snr);
          tArray1(:,:,24) = MFCCnAddnRem('t_df24.wav',fs,quiet_matrix_av,noise,snr);
          tArray1(:,:,25) = MFCCnAddnRem('t_df25.wav',fs,quiet_matrix_av,noise,snr);
          tArray1(:,:,26) = MFCCnAddnRem('t_df26.wav',fs,quiet_matrix_av,noise,snr);
          tArray1(:,:,27) = MFCCnAddnRem('t_df27.wav',fs,quiet_matrix_av,noise,snr);
          tArray1(:,:,28) = MFCCnAddnRem('t_df28.wav',fs,quiet_matrix_av,noise,snr);
          tArray1(:,:,29) = MFCCnAddnRem('t_df29.wav',fs,quiet_matrix_av,noise,snr);
          tArray1(:,:,30) = MFCCnAddnRem('t_df30.wav',fs,quiet_matrix_av,noise,snr);
          tArray1(:,:,31) = MFCCnAddnRem('t_df31.wav',fs,quiet_matrix_av,noise,snr);
          tArray1(:,:,32) = MFCCnAddnRem('t_df32.wav',fs,quiet_matrix_av,noise,snr);
          tArray1(:,:,33) = MFCCnAddnRem('t_df33.wav',fs,quiet_matrix_av,noise,snr);
          tArray1(:,:,34) = MFCCnAddnRem('t_df34.wav',fs,quiet_matrix_av,noise,snr);
          tArray1(:,:,35) = MFCCnAddnRem('t_df35.wav',fs,quiet_matrix_av,noise,snr);
          tArray1(:,:,36) = MFCCnAddnRem('t_df36.wav',fs,quiet_matrix_av,noise,snr);
          tArray1(:,:,37) = MFCCnAddnRem('t_df37.wav',fs,quiet_matrix_av,noise,snr);
          tArray1(:,:,38) = MFCCnAddnRem('t_df38.wav',fs,quiet_matrix_av,noise,snr);
          tArray1(:,:,39) = MFCCnAddnRem('t_df39.wav',fs,quiet_matrix_av,noise,snr);
          tArray1(:,:,40) = MFCCnAddnRem('t_df40.wav',fs,quiet_matrix_av,noise,snr);
          tArray1(:,:,41) = MFCCnAddnRem('t_df41.wav',fs,quiet_matrix_av,noise,snr);
          tArray1(:,:,42) = MFCCnAddnRem('t_df42.wav',fs,quiet_matrix_av,noise,snr);
          tArray1(:,:,43) = MFCCnAddnRem('t_df43.wav',fs,quiet_matrix_av,noise,snr);
          tArray1(:,:,44) = MFCCnAddnRem('t_df44.wav',fs,quiet_matrix_av,noise,snr);
          tArray1(:,:,45) = MFCCnAddnRem('t_df45.wav',fs,quiet_matrix_av,noise,snr);
          tArray1(:,:,46) = MFCCnAddnRem('t_df46.wav',fs,quiet_matrix_av,noise,snr);
          tArray1(:,:,47) = MFCCnAddnRem('t_df47.wav',fs,quiet_matrix_av,noise,snr);
          tArray1(:,:,48) = MFCCnAddnRem('t_df48.wav',fs,quiet_matrix_av,noise,snr);
          tArray1(:,:,49) = MFCCnAddnRem('t_df49.wav',fs,quiet_matrix_av,noise,snr);
          tArray1(:,:,50) = MFCCnAddnRem('t_df50.wav',fs,quiet_matrix_av,noise,snr);
          end
          
          if wordSet == 2
          wordMatch = 2;
          tArray2(:,:,1) = MFCCnAddnRem('t_sm1.wav',fs,quiet_matrix_av,noise,snr);
          tArray2(:,:,2) = MFCCnAddnRem('t_sm2.wav',fs,quiet_matrix_av,noise,snr);
          tArray2(:,:,3) = MFCCnAddnRem('t_sm3.wav',fs,quiet_matrix_av,noise,snr);
          tArray2(:,:,4) = MFCCnAddnRem('t_sm4.wav',fs,quiet_matrix_av,noise,snr);
          tArray2(:,:,5) = MFCCnAddnRem('t_sm5.wav',fs,quiet_matrix_av,noise,snr);
          tArray2(:,:,6) = MFCCnAddnRem('t_sm6.wav',fs,quiet_matrix_av,noise,snr);
          tArray2(:,:,7) = MFCCnAddnRem('t_sm7.wav',fs,quiet_matrix_av,noise,snr);
          tArray2(:,:,8) = MFCCnAddnRem('t_sm8.wav',fs,quiet_matrix_av,noise,snr);
          tArray2(:,:,9) = MFCCnAddnRem('t_sm9.wav',fs,quiet_matrix_av,noise,snr);
          tArray2(:,:,10) = MFCCnAddnRem('t_sm11.wav',fs,quiet_matrix_av,noise,snr);
          tArray2(:,:,11) = MFCCnAddnRem('t_sm11.wav',fs,quiet_matrix_av,noise,snr);
          tArray2(:,:,12) = MFCCnAddnRem('t_sm12.wav',fs,quiet_matrix_av,noise,snr);
          tArray2(:,:,13) = MFCCnAddnRem('t_sm13.wav',fs,quiet_matrix_av,noise,snr);
          tArray2(:,:,14) = MFCCnAddnRem('t_sm14.wav',fs,quiet_matrix_av,noise,snr);
          tArray2(:,:,15) = MFCCnAddnRem('t_sm15.wav',fs,quiet_matrix_av,noise,snr);
          tArray2(:,:,16) = MFCCnAddnRem('t_sm16.wav',fs,quiet_matrix_av,noise,snr);
          tArray2(:,:,17) = MFCCnAddnRem('t_sm17.wav',fs,quiet_matrix_av,noise,snr);
          tArray2(:,:,18) = MFCCnAddnRem('t_sm18.wav',fs,quiet_matrix_av,noise,snr);
          tArray2(:,:,19) = MFCCnAddnRem('t_sm19.wav',fs,quiet_matrix_av,noise,snr);
          tArray2(:,:,20) = MFCCnAddnRem('t_sm20.wav',fs,quiet_matrix_av,noise,snr);
          tArray2(:,:,21) = MFCCnAddnRem('t_sm21.wav',fs,quiet_matrix_av,noise,snr);
          tArray2(:,:,22) = MFCCnAddnRem('t_sm22.wav',fs,quiet_matrix_av,noise,snr);
          tArray2(:,:,23) = MFCCnAddnRem('t_sm23.wav',fs,quiet_matrix_av,noise,snr);
          tArray2(:,:,24) = MFCCnAddnRem('t_sm24.wav',fs,quiet_matrix_av,noise,snr);
          tArray2(:,:,25) = MFCCnAddnRem('t_sm25.wav',fs,quiet_matrix_av,noise,snr);
          tArray2(:,:,26) = MFCCnAddnRem('t_sm26.wav',fs,quiet_matrix_av,noise,snr);
          tArray2(:,:,27) = MFCCnAddnRem('t_sm27.wav',fs,quiet_matrix_av,noise,snr);
          tArray2(:,:,28) = MFCCnAddnRem('t_sm28.wav',fs,quiet_matrix_av,noise,snr);
          tArray2(:,:,29) = MFCCnAddnRem('t_sm29.wav',fs,quiet_matrix_av,noise,snr);
          tArray2(:,:,30) = MFCCnAddnRem('t_sm30.wav',fs,quiet_matrix_av,noise,snr);
          tArray2(:,:,31) = MFCCnAddnRem('t_sm31.wav',fs,quiet_matrix_av,noise,snr);
          tArray2(:,:,32) = MFCCnAddnRem('t_sm32.wav',fs,quiet_matrix_av,noise,snr);
          tArray2(:,:,33) = MFCCnAddnRem('t_sm33.wav',fs,quiet_matrix_av,noise,snr);
          tArray2(:,:,34) = MFCCnAddnRem('t_sm34.wav',fs,quiet_matrix_av,noise,snr);
          tArray2(:,:,35) = MFCCnAddnRem('t_sm35.wav',fs,quiet_matrix_av,noise,snr);
          tArray2(:,:,36) = MFCCnAddnRem('t_sm36.wav',fs,quiet_matrix_av,noise,snr);
          tArray2(:,:,37) = MFCCnAddnRem('t_sm37.wav',fs,quiet_matrix_av,noise,snr);
          tArray2(:,:,38) = MFCCnAddnRem('t_sm38.wav',fs,quiet_matrix_av,noise,snr);
          tArray2(:,:,39) = MFCCnAddnRem('t_sm39.wav',fs,quiet_matrix_av,noise,snr);
          tArray2(:,:,40) = MFCCnAddnRem('t_sm40.wav',fs,quiet_matrix_av,noise,snr);
          tArray2(:,:,41) = MFCCnAddnRem('t_sm41.wav',fs,quiet_matrix_av,noise,snr);
          tArray2(:,:,42) = MFCCnAddnRem('t_sm42.wav',fs,quiet_matrix_av,noise,snr);
          tArray2(:,:,43) = MFCCnAddnRem('t_sm43.wav',fs,quiet_matrix_av,noise,snr);
          tArray2(:,:,44) = MFCCnAddnRem('t_sm44.wav',fs,quiet_matrix_av,noise,snr);
          tArray2(:,:,45) = MFCCnAddnRem('t_sm45.wav',fs,quiet_matrix_av,noise,snr);
          tArray2(:,:,46) = MFCCnAddnRem('t_sm46.wav',fs,quiet_matrix_av,noise,snr);
          tArray2(:,:,47) = MFCCnAddnRem('t_sm47.wav',fs,quiet_matrix_av,noise,snr);
          tArray2(:,:,48) = MFCCnAddnRem('t_sm48.wav',fs,quiet_matrix_av,noise,snr);
          tArray2(:,:,49) = MFCCnAddnRem('t_sm49.wav',fs,quiet_matrix_av,noise,snr);
          tArray2(:,:,50) = MFCCnAddnRem('t_sm50.wav',fs,quiet_matrix_av,noise,snr);
          end
          
          if wordSet == 3
          wordMatch = 3;
          tArray3(:,:,1) = MFCCnAddnRem('t_l1.wav',fs,quiet_matrix_av,noise,snr);
          tArray3(:,:,2) = MFCCnAddnRem('t_l2.wav',fs,quiet_matrix_av,noise,snr);
          tArray3(:,:,3) = MFCCnAddnRem('t_l3.wav',fs,quiet_matrix_av,noise,snr);
          tArray3(:,:,4) = MFCCnAddnRem('t_l4.wav',fs,quiet_matrix_av,noise,snr);
          tArray3(:,:,5) = MFCCnAddnRem('t_l5.wav',fs,quiet_matrix_av,noise,snr);
          tArray3(:,:,6) = MFCCnAddnRem('t_l6.wav',fs,quiet_matrix_av,noise,snr);
          tArray3(:,:,7) = MFCCnAddnRem('t_l7.wav',fs,quiet_matrix_av,noise,snr);
          tArray3(:,:,8) = MFCCnAddnRem('t_l8.wav',fs,quiet_matrix_av,noise,snr);
          tArray3(:,:,9) = MFCCnAddnRem('t_l9.wav',fs,quiet_matrix_av,noise,snr);
          tArray3(:,:,10) = MFCCnAddnRem('t_l11.wav',fs,quiet_matrix_av,noise,snr);
          tArray3(:,:,11) = MFCCnAddnRem('t_l11.wav',fs,quiet_matrix_av,noise,snr);
          tArray3(:,:,12) = MFCCnAddnRem('t_l12.wav',fs,quiet_matrix_av,noise,snr);
          tArray3(:,:,13) = MFCCnAddnRem('t_l13.wav',fs,quiet_matrix_av,noise,snr);
          tArray3(:,:,14) = MFCCnAddnRem('t_l14.wav',fs,quiet_matrix_av,noise,snr);
          tArray3(:,:,15) = MFCCnAddnRem('t_l15.wav',fs,quiet_matrix_av,noise,snr);
          tArray3(:,:,16) = MFCCnAddnRem('t_l16.wav',fs,quiet_matrix_av,noise,snr);
          tArray3(:,:,17) = MFCCnAddnRem('t_l17.wav',fs,quiet_matrix_av,noise,snr);
          tArray3(:,:,18) = MFCCnAddnRem('t_l18.wav',fs,quiet_matrix_av,noise,snr);
          tArray3(:,:,19) = MFCCnAddnRem('t_l19.wav',fs,quiet_matrix_av,noise,snr);
          tArray3(:,:,20) = MFCCnAddnRem('t_l20.wav',fs,quiet_matrix_av,noise,snr);
          tArray3(:,:,21) = MFCCnAddnRem('t_l21.wav',fs,quiet_matrix_av,noise,snr);
          tArray3(:,:,22) = MFCCnAddnRem('t_l22.wav',fs,quiet_matrix_av,noise,snr);
          tArray3(:,:,23) = MFCCnAddnRem('t_l23.wav',fs,quiet_matrix_av,noise,snr);
          tArray3(:,:,24) = MFCCnAddnRem('t_l24.wav',fs,quiet_matrix_av,noise,snr);
          tArray3(:,:,25) = MFCCnAddnRem('t_l25.wav',fs,quiet_matrix_av,noise,snr);
          tArray3(:,:,26) = MFCCnAddnRem('t_l26.wav',fs,quiet_matrix_av,noise,snr);
          tArray3(:,:,27) = MFCCnAddnRem('t_l27.wav',fs,quiet_matrix_av,noise,snr);
          tArray3(:,:,28) = MFCCnAddnRem('t_l28.wav',fs,quiet_matrix_av,noise,snr);
          tArray3(:,:,29) = MFCCnAddnRem('t_l29.wav',fs,quiet_matrix_av,noise,snr);
          tArray3(:,:,30) = MFCCnAddnRem('t_l30.wav',fs,quiet_matrix_av,noise,snr);
          tArray3(:,:,31) = MFCCnAddnRem('t_l31.wav',fs,quiet_matrix_av,noise,snr);
          tArray3(:,:,32) = MFCCnAddnRem('t_l32.wav',fs,quiet_matrix_av,noise,snr);
          tArray3(:,:,33) = MFCCnAddnRem('t_l33.wav',fs,quiet_matrix_av,noise,snr);
          tArray3(:,:,34) = MFCCnAddnRem('t_l34.wav',fs,quiet_matrix_av,noise,snr);
          tArray3(:,:,35) = MFCCnAddnRem('t_l35.wav',fs,quiet_matrix_av,noise,snr);
          tArray3(:,:,36) = MFCCnAddnRem('t_l36.wav',fs,quiet_matrix_av,noise,snr);
          tArray3(:,:,37) = MFCCnAddnRem('t_l37.wav',fs,quiet_matrix_av,noise,snr);
          tArray3(:,:,38) = MFCCnAddnRem('t_l38.wav',fs,quiet_matrix_av,noise,snr);
          tArray3(:,:,39) = MFCCnAddnRem('t_l39.wav',fs,quiet_matrix_av,noise,snr);
          tArray3(:,:,40) = MFCCnAddnRem('t_l40.wav',fs,quiet_matrix_av,noise,snr);
          tArray3(:,:,41) = MFCCnAddnRem('t_l41.wav',fs,quiet_matrix_av,noise,snr);
          tArray3(:,:,42) = MFCCnAddnRem('t_l42.wav',fs,quiet_matrix_av,noise,snr);
          tArray3(:,:,43) = MFCCnAddnRem('t_l43.wav',fs,quiet_matrix_av,noise,snr);
          tArray3(:,:,44) = MFCCnAddnRem('t_l44.wav',fs,quiet_matrix_av,noise,snr);
          tArray3(:,:,45) = MFCCnAddnRem('t_l45.wav',fs,quiet_matrix_av,noise,snr);
          tArray3(:,:,46) = MFCCnAddnRem('t_l46.wav',fs,quiet_matrix_av,noise,snr);
          tArray3(:,:,47) = MFCCnAddnRem('t_l47.wav',fs,quiet_matrix_av,noise,snr);
          tArray3(:,:,48) = MFCCnAddnRem('t_l48.wav',fs,quiet_matrix_av,noise,snr);
          tArray3(:,:,49) = MFCCnAddnRem('t_l49.wav',fs,quiet_matrix_av,noise,snr);
          tArray3(:,:,50) = MFCCnAddnRem('t_l50.wav',fs,quiet_matrix_av,noise,snr);
          end

          if wordSet == 4
          wordMatch = 4;
          tArray4(:,:,1) = MFCCnAddnRem('t_r1.wav',fs,quiet_matrix_av,noise,snr);
          tArray4(:,:,2) = MFCCnAddnRem('t_r2.wav',fs,quiet_matrix_av,noise,snr);
          tArray4(:,:,3) = MFCCnAddnRem('t_r3.wav',fs,quiet_matrix_av,noise,snr);
          tArray4(:,:,4) = MFCCnAddnRem('t_r4.wav',fs,quiet_matrix_av,noise,snr);
          tArray4(:,:,5) = MFCCnAddnRem('t_r5.wav',fs,quiet_matrix_av,noise,snr);
          tArray4(:,:,6) = MFCCnAddnRem('t_r6.wav',fs,quiet_matrix_av,noise,snr);
          tArray4(:,:,7) = MFCCnAddnRem('t_r7.wav',fs,quiet_matrix_av,noise,snr);
          tArray4(:,:,8) = MFCCnAddnRem('t_r8.wav',fs,quiet_matrix_av,noise,snr);
          tArray4(:,:,9) = MFCCnAddnRem('t_r9.wav',fs,quiet_matrix_av,noise,snr);
          tArray4(:,:,10) = MFCCnAddnRem('t_r11.wav',fs,quiet_matrix_av,noise,snr);
          tArray4(:,:,11) = MFCCnAddnRem('t_r11.wav',fs,quiet_matrix_av,noise,snr);
          tArray4(:,:,12) = MFCCnAddnRem('t_r12.wav',fs,quiet_matrix_av,noise,snr);
          tArray4(:,:,13) = MFCCnAddnRem('t_r13.wav',fs,quiet_matrix_av,noise,snr);
          tArray4(:,:,14) = MFCCnAddnRem('t_r14.wav',fs,quiet_matrix_av,noise,snr);
          tArray4(:,:,15) = MFCCnAddnRem('t_r15.wav',fs,quiet_matrix_av,noise,snr);
          tArray4(:,:,16) = MFCCnAddnRem('t_r16.wav',fs,quiet_matrix_av,noise,snr);
          tArray4(:,:,17) = MFCCnAddnRem('t_r17.wav',fs,quiet_matrix_av,noise,snr);
          tArray4(:,:,18) = MFCCnAddnRem('t_r18.wav',fs,quiet_matrix_av,noise,snr);
          tArray4(:,:,19) = MFCCnAddnRem('t_r19.wav',fs,quiet_matrix_av,noise,snr);
          tArray4(:,:,20) = MFCCnAddnRem('t_r20.wav',fs,quiet_matrix_av,noise,snr);
          tArray4(:,:,21) = MFCCnAddnRem('t_r21.wav',fs,quiet_matrix_av,noise,snr);
          tArray4(:,:,22) = MFCCnAddnRem('t_r22.wav',fs,quiet_matrix_av,noise,snr);
          tArray4(:,:,23) = MFCCnAddnRem('t_r23.wav',fs,quiet_matrix_av,noise,snr);
          tArray4(:,:,24) = MFCCnAddnRem('t_r24.wav',fs,quiet_matrix_av,noise,snr);
          tArray4(:,:,25) = MFCCnAddnRem('t_r25.wav',fs,quiet_matrix_av,noise,snr);
          tArray4(:,:,26) = MFCCnAddnRem('t_r26.wav',fs,quiet_matrix_av,noise,snr);
          tArray4(:,:,27) = MFCCnAddnRem('t_r27.wav',fs,quiet_matrix_av,noise,snr);
          tArray4(:,:,28) = MFCCnAddnRem('t_r28.wav',fs,quiet_matrix_av,noise,snr);
          tArray4(:,:,29) = MFCCnAddnRem('t_r29.wav',fs,quiet_matrix_av,noise,snr);
          tArray4(:,:,30) = MFCCnAddnRem('t_r30.wav',fs,quiet_matrix_av,noise,snr);
          tArray4(:,:,31) = MFCCnAddnRem('t_r31.wav',fs,quiet_matrix_av,noise,snr);
          tArray4(:,:,32) = MFCCnAddnRem('t_r32.wav',fs,quiet_matrix_av,noise,snr);
          tArray4(:,:,33) = MFCCnAddnRem('t_r33.wav',fs,quiet_matrix_av,noise,snr);
          tArray4(:,:,34) = MFCCnAddnRem('t_r34.wav',fs,quiet_matrix_av,noise,snr);
          tArray4(:,:,35) = MFCCnAddnRem('t_r35.wav',fs,quiet_matrix_av,noise,snr);
          tArray4(:,:,36) = MFCCnAddnRem('t_r36.wav',fs,quiet_matrix_av,noise,snr);
          tArray4(:,:,37) = MFCCnAddnRem('t_r37.wav',fs,quiet_matrix_av,noise,snr);
          tArray4(:,:,38) = MFCCnAddnRem('t_r38.wav',fs,quiet_matrix_av,noise,snr);
          tArray4(:,:,39) = MFCCnAddnRem('t_r39.wav',fs,quiet_matrix_av,noise,snr);
          tArray4(:,:,40) = MFCCnAddnRem('t_r40.wav',fs,quiet_matrix_av,noise,snr);
          tArray4(:,:,41) = MFCCnAddnRem('t_r41.wav',fs,quiet_matrix_av,noise,snr);
          tArray4(:,:,42) = MFCCnAddnRem('t_r42.wav',fs,quiet_matrix_av,noise,snr);
          tArray4(:,:,43) = MFCCnAddnRem('t_r43.wav',fs,quiet_matrix_av,noise,snr);
          tArray4(:,:,44) = MFCCnAddnRem('t_r44.wav',fs,quiet_matrix_av,noise,snr);
          tArray4(:,:,45) = MFCCnAddnRem('t_r45.wav',fs,quiet_matrix_av,noise,snr);
          tArray4(:,:,46) = MFCCnAddnRem('t_r46.wav',fs,quiet_matrix_av,noise,snr);
          tArray4(:,:,47) = MFCCnAddnRem('t_r47.wav',fs,quiet_matrix_av,noise,snr);
          tArray4(:,:,48) = MFCCnAddnRem('t_r48.wav',fs,quiet_matrix_av,noise,snr);
          tArray4(:,:,49) = MFCCnAddnRem('t_r49.wav',fs,quiet_matrix_av,noise,snr);
          tArray4(:,:,50) = MFCCnAddnRem('t_r50.wav',fs,quiet_matrix_av,noise,snr);
          end
          
%% main loop

counter = 0;
wordCount = 0;
recCount = 0;
wordsN = [];
correct = [];
difference = [];
av = [];

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
         
%% calculate DTW averages of utterance compared to training sets
                            
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
                                                  
                  finalAv = [goAv ; smAv ; lAv ; rAv];       % all set matching value averages            
                  sorted = sort(finalAv);                    % sort the list                
                  M = min(finalAv);                          % find best matching score
                  min2nd = sorted(2, :);                     % find second best matching score
                  dif = min2nd - M;                          % get matching score difference

%% display data                   
                  
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
                    
                    % command correct/incorrect
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
   
