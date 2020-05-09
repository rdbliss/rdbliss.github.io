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

Someday I would like to make an endless animation of this.

Now in [cyberpunk](https://github.com/dhaitz/mplcyberpunk)!

![Poisson city
skylines](/images/skyline_cyber.png)

# Stochastic predator-prey

![Stochastic predator-prey model](/images/comparison_phase.png)

This plot shows the difference between the ["classical" Lotka–Volterra
equations](https://en.wikipedia.org/wiki/Lotka%E2%80%93Volterra_equations) and
a stochastic version of them which adds some randomness. In the classical
version, predator and prey populations enter a stable equilibrium (the
oval-looking thing) and never leave it. The stochastic version lets you jump
around more, and looks much more interesting.

# Random redistricting

![Randomly drawn congressional map of Georgia](/images/final-sampled.png)

This is a randomly drawn congressional map of Georgia using
[GerryChain](https://github.com/mggg/GerryChain), a tool I helped create at the
[2018 Voting Rights Data Institute](https://sites.tufts.edu/vrdi/). I don't
think it solves [gerrymandering](https://en.wikipedia.org/wiki/Gerrymandering),
but it sure is pretty.
