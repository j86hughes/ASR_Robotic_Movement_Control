%% This file is for demonstrating the control of a Lego EV3 robot with the ASR system.
% The system uses the noise MFCC thresholding technique.
% The robot carries out actions for a specific time duration, during which
% the system does not listen for new commands. This is to ensure the
% noise of the robot is not confused as an utterance since the system has
% been tested at close proximity to the robot.


%         - Record segment of ambient noise 
%           and get MFCCs
%         - Get average filterbank values above and below zero 
%·        - Extract MFCCs from pre-recorded command words (training data)
%         - Replace any inf values in all MFCC matrices with zeros
%         - Acquire average amplitude from noise segment to get amplitude threshold
%         - Start main loop
%         - Continuously monitor microphone amplitude level (listening mode)
%         - If amplitude threshold is exceeded, record 2 seconds of audio (recording mode)
%         - Extract MFCCs from recorded utterance
%         - Replace any inf values in utterance MFCC matrix with zeros
%         - Apply ambient noise MFCC thresholds to utterance MFCC matrix
%         - Compare utterance MFCCs with training MFCCs using DTW
%         - Take the average DTW matching score of each command class
%         - If the matching score difference between the closest and second
%           closest matched command is below the match difference threshold value, then the
%           system prompts the user to repeat the command and goes back to listening mode
%         - If the matching score difference is above the threshold, then The command word 
%           set with the best (lowest) DTW average score is matched to the recorded utterance
%         - Lego robot performs command instruction
%         - Go back to beginning of the loop (listening mode)
 
%% set up variables 

clear;clc;close all;

myev3 = legoev3('USB');         % connect to Lego EV3 robot
lmotor = motor(myev3,'B');      % left motor
rmotor = motor(myev3,'C');      % right motor

mex dtw_c.c;                    % DTW
w=50;                           % DTW

fs = 44100;                     % sampling frequency
Ws=1024;                        % window size
Ol=512;                         % 50% overlap
N=12;                           % number of frequency

% snr = 20;                       % SNR
m_thresh = 15;                  % DTW match difference threshold
       
%SamplesPerFrame = 512;          % microphone samples per frame
SamplesPerFrame = 256;          % microphone samples per frame
%SamplesPerFrame = 128;          % microphone samples per frame

%% set up mic for amplitude threshold 
                           
AR = audioDeviceReader('OutputNumOverrunSamples',true, ...
            'SampleRate',fs, ...
            'SamplesPerFrame',SamplesPerFrame,...
            'NumChannels',1,...     
            'Device','Focusrite USB (Focusrite USB Audio)',...
            'OutputDataType','double');      

% info = audiodevinfo        
% Focusrite USB (Focusrite USB Audio)  
% Line In (3- Scarlett Solo)
% Microphone (3- Scarlett Solo)
% Microphone (Scarlett Solo) (Windows DirectSound)

%% mic test
         
         testAudio = 0;
         testSample = [];
         %testSample = [ 0 ; 0 ];
         disp('say something...');
         tic;
         while toc < 2
            testAudio = record(AR);                   
            testSample = [testSample ; testAudio];                                       
         end
         sound(testSample,fs);
         tic
         while toc < 5
         end

%% record ambient noise

         quietAudio = 0;
         quietSample = [];
         
         disp('recording ambient noise...');
         tic;
         while toc < 2
            quietAudio = record(AR);                   
            quietSample = [quietSample ; quietAudio];                                       
         end
         
         quiet_matrix = getMFCC(quietSample,fs);     	% get MFCC feature matrix       
         quiet_matrix(~isfinite(quiet_matrix))=0;       % replace inf with 0s            
         sound(quietSample,fs);                         % play recording
         
% for each row in noise matrix:
% get median value above 0
% get median value below 0
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

% array of filterbank averages above 0
highMat = [ r1HighAv;r2HighAv;r3HighAv;r4HighAv;r5HighAv;r6HighAv;r7HighAv;r8HighAv;r9HighAv;r10HighAv;r11HighAv;r12HighAv ];
% array of filterbank aveages below 0
lowMat = [ r1LowAv;r2LowAv;r3LowAv;r4LowAv;r5LowAv;r6LowAv;r7LowAv;r8LowAv;r9LowAv;r10LowAv;r11LowAv;r12LowAv ];

% convert any NaN values to 0
lowMat(isnan (lowMat)) = 0; 
highMat(isnan (highMat)) = 0; 
          

%% get synth words
            
        disp('Getting data...');
        
        %http://www.fromtexttospeech.com/
        [sGo,] = audioread('synthDF.mp3');
        [sSM,] = audioread('synthSM.mp3');
        [sLeft,] = audioread('synthLeft.mp3');
        [sRight,] = audioread('synthRight.mp3');
        [sCC,] = audioread('synthCC.mp3');
        [sRepeat,] = audioread('synthRepeat.mp3');
        [sReverse,] = audioread('synthReverse.mp3');                 
         
%% for all training data samples:

% 1) exctract MFCCs from training words
% 2) convert any inf values to 0s
              
          % "reverse"
          rvArray(:,:,1) = MFCCinfRem('Nrv1.wav',fs); 
          rvArray(:,:,2) = MFCCinfRem('Nrv2.wav',fs); 
          rvArray(:,:,3) = MFCCinfRem('Nrv3.wav',fs);
          rvArray(:,:,4) = MFCCinfRem('Nrv4.wav',fs);
          rvArray(:,:,5) = MFCCinfRem('Nrv5.wav',fs);
          rvArray(:,:,6) = MFCCinfRem('Nrv6.wav',fs);
          rvArray(:,:,7) = MFCCinfRem('Nrv7.wav',fs);
          rvArray(:,:,8) = MFCCinfRem('Nrv8.wav',fs);
          rvArray(:,:,9) = MFCCinfRem('Nrv9.wav',fs);
          rvArray(:,:,10) = MFCCinfRem('Nrv10.wav',fs);
          rvArray(:,:,11) = MFCCinfRem('Nrv11.wav',fs);
          rvArray(:,:,12) = MFCCinfRem('Nrv12.wav',fs);
          rvArray(:,:,13) = MFCCinfRem('Nrv13.wav',fs);
          rvArray(:,:,14) = MFCCinfRem('Nrv14.wav',fs);
          rvArray(:,:,15) = MFCCinfRem('Nrv15.wav',fs);
          rvArray(:,:,16) = MFCCinfRem('Nrv16.wav',fs);
          rvArray(:,:,17) = MFCCinfRem('Nrv17.wav',fs);
          rvArray(:,:,18) = MFCCinfRem('Nrv18.wav',fs);
          rvArray(:,:,19) = MFCCinfRem('Nrv19.wav',fs);
          rvArray(:,:,20) = MFCCinfRem('Nrv20.wav',fs);
          rvArray(:,:,21) = MFCCinfRem('Nrv21.wav',fs);
          rvArray(:,:,22) = MFCCinfRem('Nrv22.wav',fs);
          rvArray(:,:,23) = MFCCinfRem('Nrv23.wav',fs);
          rvArray(:,:,24) = MFCCinfRem('Nrv24.wav',fs);
          rvArray(:,:,25) = MFCCinfRem('Nrv25.wav',fs);
          rvArray(:,:,26) = MFCCinfRem('Nrv26.wav',fs);
          rvArray(:,:,27) = MFCCinfRem('Nrv27.wav',fs);
          rvArray(:,:,28) = MFCCinfRem('Nrv28.wav',fs);
          rvArray(:,:,29) = MFCCinfRem('Nrv29.wav',fs);
          rvArray(:,:,30) = MFCCinfRem('Nrv30.wav',fs);
          
          % "drive forwards"
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
                      
          % "left"
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
          
          % "right"
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
                  
%% get noise threshold 

disp('Please be quiet for one second...');
    tic;
    while toc < 1.0,
    [audioIn,nOverrun] = step(AR);
    
        if nOverrun > 0
        fprintf('Audio recorder queue was overrun by %d samples\n', nOverrun);
        end
    end
       
threshold = max(audioIn(:,1));          % get amplitude threshold value
%threshold = max(audioIn);                % get amplitude threshold value

%% main loop

counter = 0;
wordCount = 0;
recCount = 0;
wordsN = [];
correct = [];
difference = [];
av = [];

disp('Start');

while toc < 5,
    
    s = 0;

    recording = false;
    notRecording = true;
        
%% listening mode

    while recording == false && notRecording == true
    
        acquiredAudio = 0;
        addUp = 0;
        a = [];
        
        counter = counter + 1;
    
        s = step(AR);                   

            if max(s)>threshold*6    % amplitude threshold trigger
                
                tic;
                while toc < 2
                    acquiredAudio = record(AR);
                    
                    a = [a ; acquiredAudio];
                                       
                end
                
                tic;
                
                    recCount = recCount + 1;
                
                    myRecording = a;
                    
                    mfcc_matrix = getMFCC(myRecording,fs);          % get MFCCs             
                    mfcc_matrix(~isfinite(mfcc_matrix))=0;          % replace inf with 0s                     
                    mfcc_matrix = mfcc_matrix(:,1:85);              % trim matrix to correct size
                    
                    mfcc_high = mfcc_matrix;
                    mfcc_low = mfcc_matrix;
                    
                    % MFCC matrix where only negative values below threshold are kept                    
                    for counter = 1:12  
                    thisRow = mfcc_low(counter,:);
                    %idmax = (thisRow >= lowMat(counter));
                    idmax = (thisRow >= lowMat(counter)/1.5);
                    %idmax = (thisRow >= lowMat(counter)/100);
                    thisRow(idmax) = 0;
                    mfcc_low(counter,:) = thisRow;
                    end

                    % MFCC matrix where only positive values above threshold are kept
                    for counter = 1:12  
                    thisRow = mfcc_high(counter,:);
                    %idmax = (thisRow <= highMat(counter));
                    idmax = (thisRow <= highMat(counter)/1.5);
                    %idmax = (thisRow <= highMat(counter)/100);
                    thisRow(idmax) = 0;
                    mfcc_high(counter,:) = thisRow;
                    end

                    % add matrices together
                    mfcc_new = mfcc_low + mfcc_high;
                    mfcc_matrix = mfcc_new;
                    mfcc_matrix = mfcc_matrix(:,1:85);      % fix matrix length
                        
%% calculate DTW averages of utterance compared to training sets
                             
                    dtwGoMean = 0;
                    dtwRvMean = 0;
                    dtwLMean = 0;
                    dtwRMean = 0;
                
                    for idx = 1 : 30
                        dtwGoMean = dtwGoMean + dtw_c(mfcc_matrix,goArray(:,:,idx),w);
                    end
                
                    for idx = 1 : 30
                        dtwRvMean = dtwRvMean + dtw_c(mfcc_matrix,rvArray(:,:,idx),w);
                    end
                    
                    for idx = 1 : 30
                        dtwLMean = dtwLMean + dtw_c(mfcc_matrix,lArray(:,:,idx),w);
                    end
                    
                    for idx = 1 : 30
                        dtwRMean = dtwRMean + dtw_c(mfcc_matrix,rArray(:,:,idx),w);
                    end
                    
                    % calculate averge scores
                    goAv = dtwGoMean / 30;
                    rvAv = dtwRvMean / 30;
                    lAv = dtwLMean / 30;
                    rAv = dtwRMean / 30;
                                    
%% Matching                

                  finalAv = [goAv ; rvAv ; lAv ; rAv];   % all set matching value averages              
                  sorted = sort(finalAv);                % sort the list                    
                  M = min(finalAv);                      % find best matching score
                  min2nd = sorted(2, :);                 % find second best matching score 
                  dif = min2nd - M;                      % get matching score difference 
                  
                  toc
                  
                  stop(lmotor);                          % stop robot for next command
                  stop(rmotor);                          % stop robot for next command
                  
                  fprintf('Test No. %d \n', recCount);
                  
                  % match threshold 
                  if dif < m_thresh
                     sound(sRepeat,22050);
                     fprintf('Please repeat command : %f \n', dif);
                     tic;
                     while toc < 2
                     end
                  end
                  
                  % command matching
                  if M == goAv && dif > m_thresh   
                     sound(sGo,22050); 
                     fprintf('drive forwards : %f \n', dif);
                     lmotor.Speed = 30;
                     rmotor.Speed = 30;
                     tic;
                     while toc < 1.5
                     start(lmotor);
                     start(rmotor);
                     end
                     stop(lmotor);
                     stop(rmotor);
                  end
                              
                  if M == rvAv && dif > m_thresh
                     sound(sReverse,22050); 
                     fprintf('reverse : %f \n', dif);
                     lmotor.Speed = -30;
                     rmotor.Speed = -30;
                     tic;
                     while toc < 1.5
                         start(lmotor);
                         start(rmotor);
                     end
                     stop(lmotor);
                     stop(rmotor);
                  end
                  
                  if M == lAv && dif > m_thresh 
                     sound(sLeft,22050);
                     fprintf('left : %f \n', dif); 
                     lmotor.Speed = -15;
                     rmotor.Speed = 15;
                     tic;
                     while toc < 1.5
                         start(lmotor);
                         start(rmotor);
                     end
                     stop(lmotor);
                     stop(rmotor);
                  end
                  
                  if M == rAv && dif > m_thresh    
                     sound(sRight,22050);
                     fprintf('right : %f \n', dif);
                     lmotor.Speed = 15;
                     rmotor.Speed = -15;
                     tic;
                     while toc < 1.5
                         start(lmotor);
                         start(rmotor);
                     end
                     stop(lmotor);
                     stop(rmotor);
                  end
                                                                           
                  tic;
                  while toc < 1
                  end
                
            end            
    end                       
            
end   
