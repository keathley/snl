# Snakes and Ladders

Everyone's favorite boardgame now lovingly translated to code and
statistically analyzed.

## Why did you do this?

Snakes and ladders has long been my "Hello, world" of choice for new
programming languages. Doing a statistical analysis of 10,000 games
provides an embaressingly parallel problem which is enough to get a taste
of the concurrency and flow control of the langauge.

## Rules

In case its been a while here are the basic rules of the game:

* the player starts at 0
* At the start of a turn the player rolls a die
* If a 6 is rolled another turn is taken
* If we land on a space in the mapping we transport to that space
* Otherwise we move the number of spaces indicated by the dice roll
* The game ends when we reach 100

The mappings are as follows:

```
1 => 38
4 => 14
9 => 31
16 => 6
21 => 42
28 => 84
36 => 44
47 => 26
49 => 11
51 => 67
56 => 53
62 => 19
64 => 60
71 => 91
80 => 100
87 => 24
93 => 73
95 => 75
98 => 78
```

## Language benchmarks

Run on an early 2015 macbook air with 8GB of 1600 MHz DDR3 memory and
a 2.2 GHz Intel Core i7 processor.

