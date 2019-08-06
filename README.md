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
There is a line in the
[best_fit_decreasing_combinations.rb](/best_fit_decreasing_combinations.rb)
file, where you can tweak these settings.  The concern is, since I leaned toward balancing
shipments over everything, a shipment that takes up a whole truck may never leave the dock :)
That, plus the over-fitting issue, when working with sample data, means that a different choice when sorting shipments may be less efficient overall, but work better against all datasets.

I read up a bit on this problem, and settled on the 'best fit, decreasing' algorithm.  It 
didn't pack as tightly as I wanted, so I added 'combinations' to it, so that I could pack
shipments two at a time, and create more discrete capacities.

## Running

Since this is a local gem, the best way to run it is to prepend `bundle exec`, and run it 
from the root directory of the gem.

Main algorithm:

`bundle exec ./best_fit_decreasing_combinations.rb`

Brute force:
`bundle exec ./brute_force.rb`

If you want to look at the various shipments produced by the brute force version, just 
insert `require 'byebug' ; byebug` at the end, and try it out :)

I created a 'brute force' solution, that generated a bunch of possible solutions, and then
did queries against that data set from the console, to see what the possibilities were.
Th


## Installation


1. Trucks
   * 