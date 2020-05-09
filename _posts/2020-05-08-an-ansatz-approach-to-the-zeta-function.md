---
title: An ansatz approach to the zeta function
---

The evaluation of Riemann's zeta function

$$\zeta(s) = \sum_{k \geq 1} \frac{1}{k^s}$$

at even integers is well-known, going back to the venerable Leonhard Euler and
his answer to the [Basel problem](https://en.wikipedia.org/wiki/Basel_problem),
namely

$$\zeta(2) = \frac{\pi^2}{6}.$$

The Basel problem stumped even the great Bernoulli's, and Euler's solution
required the ingenuity and insight found throughout his work. Nearly
three-hundred years later, is this easier to answer? I claim that not only is
it easy, but that it is *entirely routine* to both *guess* the answer and to
*prove* it, provided that you allow some basic Fourier analysis. Let's see how.

Given a suitably nice function $f$ on $[0, 1]$, we define its *Fourier
transform* by

$$\hat{f}(t) = \int_0^1 f(x) e^{-2\pi i t x}\ dx.$$

These are the coefficients of the Fourier series

$$\sum_k \hat{f}(k) e^{2\pi i k}.$$

There is a deep theory about what functions are suitably nice and what
properties the Fourier transform satisfies, but for now we are only interested
in one fact:

> The family $\\{e^{2\pi i n x}\\}_n = \\{e(n)\\}_n$ is an orthonormal basis for
the square-integrable functions on $[0, 1]$ equipped with the usual integral
inner product
>
>   $$(f, g) = \int_0^1 f \overline{g}.$$
>
> In particular,
>
> $$||f||_2 = \sum_k |(f, e(n))|^2 = \sum_k |\hat{f}(k)|^2.$$

In one direction, this tells us that sums whose terms are Fourier coefficients
can be evaluated as an integral. This is exactly what we will do.

First, we need a humanly-proved lemma (though in principle a computer could
likely figure this out).

**Lemma.** *The Fourier transform of $f_n(x) = x^n$ at integers satisfies
$\hat{f_n}(0) = (n + 1)^{-1}$, and $\hat{f}_n(k)$ is a polynomial in $(2\pi
i k)^{-1}$ of degree $n$ for all nonzero integers $k$.*

**Proof.** Apply integration by parts to prove that the sequence $\hat{f}_n(k)$
satisfies

$$\hat{f}_n(k) = n(2\pi i k)^{-1} \hat{f}_{n - 1}(k) - (2\pi i k)^{-1}.$$

The claim follows immediately by induction once we note that $\hat{f}_0(k)
= 0$. $\blacksquare$

At this point we are in possession of a very powerful *ansatz*. The Fourier
transform of polynomials at integers gives us reciprocals of powers of
integers! There must be a connection with the zeta function. In particular, we
want to find a polynomial

$$f(x) = \sum_{k = 0}^n a_k x^k$$

such that $\hat{f}(k)$ is some multiple of $k^{-n}$ times a factor independent
of $k$. Given the lemma above, we know that $\hat{f}(k)$, for nonzero $k$, is
a polynomial in $(2\pi i)^{-1}$, meaning that we can look at their coefficients
and require ones smaller than $(2\pi i)^{-n}$ to vanish. We can stipulate that
$a_n = -1$ and that $\hat{f}(0) = 0$, which gives us a total of $n + 1$ linear
equations in $n + 1$ unknowns, which we can (probably) solve!

So, in light of this, it suffices to write a program that will equate these
coefficients and solve the resulting linear equations. This will then, *a
posteriori*, provide evaluations of $\zeta(n)$ for positive, even integers $n$.
(Only the evens since, of course, we must take squares.)

# The program

Here is one such program that will do the job.

```python
import sympy as sp
from sympy.abc import x, t
from sympy import I, pi

def zeta_ansatz(n):
    xs = sp.symbols("a:{}".format(n + 1))
    f = sum(xs[k] * x**k for k in range(n + 1))

    k = sp.symbols("k", integer=True, zero=False)
    ft = sp.integrate(f * sp.exp(-2 * pi * I * k * x), (x, 0, 1))
    ft = ft.simplify().expand()
    # Replace 2 pi I with a dummy variable 1 / t to grab coefficients.
    ft = ft.subs(k, 1).subs(I, 1).subs(pi, 1 / t)

    coeffs = ft.collect(t, evaluate=False)
    print(coeffs)
    zero_eqns = [coeff for key, coeff in coeffs.items() if key != t**n]
    eqns = zero_eqns + [xs[-1] + 1, sum(x / (k + 1) for k, x in enumerate(xs))]
    soln = sp.solve(eqns, xs)
    print(zero_eqns)
    print(soln)

    f = sum(soln[xs[k]] * x**k for k in range(n + 1))

    coeff = sp.factorial(n) / (2 * pi)**n

    return f, sp.integrate(abs(f)**2, (x, 0, 1)) / coeff**2 / 2
```

An example:

```python
In [1]: time [zeta_ansatz(k) for k in range(1, 5)]
CPU times: user 1.85 s, sys: 19 µs, total: 1.85 s
Wall time: 1.85 s
Out[1]: 
⎡⎛          2⎞  ⎛               4⎞  ⎛          2        6⎞  ⎛                         8 ⎞⎤
⎢⎜         π ⎟  ⎜   2       1  π ⎟  ⎜   3   3⋅x    x   π ⎟  ⎜   4      3    2   1    π  ⎟⎥
⎢⎜1/2 - x, ──⎟, ⎜- x  + x - ─, ──⎟, ⎜- x  + ──── - ─, ───⎟, ⎜- x  + 2⋅x  - x  + ──, ────⎟⎥
⎣⎝         6 ⎠  ⎝           6  90⎠  ⎝        2     2  945⎠  ⎝                   30  9450⎠⎦
```

So there, we have answered the Basel problem plus evaluated the next three
terms of the sequence $\zeta(2n)$, all in under two seconds and without any
foreknowledge of the answer. Not too shabby, eh, Euler?

# Connections to known results

These results are obviously not new. There are known closed-form evaluations of
$\zeta(2n)$ for all positive integers $n$. A cursory glance suggests that the
polynomials we get are exactly the negatives of the [Bernoulli
polynomials](https://en.wikipedia.org/wiki/Bernoulli_polynomials#Representations)
$B_n(x)$, and mentioned in that article is that the Fourier transform of
$B_n(x)$ is

$$\hat{B}_n(x) = -\frac{n!}{(2\pi i)^n} \sum_{k \neq 0} \frac{e^{2\pi i k x}}{k^n},$$

which matches exactly what we have said here.

Does this idea uniquely define the Bernoulli polynomials? The Fourier transform
is invertible, so saying "let $B_n(x)$ be the preimage of such and such
function under the Fourier transform on $[0, 1]$" is a fine definition. It is
surprising that such a thing is a *polynomial*, but nevertheless true, and
lucky for us that it was. Conversely, I am pretty sure that polynomials will
only ever give you linear combinations of the $\zeta$ function evaluated at
even integers, so we have completely exhausted the usefulness of polynomials
coupled with Fourier transforms.
