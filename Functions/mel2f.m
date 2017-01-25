function [hz]=mel2f(mel)
  hz=700*(10.^(mel/2595)-1);
  