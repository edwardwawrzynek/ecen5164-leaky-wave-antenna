clear; close all;

filename = 'test.s2p'; %input s2p file name
S = sparameters(filename);

s11 = rfparam(S, 1, 1);
s12 = rfparam(S, 1, 2);
s21 = rfparam(S, 2, 1);
s22 = rfparam(S, 2, 2);

freq = S.Frequencies;

