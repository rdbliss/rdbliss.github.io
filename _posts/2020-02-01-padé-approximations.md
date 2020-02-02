---
title: "Padé approximations and EKHAD: A lab journal"
date: 2020-02-02
---

Inspired by a section in [Zeilberger's](https://sites.math.rutgers.edu/~zeilberg/) "COMPUTERIZED
DECONSTRUCTION" ([Z]), I have written a small Padé approximator in Python. Here
I will attempt to experimentally discover the Padé approximation of $(1 - 4x)^{-1/2}$.

An $(m, n)$th *Padé approximant* is a rational function $P_{n, m}(x) / Q_{n,
m}(x)$ such that

$$
\begin{align*}
    P_n(x) &= \sum_{k = 0}^n a(n, n - k) x^k \\
    Q_n(x) &= \sum_{k = 0}^n b(n, n - k) x^k,
\end{align*}
$$

and

$$f(x) - \frac{P_{n, m}(x)}{Q_{n, m}(x)} = O(x^{2n + 1}).$$

These are like "rational Taylor polynomials." Here, we take $a(n, 0) = 1$.

***Highlights:***

- The sequences $a(n, k)$ and $b(n, k)$ are uniquely determined.

- $a(n, k) = (-1)^k {n + k \choose 2k}$.

- $b(n, k) = (-1)^k {n + k \choose 2k} \frac{2n + 1}{2k + 1}$.

- This is *rigorously established* by (automatically!) proving the identity

$$
    \sum_k {n + k \choose 2k} {2(m - n + k) \choose m - n + k}
                            \frac{(-1)^k}{2k + 1}
    =
    \frac{(-1)^{n - m}}{2n + 1} {2n - m \choose 2(n - m)}.
$$

I have written the rest of this like an informal "lab journal" with little *ex
post facto* cleaning.

# First steps

Here's the full listing:

```python
import sympy as sp

def pade(f, x, n, m, leading_numer=1):
    a = sp.symbols("a:{}".format(n + 1))
    b = sp.symbols("b:{}".format(m + 1))
    P = sum(a[k] * x**k for k in range(n + 1)).subs(a[-1], leading_numer)
    Q = sum(b[k] * x**k for k in range(m + 1))

    expansion = sp.series(f * Q - P, x, n=n + m + 1)
    eqns = [expansion.coeff(x, k) for k in range(n + m + 1)]
    soln = sp.solve(eqns)

    return (P / Q).subs(soln)

def diagonal_pade(f, x, n, *args, **kwargs):
    return pade(f, x, n, n, *args, **kwargs)
```

And here's an example run:

```python
In [1]: run pade

In [2]: diagonal_pade(exp(x), x, 1)
Out[2]: 
x + 2
─────
2 - x

In [3]: diagonal_pade(exp(x), x, 2)
Out[3]: 
 2           
x  + 6⋅x + 12
─────────────
 2           
x  - 6⋅x + 12

In [4]: diagonal_pade(exp(x), x, 3)
Out[4]: 
  3       2              
 x  + 12⋅x  + 60⋅x + 120 
─────────────────────────
   3       2             
- x  + 12⋅x  - 60⋅x + 120

In [5]: diagonal_pade(exp(x), x, 4)
Out[5]: 
 4       3        2               
x  + 20⋅x  + 180⋅x  + 840⋅x + 1680
──────────────────────────────────
 4       3        2               
x  - 20⋅x  + 180⋅x  - 840⋅x + 1680
```

These results agree with [Z].

Let's look at some diagonal Padé approximants for $(1-4x)^{-1 / 2}$:

```python
In [2]: diagonal_pade(1 / sqrt(1 - 4 * x), x, 1)
Out[2]: 
 x - 1 
───────
3⋅x - 1

In [3]: diagonal_pade(1 / sqrt(1 - 4 * x), x, 2)
Out[3]: 
  2           
 x  - 3⋅x + 1 
──────────────
   2          
5⋅x  - 5⋅x + 1

In [4]: diagonal_pade(1 / sqrt(1 - 4 * x), x, 3)
Out[4]: 
  3      2            
 x  - 6⋅x  + 5⋅x - 1  
──────────────────────
   3       2          
7⋅x  - 14⋅x  + 7⋅x - 1

In [5]: diagonal_pade(1 / sqrt(1 - 4 * x), x, 4)
Out[5]: 
  4       3       2           
 x  - 10⋅x  + 15⋅x  - 7⋅x + 1 
──────────────────────────────
   4       3       2          
9⋅x  - 30⋅x  + 27⋅x  - 9⋅x + 1
```

The involved polynomials look like they have nice integer coefficients. Let's
investigate them.

```python
In [6]: a = lambda n, m: numer(diagonal_pade(1 / sqrt(1 - 4 * x), x, n)).coeff(x, n - m)

In [7]: # a(n, m) is the coefficient on x^{n - m} in the numerator of the nth diagonal Pade approximant.

# ...

In [13]: [a(k, 1) for k in range(1, 10)]
Out[13]: [-1, -3, -6, -10, -15, -21, -28, -36, -45]

In [14]: [abs(a(k, 1)) for k in range(1, 10)]
Out[14]: [1, 3, 6, 10, 15, 21, 28, 36, 45]
```

This last sequence has a linear difference. It looks like $\Delta a(n, 1)
= 2 + n$, which means that $a(n, 1)$ is probably some quadratic function. In
fact, it's easy to see that these are just triangular numbers. These can be
written ${n \choose 2}$, and we should remember that for the next sequence.

```python
In [15]: [abs(a(k, 2)) for k in range(1, 10)]
Out[15]: [0, 1, 5, 15, 35, 70, 126, 210, 330]

In [16]: import numpy as np

In [17]: seq = [abs(a(k, 2)) for k in range(1, 10)]

In [18]: np.diff(seq)
Out[18]: array([1, 4, 10, 20, 35, 56, 84, 120], dtype=object)

In [19]: np.diff(seq, 2)
Out[19]: array([3, 6, 10, 15, 21, 28, 36], dtype=object)

In [20]: np.diff(seq, 3)
Out[20]: array([3, 4, 5, 6, 7, 8], dtype=object)

In [21]: np.diff(seq, 4)
Out[21]: array([1, 1, 1, 1, 1], dtype=object)
```

These don't look *as* straightforward, but iterated differences tell us that
these coefficients probably come from a quartic polynomial. Based on the last
guess, I would say it's ${n + 3 \choose 4}$, and that looks right.

There seems to be a *meta-pattern* developing. Let's see one more to get the
feel for what it should be.

```python
In [48]: [abs(a(k, 3)) for k in range(1, 10)]
Out[48]: [0, 0, 1, 7, 28, 84, 210, 462, 924]

# ...

In [55]: [binomial(k + 4, 6) for k in range(9)]
Out[55]: [0, 0, 1, 7, 28, 84, 210, 462, 924, 1716]
```

We have enough to hazard a first guess. The function $a(n, k)$ is *something*
like ${n + k + 1 \choose 2k}$, but we need to get the details right.

# Getting the details right

Getting the details right is an important skill. Until you can teach a computer
to do it automatically, it pays to practice catching all the nasty mistakes you
can make while staring at sequences.

I started with `guess(n, k) = binomial(n + k + 1, 2k)`. This is definitely
wrong. First of all, $a(n, k)$ is sometimes negative. Oops. I forgot that
I took absolute values at some point. I suspect that the signs alternate in
$k$, so I can just multiply by $(-1)^k$ at the end to fix that.

The formula is off some other way as well. For example, `guess(4, 2) = 35`
while `a(4, 2) = 15`. But `guess(3, 2) = 15`, so maybe we're just off by one in
$n$. Looking back at the list-comprehension I used to create the binomial
coefficients, I think I am. So let's say `guess(n, k) = binomial(n + k, 2k)`.

Picking a value at random, we have `a(10, 3) = -1716` and `guess(10, 3)
= 1716`. Good! And it looks like the signs do alternate in $k$, so maybe we
actually have `guess(n, k) = (-1)^k * binomial(n + k, 2k)`.

Here's a quick verification that we might be right:

```python
In [117]: guess = lambda n, k: (-1)**k * binomial(n + k, 2 * k)

In [118]: from itertools import product

# ...

In [123]: [guess(n, k) - a(n, k) for n, k in product(range(10), repeat=2) if n >= k]
Out[123]: 
[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
```

Looks good! So we now conjecture that

$$a(n, k) = (-1)^k {n + k \choose 2k}.$$

# The denominator

It feels like the denominator should be easier now that we know the numerator,
but that isn't exactly the case. The coefficients here aren't *just* binomial
coefficients.

Here is a helper functions to make meta-guessing easier:

```python
# I am using the `fit_poly()` functions described here:
#   https://groups.google.com/forum/m/#!msg/sympy/twjvFft6i3w/tkYMq6oM20QJ

def guess_denom_poly(k, deg, n_terms=10):
    def b(n, k):
        return sp.denom(diagonal_pade(1 / sqrt(1 - 4 * x), x, n)).coeff(x, n - k)

    bs = [b(j, k) for j in range(k, n_terms + k)]
    print([abs(t) for t in bs])

    return fit_poly(list(range(k, n_terms + k)), bs, n, degree=deg)[0].factor()
```

I suspect that $b(n, k)$ is again a polynomial in $n$ for each fixed $k$, hence
all the stuff above about fitting and polynomials.

Let's see some examples:

```python
# This is the coefficient on x^{n - 3} in the denominator of order n.
In [214]: guess_denom_poly(3, 7)
[1, 9, 44, 156, 450, 1122, 2508, 5148, 9867, 17875]
Out[214]:
-(n + 1)⋅(n + 2)⋅(n + 3)⋅(n + 4)⋅(n + 5)⋅(n + 6)⋅(2⋅n + 7)
───────────────────────────────────────────────────────────
                            5040

# This is the coefficient on x^{n - 2} in the denominator of order n.
In [215]: guess_denom_poly(2, 5)
[1, 7, 27, 77, 182, 378, 714, 1254, 2079, 3289]
Out[215]:
(n + 1)⋅(n + 2)⋅(n + 3)⋅(n + 4)⋅(2⋅n + 5)
─────────────────────────────────────────
                   120

# This is the coefficient on x^{n - 1} in the denominator of order n.
In [216]: guess_denom_poly(1, 3)
[1, 5, 14, 30, 55, 91, 140, 204, 285, 385]
Out[216]:
-(n + 1)⋅(n + 2)⋅(2⋅n + 3)
───────────────────────────
             6
```

These might look intimidating, but closer inspection reveals that we probably
have `b(n, k) = binomial(n + 2k, 2k) * (2n + 2k + 1)`.

The devil's in the details, though, and this ain't quite right. We fit these
polynomials using values which started from $k$, so we probably need to shift
$n$ back by $k$. Maybe `guess2(n, k) = binomial(n + k, 2k) * (2n + 1)`?

I changed a line in the program to make sure that everything is starting at the
same point, and now I get some more sensible results. For example:

```python
In [281]: guess_denom_poly(1, 3)
[1, 5, 14, 30, 55, 91, 140, 204, 285, 385]
Out[281]: 
-n⋅(n + 1)⋅(2⋅n + 1) 
─────────────────────
          6          

In [282]: guess_denom_poly(2, 5)
[1, 7, 27, 77, 182, 378, 714, 1254, 2079, 3289]
Out[282]: 
n⋅(n - 1)⋅(n + 1)⋅(n + 2)⋅(2⋅n + 1)
───────────────────────────────────
                120                

In [283]: guess_denom_poly(4, 9)
[1, 11, 65, 275, 935, 2717, 7007, 16445, 35750, 72930]
Out[283]: 
n⋅(n - 3)⋅(n - 2)⋅(n - 1)⋅(n + 1)⋅(n + 2)⋅(n + 3)⋅(n + 4)⋅(2⋅n + 1)
───────────────────────────────────────────────────────────────────
                               362880                              

```

Looking at the $k = 4$ case very hard, I notice that the denominator is `(2
* 4 + 1)!`, not `(2 * 4)!`. That means that we should probably have `guess2(n,
k) = binomial(n + k, 2k) * (2n + 1) / (2k + 1)`. This seems to work!

All that's left is to note that `b(n, k)` alternates in `k`, so we probably
have

$$b(n, k) = (-1)^k {n + k \choose 2k} \frac{2n + 1}{2k + 1}.$$

# Putting it all together

We have some conjectures for the coefficients on our approximants. Let's see if
they work.

The equation that we're using for Padé approximants is

$$f(x) Q_n(x) - P_n(x) = O(x^{2n + 1}),$$

where, in our notation,

$$
\begin{align*}
    P_n(x) &= \sum_{k = 0}^n a(n, n - k) x^k \\
    Q_n(x) &= \sum_{k = 0}^n b(n, n - k) x^k.
\end{align*}
$$

Thus the coefficients of $f(x) Q_n(x)$ with $f(x) = (1 - 4x)^{-1/2}$ are
(conjectured to be)

$$
\begin{align*}
    [x^m] f(x) Q_n(x) &= \sum_{k = 0}^m b(n, n - k) {2(m - k) \choose m - k} \\
                      &= \sum_{0 \leq k \leq \min(n, m)} (-1)^{n - k} {2n - k \choose 2(n - k)} \frac{2n + 1}{2(n - k) + 1} {2(m - k) \choose m - k}.
\end{align*}
$$

I put bounds on the final sum since $b(n, n - k) = 0$ if $k > n$ or $k < 0$.
But the conjectured expression does this as well, and the only part of the sum
involving $m$ vanishes with $k > m$ and $k < 0$, so we can just drop the
bounds. Thus we have (conjectured that)

$$
    [x^m] f(x) Q_n(x) = \sum_k (-1)^{n - k} {2n - k \choose 2(n - k)} \frac{2n + 1}{2(n - k) + 1} {2(m - k) \choose m - k}.
$$

The coefficient on $x^m$ in $P_n(x)$ is just $a(n, n - m)$. Our conjectures
hinge on the mighty identity

$$
    \sum_k {2n - k \choose 2(n - k)} {2(m - k) \choose m - k}
                            \frac{(-1)^k}{2(n - k) + 1}
    =
    \frac{(-1)^m}{2n + 1} {2n - m \choose 2(n - m)}.
$$

If we clean this up, then it reads

$$
    \sum_k {n + k \choose 2k} {2(m - n + k) \choose m - n + k}
                            \frac{(-1)^k}{2k + 1}
    =
    \frac{(-1)^{n - m}}{2n + 1} {2n - m \choose 2(n - m)}.
$$

After looking at some special cases and consulting *Concrete Mathematics*,
I decided that this wasn't an identity I had seen before. Luckily, it is
*entirely routine* to prove thanks to [Wilf–Zeilberger
theory](https://www.math.upenn.edu/~wilf/AeqB.html). The *venerable* package
[EKHAD] can check this for us. The certificate function is

$$
-{\frac { \left( 2\,k+1 \right)  \left( m-n+k \right) k \left( 4\,mk-6\,nk+4\,{m}^{2}-12\,mn+
10\,{n}^{2}-5\,k-10\,m+17\,n+7 \right) }{ \left( -n-1+k \right)  \left( 2\,m-2\,n-1+2\,k
 \right)  \left( 2\,n+1 \right)  \left( -2\,n-1+m \right)  \left( -2\,n-2+m \right) }}
$$

Marvelous.

So, we now have formulas for arbitrary diagonal Padé approximants of $(1 - 4x)^{-1 / 2}$.
I don't think that this is of great practical importance, but it is pretty
cool.

[Z]: https://sites.math.rutgers.edu/~zeilberg/mamarim/mamarimhtml/derrida.html

[EKHAD]: https://sites.math.rutgers.edu/~zeilberg/programsAB.html
