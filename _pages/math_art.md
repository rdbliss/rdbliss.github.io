---
layout: archive
title: "Math Art"
permalink: /art/
redirect_from:
  - /art
---

{% include base_path %}

Below is a collection of pretty math images that I've created.

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
remember the recurrences or initial conditions, but it should be easy to
replicate this by just making some things up.

# Dyadically resolving graphs

![Dyadically resolving graph on 6th degree polynomials](/images/dyad-6-1.png)

This is a graph whose vertices are monic, integer-coefficient, degree
6 polynomials, with the edge $\{f, g\}$ if and only if the resultant of $f$ and
$g$ is a signed power of 2. It's a really amazing picture, and I don't know why
it looks like that.

# Clustered roots

![Circle of 11th roots of -1 and roots of 11th degree trinomials](/images/rouche.png)

This is a drawing of the roots of $x^{11} + 1$---the 11th roots of -1---and the
trinomials $x^{11} - x^k + 1$ for $k = 1, 2, \dots, 10$. The diamonds are the
roots of $x^{11} + 1$, and the hexagons are the other roots. Notice that the
trinomial roots cluster around the roots of $-1$, and that they "orbit" around
them as they traverse the unit circle counterclockwise. This was really
surprising to me.

# Poisson cities

![Poisson city
skylines](/images/skyline-5.png)

I was trying to simulate the [Poisson
process](https://en.wikipedia.org/wiki/Poisson_point_process) but screwed it
up. The picture *should* look like a jagged, ascending staircase, but I forgot
to sum the results up, giving what looks like the skyline of a blocky city. I
thought this was cooler than whatever I was trying to do.
