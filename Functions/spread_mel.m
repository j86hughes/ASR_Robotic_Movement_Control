function band=spread_mel(hz_points,hz_c,hz_size,hz_max)
%hz_array is an array spaced in hz
%hz_c is the current index
band=zeros(1, hz_size);
hz1=hz_points(max(1,hz_c-1));                 %start
hz2=hz_points(hz_c);                          %middle
hz3=hz_points(min(length(hz_points),hz_c+1)); %end
%-----
for hi=1:hz_size
    hz=hi*hz_max/hz_size;
    if hz > hz3
        band(hi)=0;
    elseif hz>=hz2
        band(hi)=(hz3-hz)/(hz3-hz2);
    elseif hz>=hz1
        band(hi)=(hz-hz1)/(hz2-hz1);
    else
        band(hi)=0;
    end
end
