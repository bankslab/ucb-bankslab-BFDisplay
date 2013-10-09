function [output] = ShiftDiopters(input,shift)
% Input and output are in meters, shift is in diopters

output = 1/(1/input + shift);