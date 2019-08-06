# LtlPacker, code example

## Problem Description

Given 4 trucks each with available capacity, write an algorithm to distribute shipments as evenly as possible, trying to ship all goods and minimize wasted space.

## Summary

For this exercise, I tried a couple of different things.  I have to say, I enjoyed it quite
a bit.  This is exactly the sort of thing I like to work on.

I chose to initialize this project as a gem, and went on from there, so that it would look
a little more professional, but honestly, the solution I settled on could probably fit in 
less than 20 lines of code, just using some raw hashes.

The final result prioritizes maximizing the total capacity ships, along with an
even distribution of loads.  I de-prioritized maximizing the shipment total count.
There is a line in the [link](/best_fit_decreasing_combinations.rb)

I created a 'brute force' solution, that generated a bunch of possible solutions, and then
did queries against that data set from the console, to see what the possibilities were.
Th


## Installation


1. Trucks
   * 