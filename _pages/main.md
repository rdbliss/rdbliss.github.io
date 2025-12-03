---
permalink: /
title: "Welcome!"
author_profile: true
---

I am an instructor of applied and computational mathematics at Dartmouth
College. My research focuses on applying symbolic and numeric computation to
problems in combinatorics or number theory. I'm always interested in finding
new mathematical applications of computers.

My expository work has appeared in the *American Mathematical Monthly*
([here](https://www.tandfonline.com/doi/full/10.1080/00029890.2022.2104069) and
[here](https://www.tandfonline.com/doi/abs/10.1080/00029890.2025.2555161)), an
article of mine on primality testing was written about in [*Pour la
Science*](https://www.pourlascience.fr/sr/logique-calcul/des-nombres-premiers-aux-pseudo-premiers-26266.php),
and two of my articles were cited in
[*Nature*](https://www.nature.com/articles/s41586-021-03229-4) and the
[*Proceedings of the National Academy of
Sciences*](https://www.pnas.org/doi/pdf/10.1073/pnas.2321440121).

The rest of this site contains some information about me, my work, and a blog
where I post ideas. Some of the ideas are even good!

My CV is [here](/files/cv.pdf).

I was [born in the year](https://www.mrob.com/pub/ries/index.html) $\lfloor
\pi^6 / \log \varphi \rfloor$, which makes me *perfectly* 1 + 2 + 4 + 7 + 14
years old.

## Upcoming events

I'm co-organizing two sessions at the MAA's 2026 MathFest: *Computers and
Combinatorics* and *Combinatorics and Probability*. More info soon!

## Recent / current projects

### Speeding up CRT

You can break up big integer computations with the Chinese Remainder Theorem.
In some problems, the reduction / reconstruction steps of CRT make up
a significant part of the computational cost, and you can reduce this cost by
choosing "custom" moduli. I recently studied moduli of the form $2^n - 2^k + 1$,
which leads to thinking about resultants of the trinomials $x^n - x^k + 1$ and
when they are divisible by different primes. There is still a lot to learn
about these trinomials and similar families.
([paper](https://arxiv.org/abs/2508.11043))

In some ways, the paper is really about graphs that look like this: ![n = 100
trinomial graph](/images/G-100.svg)

### Balanced Matrices

How many 0-1 matrices are there of size $2n \times 2k$ with as many 0's as 1's
in each row and column? This turns out to be hard to answer for anything other
than $k = 1$, but for fixed $k$ the number always satisfies a "nice"
recurrence. I showed that $a(n) = B(n, 3)$, the number of $2n \times 6$ such
matrices, satisfies this recurrence:

![balanced matrices recurrence](/images/Bn3.png)

It seems very difficult to compute the recurrence for $B(n, 4)$ and higher.
([paper](https://arxiv.org/abs/2410.07435))

### Comma sequences

The [comma sequence](https://oeis.org/A121805) is a funny integer sequence
where the difference of consecutive terms equals the concatenation of the
digits on either side of the comma separating them. This sequence has 2,137,453
terms, then terminates at 99999946. I proved that all comma sequences (with any
initial conditions) terminate in bases 3 through 633. The big conjecture is
that *all* comma sequences terminate.
([paper](https://arxiv.org/abs/2408.03434))
