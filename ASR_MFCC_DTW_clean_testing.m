%% This file is for testing the system's accuracy without the use of denoising 
%  techniques. 
%  MFCC features are compared using DTW.
%  Training and testing commands have both been recorded in
%  the same quiet room.

%·        - Extract MFCCs from training command words
%         - Replace any inf values in all MFCC matrices with zeros
%         - Extract MFCCs from testing utterances
%         - Replace any inf values in testing utterance MFCC matrices with
%         zeros
%         - Compare utterance MFCCs with training MFCCs using DTW
%         - Get average DTW matching score of each command class
%         - The command class with the best (lowest) DTW average score is matched to the utterance
%         - Record DTW score
%         - Record matching score difference between matched command and
%           second closest matched command
%         - Record if utterance was correctly matched
%         - Results collected in 'Results' table
 
%% set up variables 

clear;clc;close all;

mex dtw_c.c;                    % DTW
w=50;                           % DTW

fs = 44100;                     % sampling frequency
Ws=1024;                        % window size?
Ol=512;                         % 50% overlap?
N=12;                           % number of frequency bins?

SamplesPerFrame = 512;          %  

%% testing variables 

wordSet =1;                     % command to test           
         
%% for all training data samples:

% 1) exctract MFCCs
% 2) convert any inf values to 0s
            
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
          
          if wordSet == 1
          wordMatch = 1;
          disp('getting testing set 1...');
          tArray1(:,:,1) = MFCCinfRem('m_df1.wav',fs);
          tArray1(:,:,2) = MFCCinfRem('m_df2.wav',fs);
          tArray1(:,:,3) = MFCCinfRem('m_df3.wav',fs);
          tArray1(:,:,4) = MFCCinfRem('m_df4.wav',fs);
          tArray1(:,:,5) = MFCCinfRem('m_df5.wav',fs);
          tArray1(:,:,6) = MFCCinfRem('m_df6.wav',fs);
          tArray1(:,:,7) = MFCCinfRem('m_df7.wav',fs);
          tArray1(:,:,8) = MFCCinfRem('m_df8.wav',fs);
          tArray1(:,:,9) = MFCCinfRem('m_df9.wav',fs);
          tArray1(:,:,10) = MFCCinfRem('m_df10.wav',fs);
          tArray1(:,:,11) = MFCCinfRem('m_df11.wav',fs);
          tArray1(:,:,12) = MFCCinfRem('m_df12.wav',fs);
          tArray1(:,:,13) = MFCCinfRem('m_df13.wav',fs);
          tArray1(:,:,14) = MFCCinfRem('m_df14.wav',fs);
          tArray1(:,:,15) = MFCCinfRem('m_df15.wav',fs);
          tArray1(:,:,16) = MFCCinfRem('m_df16.wav',fs);
          tArray1(:,:,17) = MFCCinfRem('m_df17.wav',fs);
          tArray1(:,:,18) = MFCCinfRem('m_df18.wav',fs);
          tArray1(:,:,19) = MFCCinfRem('m_df19.wav',fs);
          tArray1(:,:,20) = MFCCinfRem('m_df20.wav',fs);
          tArray1(:,:,21) = MFCCinfRem('m_df21.wav',fs);
          tArray1(:,:,22) = MFCCinfRem('m_df22.wav',fs);
          tArray1(:,:,23) = MFCCinfRem('m_df23.wav',fs);
          tArray1(:,:,24) = MFCCinfRem('m_df24.wav',fs);
          tArray1(:,:,25) = MFCCinfRem('m_df25.wav',fs);
          tArray1(:,:,26) = MFCCinfRem('m_df26.wav',fs);
          tArray1(:,:,27) = MFCCinfRem('m_df27.wav',fs);
          tArray1(:,:,28) = MFCCinfRem('m_df28.wav',fs);
          tArray1(:,:,29) = MFCCinfRem('m_df29.wav',fs);
          tArray1(:,:,30) = MFCCinfRem('m_df30.wav',fs);
          tArray1(:,:,31) = MFCCinfRem('m_df31.wav',fs);
          tArray1(:,:,32) = MFCCinfRem('m_df32.wav',fs);
          tArray1(:,:,33) = MFCCinfRem('m_df33.wav',fs);
          tArray1(:,:,34) = MFCCinfRem('m_df34.wav',fs);
          tArray1(:,:,35) = MFCCinfRem('m_df35.wav',fs);
          tArray1(:,:,36) = MFCCinfRem('m_df36.wav',fs);
          tArray1(:,:,37) = MFCCinfRem('m_df37.wav',fs);
          tArray1(:,:,38) = MFCCinfRem('m_df38.wav',fs);
          tArray1(:,:,39) = MFCCinfRem('m_df39.wav',fs);
          tArray1(:,:,40) = MFCCinfRem('m_df40.wav',fs);
          tArray1(:,:,41) = MFCCinfRem('m_df41.wav',fs);
          tArray1(:,:,42) = MFCCinfRem('m_df42.wav',fs);
          tArray1(:,:,43) = MFCCinfRem('m_df43.wav',fs);
          tArray1(:,:,44) = MFCCinfRem('m_df44.wav',fs);
          tArray1(:,:,45) = MFCCinfRem('m_df45.wav',fs);
          tArray1(:,:,46) = MFCCinfRem('m_df46.wav',fs);
          tArray1(:,:,47) = MFCCinfRem('m_df47.wav',fs);
          tArray1(:,:,48) = MFCCinfRem('m_df48.wav',fs);
          tArray1(:,:,49) = MFCCinfRem('m_df49.wav',fs);
          tArray1(:,:,50) = MFCCinfRem('m_df50.wav',fs);          
          end
          
          if wordSet == 2
          wordMatch = 2;
          disp('getting testing set 1...');
          tArray2(:,:,1) = MFCCinfRem('m_sm1.wav',fs);
          tArray2(:,:,2) = MFCCinfRem('m_sm2.wav',fs);
          tArray2(:,:,3) = MFCCinfRem('m_sm3.wav',fs);
          tArray2(:,:,4) = MFCCinfRem('m_sm4.wav',fs);
          tArray2(:,:,5) = MFCCinfRem('m_sm5.wav',fs);
          tArray2(:,:,6) = MFCCinfRem('m_sm6.wav',fs);
          tArray2(:,:,7) = MFCCinfRem('m_sm7.wav',fs);
          tArray2(:,:,8) = MFCCinfRem('m_sm8.wav',fs);
          tArray2(:,:,9) = MFCCinfRem('m_sm9.wav',fs);
          tArray2(:,:,10) = MFCCinfRem('m_sm10.wav',fs);
          tArray2(:,:,11) = MFCCinfRem('m_sm11.wav',fs);
          tArray2(:,:,12) = MFCCinfRem('m_sm12.wav',fs);
          tArray2(:,:,13) = MFCCinfRem('m_sm13.wav',fs);
          tArray2(:,:,14) = MFCCinfRem('m_sm14.wav',fs);
          tArray2(:,:,15) = MFCCinfRem('m_sm15.wav',fs);
          tArray2(:,:,16) = MFCCinfRem('m_sm16.wav',fs);
          tArray2(:,:,17) = MFCCinfRem('m_sm17.wav',fs);
          tArray2(:,:,18) = MFCCinfRem('m_sm18.wav',fs);
          tArray2(:,:,19) = MFCCinfRem('m_sm19.wav',fs);
          tArray2(:,:,20) = MFCCinfRem('m_sm20.wav',fs);
          tArray2(:,:,21) = MFCCinfRem('m_sm21.wav',fs);
          tArray2(:,:,22) = MFCCinfRem('m_sm22.wav',fs);
          tArray2(:,:,23) = MFCCinfRem('m_sm23.wav',fs);
          tArray2(:,:,24) = MFCCinfRem('m_sm24.wav',fs);
          tArray2(:,:,25) = MFCCinfRem('m_sm25.wav',fs);
          tArray2(:,:,26) = MFCCinfRem('m_sm26.wav',fs);
          tArray2(:,:,27) = MFCCinfRem('m_sm27.wav',fs);
          tArray2(:,:,28) = MFCCinfRem('m_sm28.wav',fs);
          tArray2(:,:,29) = MFCCinfRem('m_sm29.wav',fs);
          tArray2(:,:,30) = MFCCinfRem('m_sm30.wav',fs);
          tArray2(:,:,31) = MFCCinfRem('m_sm31.wav',fs);
          tArray2(:,:,32) = MFCCinfRem('m_sm32.wav',fs);
          tArray2(:,:,33) = MFCCinfRem('m_sm33.wav',fs);
          tArray2(:,:,34) = MFCCinfRem('m_sm34.wav',fs);
          tArray2(:,:,35) = MFCCinfRem('m_sm35.wav',fs);
          tArray2(:,:,36) = MFCCinfRem('m_sm36.wav',fs);
          tArray2(:,:,37) = MFCCinfRem('m_sm37.wav',fs);
          tArray2(:,:,38) = MFCCinfRem('m_sm38.wav',fs);
          tArray2(:,:,39) = MFCCinfRem('m_sm39.wav',fs);
          tArray2(:,:,40) = MFCCinfRem('m_sm40.wav',fs);
          tArray2(:,:,41) = MFCCinfRem('m_sm41.wav',fs);
          tArray2(:,:,42) = MFCCinfRem('m_sm42.wav',fs);
          tArray2(:,:,43) = MFCCinfRem('m_sm43.wav',fs);
          tArray2(:,:,44) = MFCCinfRem('m_sm44.wav',fs);
          tArray2(:,:,45) = MFCCinfRem('m_sm45.wav',fs);
          tArray2(:,:,46) = MFCCinfRem('m_sm46.wav',fs);
          tArray2(:,:,47) = MFCCinfRem('m_sm47.wav',fs);
          tArray2(:,:,48) = MFCCinfRem('m_sm48.wav',fs);
          tArray2(:,:,49) = MFCCinfRem('m_sm49.wav',fs);
          tArray2(:,:,50) = MFCCinfRem('m_sm50.wav',fs);
          end

          if wordSet == 3
          wordMatch = 3;
          disp('getting testing set 1...');
          tArray3(:,:,1) = MFCCinfRem('m_l1.wav',fs);
          tArray3(:,:,2) = MFCCinfRem('m_l2.wav',fs);
          tArray3(:,:,3) = MFCCinfRem('m_l3.wav',fs);
          tArray3(:,:,4) = MFCCinfRem('m_l4.wav',fs);
          tArray3(:,:,5) = MFCCinfRem('m_l5.wav',fs);
          tArray3(:,:,6) = MFCCinfRem('m_l6.wav',fs);
          tArray3(:,:,7) = MFCCinfRem('m_l7.wav',fs);
          tArray3(:,:,8) = MFCCinfRem('m_l8.wav',fs);
          tArray3(:,:,9) = MFCCinfRem('m_l9.wav',fs);
          tArray3(:,:,10) = MFCCinfRem('m_l10.wav',fs);
          tArray3(:,:,11) = MFCCinfRem('m_l11.wav',fs);
          tArray3(:,:,12) = MFCCinfRem('m_l12.wav',fs);
          tArray3(:,:,13) = MFCCinfRem('m_l13.wav',fs);
          tArray3(:,:,14) = MFCCinfRem('m_l14.wav',fs);
          tArray3(:,:,15) = MFCCinfRem('m_l15.wav',fs);
          tArray3(:,:,16) = MFCCinfRem('m_l16.wav',fs);
          tArray3(:,:,17) = MFCCinfRem('m_l17.wav',fs);
          tArray3(:,:,18) = MFCCinfRem('m_l18.wav',fs);
          tArray3(:,:,19) = MFCCinfRem('m_l19.wav',fs);
          tArray3(:,:,20) = MFCCinfRem('m_l20.wav',fs);
          tArray3(:,:,21) = MFCCinfRem('m_l21.wav',fs);
          tArray3(:,:,22) = MFCCinfRem('m_l22.wav',fs);
          tArray3(:,:,23) = MFCCinfRem('m_l23.wav',fs);
          tArray3(:,:,24) = MFCCinfRem('m_l24.wav',fs);
          tArray3(:,:,25) = MFCCinfRem('m_l25.wav',fs);
          tArray3(:,:,26) = MFCCinfRem('m_l26.wav',fs);
          tArray3(:,:,27) = MFCCinfRem('m_l27.wav',fs);
          tArray3(:,:,28) = MFCCinfRem('m_l28.wav',fs);
          tArray3(:,:,29) = MFCCinfRem('m_l29.wav',fs);
          tArray3(:,:,30) = MFCCinfRem('m_l30.wav',fs);
          tArray3(:,:,31) = MFCCinfRem('m_l31.wav',fs);
          tArray3(:,:,32) = MFCCinfRem('m_l32.wav',fs);
          tArray3(:,:,33) = MFCCinfRem('m_l33.wav',fs);
          tArray3(:,:,34) = MFCCinfRem('m_l34.wav',fs);
          tArray3(:,:,35) = MFCCinfRem('m_l35.wav',fs);
          tArray3(:,:,36) = MFCCinfRem('m_l36.wav',fs);
          tArray3(:,:,37) = MFCCinfRem('m_l37.wav',fs);
          tArray3(:,:,38) = MFCCinfRem('m_l38.wav',fs);
          tArray3(:,:,39) = MFCCinfRem('m_l39.wav',fs);
          tArray3(:,:,40) = MFCCinfRem('m_l40.wav',fs);
          tArray3(:,:,41) = MFCCinfRem('m_l41.wav',fs);
          tArray3(:,:,42) = MFCCinfRem('m_l42.wav',fs);
          tArray3(:,:,43) = MFCCinfRem('m_l43.wav',fs);
          tArray3(:,:,44) = MFCCinfRem('m_l44.wav',fs);
          tArray3(:,:,45) = MFCCinfRem('m_l45.wav',fs);
          tArray3(:,:,46) = MFCCinfRem('m_l46.wav',fs);
          tArray3(:,:,47) = MFCCinfRem('m_l47.wav',fs);
          tArray3(:,:,48) = MFCCinfRem('m_l48.wav',fs);
          tArray3(:,:,49) = MFCCinfRem('m_l49.wav',fs);
          tArray3(:,:,50) = MFCCinfRem('m_l50.wav',fs);
          end
          
          if wordSet == 4
          wordMatch = 4;
          disp('getting testing set 1...');
          tArray4(:,:,1) = MFCCinfRem('m_r1.wav',fs);
          tArray4(:,:,2) = MFCCinfRem('m_r2.wav',fs);
          tArray4(:,:,3) = MFCCinfRem('m_r3.wav',fs);
          tArray4(:,:,4) = MFCCinfRem('m_r4.wav',fs);
          tArray4(:,:,5) = MFCCinfRem('m_r5.wav',fs);
          tArray4(:,:,6) = MFCCinfRem('m_r6.wav',fs);
          tArray4(:,:,7) = MFCCinfRem('m_r7.wav',fs);
          tArray4(:,:,8) = MFCCinfRem('m_r8.wav',fs);
          tArray4(:,:,9) = MFCCinfRem('m_r9.wav',fs);
          tArray4(:,:,10) = MFCCinfRem('m_r10.wav',fs);
          tArray4(:,:,11) = MFCCinfRem('m_r11.wav',fs);
          tArray4(:,:,12) = MFCCinfRem('m_r12.wav',fs);
          tArray4(:,:,13) = MFCCinfRem('m_r13.wav',fs);
          tArray4(:,:,14) = MFCCinfRem('m_r14.wav',fs);
          tArray4(:,:,15) = MFCCinfRem('m_r15.wav',fs);
          tArray4(:,:,16) = MFCCinfRem('m_r16.wav',fs);
          tArray4(:,:,17) = MFCCinfRem('m_r17.wav',fs);
          tArray4(:,:,18) = MFCCinfRem('m_r18.wav',fs);
          tArray4(:,:,19) = MFCCinfRem('m_r19.wav',fs);
          tArray4(:,:,20) = MFCCinfRem('m_r20.wav',fs);
          tArray4(:,:,21) = MFCCinfRem('m_r21.wav',fs);
          tArray4(:,:,22) = MFCCinfRem('m_r22.wav',fs);
          tArray4(:,:,23) = MFCCinfRem('m_r23.wav',fs);
          tArray4(:,:,24) = MFCCinfRem('m_r24.wav',fs);
          tArray4(:,:,25) = MFCCinfRem('m_r25.wav',fs);
          tArray4(:,:,26) = MFCCinfRem('m_r26.wav',fs);
          tArray4(:,:,27) = MFCCinfRem('m_r27.wav',fs);
          tArray4(:,:,28) = MFCCinfRem('m_r28.wav',fs);
          tArray4(:,:,29) = MFCCinfRem('m_r29.wav',fs);
          tArray4(:,:,30) = MFCCinfRem('m_r30.wav',fs);
          tArray4(:,:,31) = MFCCinfRem('m_r31.wav',fs);
          tArray4(:,:,32) = MFCCinfRem('m_r32.wav',fs);
          tArray4(:,:,33) = MFCCinfRem('m_r33.wav',fs);
          tArray4(:,:,34) = MFCCinfRem('m_r34.wav',fs);
          tArray4(:,:,35) = MFCCinfRem('m_r35.wav',fs);
          tArray4(:,:,36) = MFCCinfRem('m_r36.wav',fs);
          tArray4(:,:,37) = MFCCinfRem('m_r37.wav',fs);
          tArray4(:,:,38) = MFCCinfRem('m_r38.wav',fs);
          tArray4(:,:,39) = MFCCinfRem('m_r39.wav',fs);
          tArray4(:,:,40) = MFCCinfRem('m_r40.wav',fs);
          tArray4(:,:,41) = MFCCinfRem('m_r41.wav',fs);
          tArray4(:,:,42) = MFCCinfRem('m_r42.wav',fs);
          tArray4(:,:,43) = MFCCinfRem('m_r43.wav',fs);
          tArray4(:,:,44) = MFCCinfRem('m_r44.wav',fs);
          tArray4(:,:,45) = MFCCinfRem('m_r45.wav',fs);
          tArray4(:,:,46) = MFCCinfRem('m_r46.wav',fs);
          tArray4(:,:,47) = MFCCinfRem('m_r47.wav',fs);
          tArray4(:,:,48) = MFCCinfRem('m_r48.wav',fs);
          tArray4(:,:,49) = MFCCinfRem('m_r49.wav',fs);
          tArray4(:,:,50) = MFCCinfRem('m_r50.wav',fs);
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
                                                  
                  finalAv = [goAv ; smAv ; lAv ; rAv];         % all set matching value averages         
                  sorted = sort(finalAv);                      % sort the list               
                  M = min(finalAv);                            % find best matching score 
                  min2nd = sorted(2, :);                       % find second best matching score 
                  dif = min2nd - M;                            % get matching score difference  

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
   
