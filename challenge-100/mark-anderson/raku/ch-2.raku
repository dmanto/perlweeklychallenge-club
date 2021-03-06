#!/usr/bin/env raku

use Test;
plan 6;

is min-triangle-sum([<1>, <2 4>, <6 4 9>, <5 1 7 2>]),  8;
is min-triangle-sum([<3>, <3 1>, <5 2 3>, <4 3 1 3>]),  7;
is min-triangle-sum([<2>, <3 4>, <6 5 7>, <4 1 8 3>]), 11;  
is min-triangle-sum([<7>, <3 6>, <6 4 9>, <5 1 7 2>]), 15;
is min-triangle-sum([<2>, <5 4>, <5 5 7>, <1 4 8 3>]), 13;
is min-triangle-sum([
<55>,
<94 48>,
<95 30 96>,
<77 71 26 67>,
<97 13 76 38 45>,
< 7 36 79 16 37 68>,
<48  7  9 18 70 26  6>,
<18 72 79 46 59 79 29 90>,
<20 76 87 11 32  7  7 49 18>,
<27 83 58 35 71 11 25 57 29 85>,
<14 64 36 96 27 11 58 56 92 18 55>,
< 2 90  3 60 48 49 41 46 33 36 47 23>,
<92 50 48  2 36 59 42 79 72 20 82 77 42>,
<56 78 38 80 39 75  2 71 66 66  1  3 55 72>,
<44 25 67 84 71 67 11 61 40 57 58 89 40 56 36>,
<85 32 25 85 57 48 84 35 47 62 17  1  1 99 89 52>,
< 6 71 28 75 94 48 37 10 23 51  6 48 53 18 74 98 15>,
<27  2 92 23  8 71 76 84 15 52 92 63 81 10 44 10 69 93>]), 475;

sub min-triangle-sum(@triangle) 
{
    my @a = (flat roundrobin @triangle[1]<>, @triangle[0]<>).rotor(2 => -1);
    my ($head, $tail) = @a.shift.sum, @a.pop.sum;
    my @mid = map -> $a, $b { $a.sum min $b.sum }, @a;
    shift @triangle; 
    @triangle[0] = [$head, |@mid, $tail];
    min-triangle-sum(@triangle) if @triangle > 1;
    @triangle[0].min;
}
