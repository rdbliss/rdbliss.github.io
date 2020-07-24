---
title: A small binomial sum
---

I recently came across an interesting binomial sum in [this Math.SE
question](https://math.stackexchange.com/questions/3729998). As usual,
Zeilberger's algorithm makes short work of it, but the "human" approach reveals
a small miracle.

We want to evaluate

$$R_n(z) = \sum_k (-1)^k {2k \choose k} {k \choose n - k} z^k.$$

Our first step is to use the identity ${2k \choose k} = (-4)^k {-1/2 \choose
k}$ and write

$$R_n(z) = \sum_k {-1/2 \choose k} {k \choose n - k} (4z)^k.$$

There might be a nice, direct way to evaluate this sum, but I don't know it.
Instead, let's apply the *snake oil method*. Let $R(x) = \sum_{n \geq 0} R_n(z)
x^k$. By expanding $R_n(z)$ and interchanging the order of summation, it is
easy to show that

$$R(x) = \frac{1}{\sqrt{1 + 4zx(1 + x)}}.$$

The radicand in the denominator is a quadratic polynomial in $x$ with
discriminant $16z(z - 1)$. The square root disappears precisely when $z = 0$ or
$z = 1$! If $z = 0$ the sum is trivially $1$, and if $z = 1$ we get

$$R(x) = \frac{1}{1 + 2x},$$

so

$$R_n(1) = \sum_k 4^k {-1/2 \choose k} {k \choose n - k} = (-2)^n.$$

In other words, the sum given has a nice, exponential solution in *only* the
case the Math.SE question asked. Remarkable!

## Reflections

Zeilberger's produces a recurrence for $R_n(z)$ straight away. Running
`ZeilbergerRecurrence(f, n, k, R, 0..n) assuming n::posint` where $f$ is the
summand of $R_n(z)$ yields

$$
(n + 2) R_{n + 2}(z) + 2z(2n + 3) R_{n + 1}(z) + 4z(n + 1) R_n(z) = 0.
$$

So, in general, $R_n(z)$ is holonomic in $n$ and needs no more than three terms
in its defining recurrence. Of course, if $z = 1$, then `ZeilbergerRecurrence`
instead yields

$$F(n + 1) + 2 F(n) = 0,$$

so it sometimes simplifies. Maple fails to solve the general recurrence when
$z$ is symbolic.

If we were good enough with complex functions, then we could work out
asymptotics, but in any event this is another avenue to explore.
