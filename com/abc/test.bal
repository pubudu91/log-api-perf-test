package com.abc;

import ballerina.utils.logger;
import ballerina.lang.system;
import ballerina.lang.errors;
import ballerina.lang.time;
import xyz.pubudu.stat;

function main (string[] args) {
    errors:Error err = {msg:"Test Error"};

    int i = 10;
    //int j = 0;

    //runTest(20);
    //runTest(30);
    //runTest(40);

    while (i < 101) {
        runTest(i);
        i = i + 10;
    }

    //i=1;
    //while (i < 10) {
    //    runTest(i * 100);
    //    i = i + 1;
    //}
    //while (i <= 10) {
    //    j = 0;
    //    time:Time start = time:currentTime();
    //    while (j < i * 10) {
    //        //xyz:logTest();
    //        logger:info("Inside package 'com.abc'");
    //        j = j + 1;
    //    }
    //    time:Time end = time:currentTime();
    //    system:println("i:" + i + ", j:" + j + ", avg: " + ((<float>(end.time - start.time)) / j));
    //    i = i + 1;
    //}
    //
    //i = 1;
    //while (i <= 10) {
    //    j = 0;
    //    time:Time start = time:currentTime();
    //    while(j < i*100) {
    //        //xyz:logTest();
    //        logger:info("Inside package 'com.abc'");
    //        j = j+1;
    //    }
    //    time:Time end = time:currentTime();
    //    system:println("i:" + i + ", j:" + j + ", avg: " + ((<float>(end.time - start.time))/j));
    //    i = i + 1;
    //}
}

function runTest (int n) {
    int s = getSampleSize(n);
    float avg = getAvgLogTime(s, n);

    system:println("n: " + n + ", " + "sample size: " + s + ", avg. (ms): " + avg);
}

function getAvgLogTime (int s, int n) (float) {
    int i = 0;
    float[] times = [];

    while (i < s) {
        times[i], _ = doLog(n);
        i = i + 1;
    }

    float mean = stat:average(times);
    return mean;
}

function getSampleSize (int n) (int) {
    float mean;
    float std;

    mean, std = doLog(n);

    int s = <int>stat:sampleSize(std, mean);

    if(s>100) {
        return 100;
    } else {
        return s;
    }
}

function doLog (int n) (float, float) {
    int i = 0;
    float[] time = [];

    while (i < n) {
        time:Time start = time:currentTime();
        logger:info("Inside package 'com.abc'");
        time:Time end = time:currentTime();
        time[i] = <float>(end.time - start.time);
        i = i + 1;
    }

    //system:println(time);
    float mean = stat:average(time);
    float std = stat:stdDeviation(time);

    return mean, std;
}