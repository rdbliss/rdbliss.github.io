---
title: Gosper's algorithm discovers integral identity
date: 2019-03-01
tags:
    - summation
    - integration
---

While playing around with [Gosper's
algorithm](https://en.wikipedia.org/wiki/Gosper%27s_algorithm), I discovered
a very neat identity:

$$
\begin{equation}
\sum_{k = 0}^n\frac{\binom{2k}{k}}{4^k} = \frac{2n + 1}{\pi} \int_{-\infty}^\infty \frac{x^{2n}}{(x^2 + 1)^{n + 1}}\ dx.
\end{equation}
$$

I'd like to show how to derive it.

The identity is not as deep as it first seems. It actually comes from linking
two smaller identities together:

$$
\begin{align}
    \sum_{k = 0}^n \frac{\binom{2k}{k}}{4^k} &= \frac{2n + 1}{4^n} \binom{2n}{n} \\
    \int_{-\infty}^\infty \frac{x^{2n}}{(x^2 + 1)^{n + 1}}\ dx &= \frac{\pi}{4^n} \binom{2n}{n}.
\end{align}
$$

The first is entirely routine:

```python
In [1]: import sympy as sp
In [2]: from sympy.concrete.gosper import gosper_sum
In [3]: from sympy.abc import n, k

In [4]: gosper_sum(sp.binomial(2 * k, k) / 4**k, (k, 0, n))
Out[4]: 4**(-n)*(2*n + 1)*binomial(2*n, n)
```

Hooray for Gosper's algorithm!

The second identity is a little more challenging. Here's one way to prove it:
The generating function for the sequence

$$
I(n) = \int_{-\infty}^\infty \frac{x^{2n}}{(x^2 + 1)^{n + 1}}\ dx
$$

is

$$
\frac{\pi}{\sqrt{1 - x}}.
$$

(Exchange the sum and integral, evaluate the resulting geometric sum, then
rescale the remaining integral by $(1 - x)^{-1/2}$.) The generating function
for $\binom{2n}{n}$ is

$$
\frac{1}{\sqrt{1 - 4x}}.
$$

Therefore, doing some rescaling and equating of coefficients,

$$
\frac{\pi}{4^n} \binom{2n}{n} = \int_{-\infty}^\infty \frac{x^{2n}}{(x^2 + 1)^{n + 1}}\ dx.
$$

This gives us our identity!

## A better identity

Applying Gosper's algorithms to sums of the form $\sum_{k = 0}^n f(k)$ really
undersells its power. When Gosper's algorithm works, it gives much more.

Gosper's algorithm really tells us that

$$
\Delta \frac{2n + 1}{\pi} \int_{-\infty}^\infty \frac{x^{2n}}{(x^2 + 1)^{n + 1}}\ dx = \Delta \frac{2n + 1}{4^n} \binom{2n}{n} = \frac{\binom{2n}{n}}{4^n},
$$

which is a strictly better result.
