# dendrite-puf-image-matching-spring2019

# Log__March-21-2019

## some results

#####the bar plot with 10 test samples and the logs on the console

```matlab
%%the logs of 10 samples in the MATLAB console with runtime

>> identification('b1.tif','no')
Center1 at [400, 400], radius = 34
Center2 at [400, 400], radius = 35
checking puf REF1...............
the last matchingRate Difference is 100 !
Elapsed time is 16.385367 seconds.
checking puf REF2...............
the last matchingRate Difference is 2.560000e+01 !
the last matchingRate Difference is 1.540000e+01 !
the last matchingRate Difference is 4.620000e+00 !
Elapsed time is 10.718910 seconds.
checking puf REF3...............
the last matchingRate Difference is 9.680000e+00 !
the last matchingRate Difference is 4.610000e-01 !
Elapsed time is 68.141852 seconds.
checking puf REF4...............
the last matchingRate Difference is 4.460000e+00 !
Elapsed time is 52.066296 seconds.
checking puf REF5...............
the last matchingRate Difference is 1.330000e+01 !
the last matchingRate Difference is 2.960000e+00 !
Elapsed time is 38.150984 seconds.
checking puf REF6...............
the last matchingRate Difference is 2.170000e+00 !
Elapsed time is 127.121698 seconds.
checking puf REF7...............
the last matchingRate Difference is 1.040000e+01 !
the last matchingRate Difference is 7.790000e+00 !
the last matchingRate Difference is 3.640000e+00 !
Elapsed time is 25.962629 seconds.
checking puf REF8...............
the last matchingRate Difference is 1.160000e+01 !
the last matchingRate Difference is 7.250000e-01 !
Elapsed time is 55.490462 seconds.
checking puf REF9...............
the last matchingRate Difference is 1.090000e+01 !
the last matchingRate Difference is 2.170000e+00 !
Elapsed time is 44.574610 seconds.
checking puf REF10...............
the last matchingRate Difference is 1.090000e+01 !
the last matchingRate Difference is 4.740000e-01 !
Elapsed time is 70.303956 seconds.
This testing PUF DENDRITE is matched to IMAGE b1 in reference!!! 
 The mathcing Rate is 1!!!!!>> 
```

![10samples]()

#####the plot of image 1 with guassian noise(std. from 0 to 0.026)

```matlab
%% the log in console of increasing guassian noise
Center1 at [400, 400], radius = 34
Center2 at [400, 400], radius = 35
checking puf REF1...............
the last matchingRate Difference is 100 !
Elapsed time is 16.771237 seconds.
Center1 at [400, 400], radius = 34
Center2 at [400, 400], radius = 35
checking puf REF1...............
the last matchingRate Difference is 100 !
Elapsed time is 16.656392 seconds.
Center1 at [400, 400], radius = 34
Center2 at [400, 400], radius = 35
checking puf REF1...............
the last matchingRate Difference is 100 !
Elapsed time is 16.600367 seconds.
Center1 at [400, 400], radius = 34
Center2 at [400, 400], radius = 35
checking puf REF1...............
the last matchingRate Difference is 100 !
Elapsed time is 16.799837 seconds.
Center1 at [400, 400], radius = 34
Center2 at [400, 400], radius = 35
checking puf REF1...............
the last matchingRate Difference is 100 !
Elapsed time is 16.447043 seconds.
Center1 at [400, 400], radius = 34
Center2 at [400, 400], radius = 35
checking puf REF1...............
the last matchingRate Difference is 100 !
Elapsed time is 16.497434 seconds.
Center1 at [400, 400], radius = 34
Center2 at [400, 400], radius = 35
checking puf REF1...............
the last matchingRate Difference is 100 !
Elapsed time is 16.445121 seconds.
Center1 at [400, 400], radius = 34
Center2 at [400, 400], radius = 35
checking puf REF1...............
the last matchingRate Difference is 100 !
Elapsed time is 16.828864 seconds.
Center1 at [400, 400], radius = 34
Center2 at [400, 400], radius = 35
checking puf REF1...............
the last matchingRate Difference is 100 !
Elapsed time is 16.267051 seconds.
Center1 at [400, 400], radius = 34
Center2 at [400, 400], radius = 35
checking puf REF1...............
the last matchingRate Difference is 100 !
Elapsed time is 16.629975 seconds.
Center1 at [400, 400], radius = 34
Center2 at [400, 400], radius = 35
checking puf REF1...............
the last matchingRate Difference is 100 !
Elapsed time is 16.448633 seconds.
Center1 at [400, 400], radius = 34
Center2 at [400, 400], radius = 35
checking puf REF1...............
the last matchingRate Difference is 100 !
Elapsed time is 16.559395 seconds.
Center1 at [400, 400], radius = 34
Center2 at [400, 400], radius = 35
checking puf REF1...............
the last matchingRate Difference is 100 !
Elapsed time is 16.403256 seconds.
Center1 at [400, 400], radius = 34
Center2 at [400, 400], radius = 35
checking puf REF1...............
the last matchingRate Difference is 100 !
Elapsed time is 16.692063 seconds.
Center1 at [400, 400], radius = 34
Center2 at [400, 400], radius = 35
checking puf REF1...............
the last matchingRate Difference is 100 !
Elapsed time is 16.383412 seconds.
Center1 at [400, 400], radius = 34
Center2 at [400, 400], radius = 35
checking puf REF1...............
the last matchingRate Difference is 100 !
Elapsed time is 16.599166 seconds.
Center1 at [400, 400], radius = 34
Center2 at [400, 400], radius = 35
checking puf REF1...............
the last matchingRate Difference is 100 !
Elapsed time is 16.405961 seconds.
Center1 at [400, 400], radius = 34
Center2 at [400, 400], radius = 35
checking puf REF1...............
the last matchingRate Difference is 100 !
Elapsed time is 16.646373 seconds.
Center1 at [400, 400], radius = 34
Center2 at [400, 400], radius = 35
checking puf REF1...............
the last matchingRate Difference is 100 !
Elapsed time is 16.370741 seconds.
Center1 at [400, 400], radius = 34
Center2 at [400, 400], radius = 35
checking puf REF1...............
the last matchingRate Difference is 100 !
Elapsed time is 17.105750 seconds.
Center1 at [400, 400], radius = 34
Center2 at [400, 400], radius = 35
checking puf REF1...............
the last matchingRate Difference is 100 !
Elapsed time is 16.684589 seconds.
Center1 at [400, 400], radius = 34
checking puf REF1...............
the last matchingRate Difference is 8.040000e+01 !
the last matchingRate Difference is 1.180000e+01 !
the last matchingRate Difference is 4.510000e+00 !
Elapsed time is 25.642068 seconds.
Center1 at [400, 400], radius = 34
Center2 at [400, 400], radius = 35
checking puf REF1...............
the last matchingRate Difference is 100 !
Elapsed time is 17.717544 seconds.
Center1 at [400, 400], radius = 34
Center2 at [400, 400], radius = 35
checking puf REF1...............
the last matchingRate Difference is 7.840000e+00 !
the last matchingRate Difference is 6.860000e+00 !
the last matchingRate Difference is 5 !
the last matchingRate Difference is 3.530000e+00 !
Elapsed time is 1056.143521 seconds.
Center1 at [400, 400], radius = 35
checking puf REF1...............
the last matchingRate Difference is 1.180000e+01 !
the last matchingRate Difference is 2.940000e+00 !
Elapsed time is 574.998961 seconds.
Center1 at [400, 400], radius = 34
checking puf REF1...............
the last matchingRate Difference is 1.760000e+01 !
the last matchingRate Difference is 1.960000e+00 !
Elapsed time is 819.106678 seconds.
```

![](C:/Users/zc95/Dropbox/notes/dendrite-PUF-research-notes/Users/zaoyichi/Dropbox/dendrite-puf-2019Spring/results/pufRef1_mR-vs-gaussian%20noise.jpg)

##### salt & pepper matching rate plot

![](C:/Users/zc95/Dropbox/notes/dendrite-PUF-research-notes/Users/zaoyichi/Dropbox/dendrite-puf-2019Spring/results/pufRef1_mR-vs-salt&pepper%20noise.jpg)



##Problem

1. ~~the output image is not the same scale as the original pixel image.~~

```matlab
I = data.pic;
imwrite(I, 'name.tif')
```



2. ~~cannot find the middle circle~~

   1. Imfindcircles method ==-----NOT WORKING-------==

      ```matlab
      imfindcircles(I, [rangeA rangeB]);
      ```

   2. Imfill method

   3. ```python
      imfill(I, 'holes');
      ```

   4. Hough Transformation  ==———WORKS————==

3. Not sure which distance is better

   1. the distance between the parents and that node
   2. the distance between each node and the middle circle

4. ~~the method findInitialDots has issue with rough image~~

5. ~~find some nodes have mutiple parents problem~~

   1. Really few condition, could be fixed by improving finding nodes method
   2. picRef5 index3 (354, 394),has two parents index8 index9 (356, 390)
   3. Finally, find the problem is that the ==Newpoints== structure does not initialize in the recursive loop.

6. ~~add de-noise method~~

   1. for now, just tried ==gaussian noise== and ==salt & pepper noise==
   2. And just use really simple denoise method

7. ~~Fix the problem of initial circle is not accurate in ==graph_based_Rd function==~~





# Work-Log_March-26-2019

### Problems

- How to make two actually similar picture, one is the denoised image, which lost some node details; other one is the reference image. but they are looks really similar from a person visual point.

- Add some scratches. Any method can denoise the scratches? does that change too much structure of tree.

- how is similarity of scratch noise

  



