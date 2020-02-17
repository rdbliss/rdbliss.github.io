---
title: Padé approximants again
date: 2020-02-15
---

An $(n, m)$th *Padé approximant* for a generating function $f(x)$ is a pair of
polynomials $(P_{n, m}(x), Q_{n, m}(x))$ such that $P_{n, m}(x)$ and $Q_{n,
m}(x)$ have degrees not exceeding $n$ and $m$, respectively, and

$$
\begin{equation}
    \label{pade}
    \tag{Padé}
    f(x) Q_{n, m}(x) - P_{n, m}(x) = O(x^{n + m + 1}),
\end{equation}
$$

where $O(x^k)$ stands for any generating function which is zero before the
$k$th term (and possibly later).

Given $n$ and $m$, we write the polynomials $P_{n, m}(x)$ and $Q_{n, m}(x)$
explicitly as

$$
\begin{align*}
    P_{n, m}(x) &= \sum_{k = 0}^n a(n, m, k) x^k \\
    Q_{n, m}(x) &= \sum_{k = 0}^m b(n, m, k) x^k.
\end{align*}
$$

We assume that $a(n, m, k) = 0$ if $k > n$ or $k < 0$, and that $b(n, m, k)
= 0$ if $k < 0$ or $k > m$. Such coefficients are guaranteed to exist and, for
a fixed $f(x)$, are unique up to a constant multiple[^pade-ref]. It is common
to take $b(n, m, 0) = 1$ just so there is a fixed starting point.

[^pade-ref]: See Chapter 20 of Wall's *Analytic Theory of Continued Fractions*.

In a [previous post](/pad%C3%A9-approximations/) I derived a closed form for
Padé approximants of the function $(1 - 4x)^{-1/2}$. Here, I want to show that
we can generalize this by choosing an arbitrary exponent.

***Highlights:***

- The Padé approximants of the function $f(x) = (1 + tx)^c$ are uniquely
  determined up to a constant multiple[^constant]. Choosing the constant to be
  $1$, the coefficients are as follows:

[^constant]: If you rush off to check these with [PADE] or something similar,
             be aware that normalizing the computed Padé coefficients (e.g.,
             cancelling denominators or something like that) will produce
             different constants for each $(n, m)$ pair. For [PADE] in
             particular, I believe that the constant is $(n + m)! / \min(n,
             m)!$.

$$
\begin{align*}
    a(n, m, k) &= t^k {n \choose k} {m + c \choose k} {n + m \choose k}^{-1} \\
    b(n, m, k) &= t^k {m \choose k} {n - c \choose k} {n + m \choose k}^{-1}.
\end{align*}
$$

- This is proven by establishing (automatically!) the identity

$$
    \sum_{j = 0}^k
    {m \choose j} {n - c \choose j} {c \choose k - j} {n + m \choose j}^{-1}
    = {n \choose k} {m + c \choose k} {n + m \choose k}^{-1}.
$$

***Differences between previous post and this one:***

- In my last post, I considered only diagonal approximants. Also, I defined
  $a(n, k)$ to be the coefficient on $x^{n - k}$ rather than $x^k$. This seemed
  useful at the time, but [Dr. Z](Z) has shown me the error of my ways.

- My last post tried to simplify the coefficients by taking $a(n, 0) = 1$. The
  *smart* thing is to realize that it doesn't really matter.

More on these two points later. For now, let's get to the good stuff.

# Padé approximants in detail

From an analytic perspective, the point of a Padé approximant as defined in
\eqref{pade} is that the power series of the rational function $P_{n, m}(x)
/ Q_{n, m}(x)$ and $f(x)$ ought to agree for the first $n + m$ terms. The form
in \eqref{pade} is slightly more general, and suggests how to actual compute
the coefficients.

Looking at the coefficient on $x^k$ for $0 \leq k \leq n + m$ in \eqref{pade}
shows that necessary and sufficient conditions to be the coefficients of a Padé
approximant are

$$
\begin{equation}
    \label{convolution}
    \sum_j b(n, m, j) c(k - j) = a(n, m, k), \qquad 0 \leq k \leq n + m,
\end{equation}
$$

and the boundary conditions on $a(n, m, k)$ and $b(n, m, k)$. (These are
implicitly assumed in the sum since it ranges over *all* integers $j$.)

The boundary conditions ensure that the coefficients are unique and that we
don't need to go beyond the degrees $n$ and $m$ for our polynomials. For
example, lots of sequences satisfy \eqref{convolution}. In fact, for any fixed
$b(n, m, k)$ and $c(k)$, we could just *define* $a(n, m, k)$ by
\eqref{convolution}. (Equivalently, just pick a generating function $Q(x)$ and
define another one called $P(x) = f(x) Q(x)$.) This gets you the formal
identity, but with possibly infinite generating functions rather than proper
polynomials.

As an example, take $f(x) = (1 + x)^{-1/2}$ and $b(n, m, k) = (n + m) / 2^k$.
Computing the "$(4, 4)$th Padé" approximant by defining $a(n, m, k)$ by
\eqref{convolution} yields the rational function

$$\frac{27x^4 - 16x^3 + 48x^2 + 128}{8x^4 + 16x^3 + 32x^2 + 64x + 128}.$$

However, the series expansion of this rational function disagrees with that of
$(1 + x)^{-1/2}$ at the fifth term, when it ought to agree until at least the
eighth!

To learn more about Padé approximants than you would ever care to know, see
Chapter 20 and on of Wall's *Analytic Theory of Continued Fractions*.

# Recurrences

Suppose that $f(x) = (1 + x)^c$ for some real $c$. Using the Maple packages
[PADE] and [FindRec], I have conjectured the following recurrences[^rec-note]
for the coefficients $a(n, m, k)$ and $b(n, m, k)$ of the $(n, m)$th Padé
approximant for $f$:

$$
\begin{align}
    \begin{split}
    a(n, m, k + 1) &= \frac{(n - k)(m + c - k)}{(k + 1) (n + m - k)} a(n, m, k) \\
    b(n, m, k + 1) &= \frac{(m - k)(n - c - k)}{(k + 1)(n + m - k)} b(n, m, k)
    \end{split}
    \label{rec}
    \tag{Recurrence}
\end{align}
$$

[^rec-note]: Strictly speaking, these recurrences don't make sense for $k = n$
             or $k = m$. I *should* have cleared denominators, and doing that
             would show that $a(n, m, k)$ vanishes if $k > n$, and $b(n, m, k)$
             vanishes if $k > m$, as we would expect.

Unrolling this and shifting $k$ back by $1$ gives the following solutions:

$$
\begin{align*}
    a(n, m, k + 1) &= a(n, m, 0) \frac{n^{\underline{k}} (m + c)^{\underline{k}}}{k! (n + m)^{\underline{k}}} \\
    b(n, m, k + 1) &= b(n, m, 0) \frac{m^{\underline{k}} (n - c)^{\underline{k}}}{k! (n + m)^{\underline{k}}}.
\end{align*}
$$

But if we just *look* at these long enough, we see how we *should* write them:

$$
\begin{align}
    \begin{split}
        a(n, m, k) &= a(n, m, 0) {n \choose k} {m + c \choose k} {n + m \choose k}^{-1} \\
        b(n, m, k) &= b(n, m, 0) {m \choose k} {n - c \choose k} {n + m \choose k}^{-1}.
    \end{split}
    \label{solution}
    \tag{Solution}
\end{align}
$$

All that's left are the two constant terms. Setting $x = 0$ in \eqref{pade}
tells us that $a(n, m, 0) = f(0) b(n, m, 0)$, and $f(x) = (1 + x)^c$ gives
$f(0) = 1$, so the constant terms are actually equal. Padé approximants are
only equal up to a constant multiple anyway, so from now on let's just assume
that $a(n, m, 0) = b(n, m, 0) = 1$. We'll come back to this later.

# Verification

If we define $a(n, m, k)$ and $b(n, m, k)$ to vanish when they should, then all
we need to check to prove our conjecture is that \eqref{convolution} holds with
$c(k) = [x^k] (1 + x)^c = {c \choose k}$. Writing this out, it is our challenge
to prove the following:

$$
    \sum_{j = 0}^k
    {m \choose j} {n - c \choose j} {c \choose k - j} {n + m \choose j}^{-1}
    = {n \choose k} {m + c \choose k} {n + m \choose k}^{-1}.
$$

This looks quite burly, but it is *completely routine* to prove these days with
[WZ] theory. The proof goes like this in Maple:

```maple
with(SumTools[Hypergeometric]):

a := (n, m, k, c) -> binomial(n, k) * binomial(m + c, k) / binomial(n + m, k):
b := (n, m, k, c) -> binomial(m, k) * binomial(n - c, k) / binomial(n + m, k):
d := (k, c) -> binomial(c, k):
T := b(n, m, j, c) * d(k - j, c) / a(n, m, k, c):

ZeilbergerRecurrence(T, k, j, f, 0..k);
```

This code outputs `-f(k) + f(k + 1) = 0`, where $f(k)$ is our sum in $j$. This
means, essentially, that our identity is true so long as it is true for $k
= 0$. Plugging in $k = 0$ gives the trivially true statement $1 = 1$, so we're
good!

# The constant factor

I may have been slightly misleading when I said that Padé approximants are
unique up to a constant multiple. This is *true*, but in practice packages will
choose *different constants* for each $(n, m)$th approximant, to clear
denominators or something like that. Put another way, the Padé approximates are
some function of $n$ and $m$ times the sequences in \eqref{solution}.

The [PADE] package assumes that $b(n, m, 0) = 1$, but then normalizes the
approximant by clearing denominators and making everything look nice. I believe
that, for PADE, the correct "constant" is $(n + m)! / \min(n, m)$, so

$$a(n, m, 0) = b(n, m, 0) = \frac{(n + m)!}{\min(n, m)!}.$$

Multiplying through by $(n + m)!$ gives integer coefficients, and I guess the
$\min(n, m)!$ term is there to get rid of any common integer factors after
that.

This has practical ramifications to the experimental side of this problem.
There are, I think, three ways to guess the coefficients:

1. Guess a recurrence for $a(n, m, k)$ in $k$ (read fixed polynomials from left to right);

2. Guess a recurrence for $a(n, m, k)$ in $n$ (read fixed degrees from top to bottom); and

3. Guess a recurrence for $a(n, m, n - k)$ in $n$ (read fixed *relative*
   degrees from top to bottom).

If every $(n, m)$ pair has a different constant, then the last two options
could be more difficult because the "normalizing constants" could be very
complicated. In other words, reading across different values of $(n, m)$ forces
you to guess the "base" sequences as well as the "normalizing" sequences. The
first option, in comparison, only needs you to guess the "base" sequence! You
know *a priori* that there *is* a normalizing sequence, and you can file that
problem away for another day.

# Small generalizations and special cases

Given the Padé approximants of $f(x) = (1 + x)^c$, we can get the approximants
of $(1 + tx)^c$ by scaling the old coefficients by $t^k$. Thus, to be
completely general, we should write

$$
\begin{align*}
    a(n, m, k) &= t^k {n \choose k} {m + c \choose k} {n + m \choose k}^{-1} \\
    b(n, m, k) &= t^k {m \choose k} {n - c \choose k} {n + m \choose k}^{-1}.
\end{align*}
$$

(If you don't believe me, just modify the above Maple code to prove it
yourself.)

The function $f(x) = (1 - 4x)^{-1/2}$ is of special interest since it generates
the central binomial coefficients. Let's find the diagonal approximants (i.e.,
$n = m$) for this $f$. Our work here tells us that

$$
\begin{align*}
    a(n, n, k) &= (-4)^k {n \choose k} {n - \frac{1}{2} \choose k} {2n \choose k}^{-1} \\
    b(n, n, k) &= (-4)^k {n \choose k} {n + \frac{1}{2} \choose k} {2n \choose k}^{-1}.
\end{align*}
$$

By some elementary binomial coefficient identities,

$$
\begin{align*}
    {n - \frac{1}{2} \choose k} &= \frac{ {2n \choose 2k} {2k \choose k}}{4^k {n \choose k}} \\
    {n + \frac{1}{2} \choose k} &= \frac{ {2(n + 1) \choose 2k} {2k \choose k}}{4^k {n + 1 \choose k}}.
\end{align*}
$$

Therefore, after some simplifying,

$$
\begin{align*}
    a(n, n, k) &= (-1)^k {2n - k \choose k} \\
    b(n, n, k) &= (-1)^k \frac{2n + 1}{2(n - k) + 1} {2n - k \choose k}.
\end{align*}
$$

This tells us that, say, the leading coefficient in the denominator is $b(n, n,
n) = (-1)^n (2n + 1)$. This checks out:

```
> Pade1((1 - 4 * x)^(-1/2), x, 2, 2);
                                              2
                                             x  - 3 x + 1
                                            --------------
                                               2
                                            5 x  - 5 x + 1

> Pade1((1 - 4 * x)^(-1/2), x, 3, 3);
                                           3      2
                                         -x  + 6 x  - 5 x + 1
                                        -----------------------
                                            3       2
                                        -7 x  + 14 x  - 7 x + 1

> Pade1((1 - 4 * x)^(-1/2), x, 4, 4);
                                      4       3       2
                                     x  - 10 x  + 15 x  - 7 x + 1
                                    ------------------------------
                                       4       3       2
                                    9 x  - 30 x  + 27 x  - 9 x + 1
```

# Conclusion

This seems to conclude the story of Padé approximants for $(1 + tx)^c$. We have
exhausted all meaningful generalizations. We could consider $(a + tx)^c$, but
that's really just the same function. No, I think that we're done here.

Maybe we shouldn't be surprised that these approximants turned out nice. The
coefficients of $(1 + x)^c$ are just binomial coefficients. Of course they
would spit out exactly the right kind of convolution identity.

Perhaps a more fruitful approach would be to look at known convolution
identities and work backwards to discovering the involved functions. That way
you at least know that you'll have *some* nice Padé approximants, whatever the
function is. A problem to be taken up soon!

[^Z]: https://sites.math.rutgers.edu/~zeilberg/
[PADE]: https://sites.math.rutgers.edu/~zeilberg/tokhniot/PADE
[FindRec]: https://sites.math.rutgers.edu/~zeilberg/tokhniot/FindRec.txt
[WZ]: https://www.math.upenn.edu/~wilf/AeqB.html
[EKHAD]: https://sites.math.rutgers.edu/~zeilberg/tokhniot/EKHAD
