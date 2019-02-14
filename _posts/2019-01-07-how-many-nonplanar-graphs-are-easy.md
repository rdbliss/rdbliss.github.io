---
title: When is a graph "obviously" nonplanar?
date: 2019-01-08
tags:
    - graph theory
---

There's a simple algebraic way to show that some graphs are nonplanar. If $G$
is a connected graph with $v$ vertices and $e$ edges, then it is nonplanar if
$e > 3(v - 2)$. If it is also triangle-free, then it is nonplanar if
$e > 2(v - 2)$. The first inequality shows that $K_5$ is nonplanar. The second
shows that the utility graph is nonplanar. These are, essentially, [the only
"simple" nonplanar
graphs](https://en.wikipedia.org/wiki/Kuratowski%27s_theorem). How many
nonplanar graphs can actually be detected with this inequality?

We may answer this question using the wonderful `geng` program, part of the
[`nauty`](http://users.cecs.anu.edu.au/~bdm/nauty/) distribution, which
generates graphs extremely quickly. I have written a short program which will
generate all connected graphs on a given number of vertices, pick out the
nonplanar ones, and see which fall to the above inequalities. This could tell
us roughly how surprised we should be when the simple inequalities work.

Let us call a nonplanar graph *detectable* if it satisfies $e > 3(v - 2)$, or
$e > 2(v - 2)$ if it is triangle-free. The following table summarizes how many
detectable graphs there are for $5 \leq v \leq 10$.

| Vertices | Connected nonplanar graphs | Detectable graphs | Proportion
| --------:|:---------------------------|:------------------|:-----------|
| 5        | 1                          | 1                 | 1.0
| 6        | 13                         | 5                 | 0.385
| 7        | 207                        | 42                | 0.203
| 8        | 5143                       | 849               | 0.165
| 9        | 189195                     | 37980             | 0.201
| 10       | 10663766                   | 3386986           | 0.318

The only nonplanar graph with $v = 5$---$K_5$---is detectable, but after this
examples are scarcer. Roughly 39% of the 13 nonplanar $v = 6$ graphs are
detectable, and only 20% of the 207 $v = 7$ graphs are detectable.  It would be
nice to continue this table to see if the proportion column tends to any
particular limit. However, this may be difficult.

The number of graphs with $v$ vertices grows *very* quickly. For $v = 6$ there
are only 112 of them, but by $v = 10$ there are 11,716,571 such non-isomorphic
graphs, or just under $12$ million.  The computer that I computed this table on
can run through about 2,000 graphs per second with $v = 10$. As expected, it
took about an hour-and-a-half. According to the
[OEIS](https://oeis.org/A001349), there are 1,006,700,565 connected graphs with
$v = 11$, or just over a billion.  Generously assuming that we could still
churn through 2,000 graphs a second, it would take about 139 hours to get an
answer for $v = 11$, or just under 6 days.

However, we can extend it in one nice way. There are not many triangle-free
graphs. Indeed, for $v = 11$, there are only 90,842 of them. We can crank
through this is no time at all! Here is an updated table, using only triangle
free graphs:

| Vertices | Triangle-free, connected nonplanar graphs | Detectable graphs | Proportion
| --------:|:---------------------------|:------------------|:-----------|
| 6        | 1                          | 1                 | 1.0
| 7        | 4                          | 2                 | 0.500
| 8        | 37                         | 15                | 0.405
| 9        | 317                        | 90                | 0.284
| 10       | 3671                       | 925               | 0.252
| 11       | 49838                      | 12472             | 0.250
| 12       | 831279                     | 242339            | 0.292
| 13       | 16806057                   | 6239486           | 0.371

This still isn't quite enough data to conclude anything.

# An answer!

I recently posted [this
question](https://math.stackexchange.com/questions/3066830) to the mathematics
stack exchange. Surprisingly, my gut feelings were completely wrong! Through
studying properties of random graphs, it turns out that we can say that "almost
all" (in a probabilistic / counting sense) graphs are "obviously nonplanar," in
the sense that they violate the inequality $e \leq 3(v - 2)$. In particular,
almost all graphs have average degree close to $n / 2$, while a graph with $e
\leq 3(v - 2)$ has average degree a bit less than $6$.

Astounding!
