---
layout: archive
title: "Math Art"
permalink: /art/
redirect_from:
  - /art
---

{% include base_path %}

Below is a collection of pretty math images that I've created.

# Poisson cities

![Poisson city
skylines](/images/skyline-5.png)

I was trying to simulate the [Poisson
process](https://en.wikipedia.org/wiki/Poisson_point_process) but screwed it
up. The picture *should* look like a jagged, ascending staircase, but I forgot
to sum the results up, giving what looks like the skyline of a blocky city. I
thought this was cooler than whatever I was trying to do, so I played with my
mistake instead.

Also in [cyberpunk](https://github.com/dhaitz/mplcyberpunk)!

![Poisson city
skylines](/images/skyline_cyber.png)

# Stochastic predator-prey

![Stochastic predator-prey model](/images/comparison_phase.png)

This plot shows the difference between the ["classical" Lotka–Volterra
equations](https://en.wikipedia.org/wiki/Lotka%E2%80%93Volterra_equations) and
a stochastic version of them which adds some randomness. In the classical
version, predator and prey populations enter a stable equilibrium (the
oval-looking thing) and never leave it. The stochastic version lets them jump
around and do different things.

# Random redistricting

![Randomly drawn congressional map of Georgia](/images/final-sampled.png)

This is a randomly drawn congressional map of Georgia using
[GerryChain](https://github.com/mggg/GerryChain), a tool I helped create at the
[2018 Voting Rights Data Institute](https://sites.tufts.edu/vrdi/). I don't
think it solves [gerrymandering](https://en.wikipedia.org/wiki/Gerrymandering),
but it sure is pretty.

# Random number generation with C-finite sequences

![Pseudorandomly colored bars](/images/lfsr.png)

This is a visualization of five [linear feedback shift
registers](https://en.wikipedia.org/wiki/Linear-feedback_shift_register) mod 9,
which is a fancy way to say "some C-finite sequences evaluated mod 9." I don't
remember what the recurrences or initial conditions were, but it should be easy
to replicate this by just making some things up.

# Clustered roots

![Circle of 11th roots of -1 and roots of 11th degree trinomials](/images/rouche.png)

This is a drawing of the roots of $x^{11} + 1$---the 11th roots of -1---and the
trinomials $x^{11} - x^k + 1$ for $k = 1, 2, \dots, 10$. The diamonds are the
roots of $x^{11} + 1$, and the hexagons are the other roots. Notice that the
trinomial roots cluster around the roots of $-1$, and that they "orbit" around
them as they traverse the unit circle counterclockwise. This was really
surprising to me.
