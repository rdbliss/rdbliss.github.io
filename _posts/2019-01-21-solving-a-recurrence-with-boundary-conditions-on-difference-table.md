---
title: Boundary conditions in a difference table
date: 2019-01-21
tags:
    - recurrences
    - generating functions
    - difference tables
---

While going over some algebra exercises with a computer, I became interested in
a particular sequence. The sequence begins $8$, $72$, $648$. (It is the number
of units in the Gaussian integers modulo $3^k$.) I started playing around with
it and noticed a curious property of its difference table: the first entry of
every row was a power of $2$. The sequence itself ended up being fairly simple
to guess---it's just $9^k \cdot 8$---but my experiments made me wonder what
a proof would look like if we just knew that first entry. There is a fairly
well-known way to do this via the binomial transform, which I have joyfully
rediscovered.

To be more precise, the difference table looked like this:

$$
\begin{bmatrix}
    8 & & 72 & & 648 \\
      & 64 & & 576 & \\
      & & 512 & &
\end{bmatrix}.
$$

It looks like the first term in every row will be $2^{3(k + 1)}$. I wanted to
find a formula for the top row, knowing this fact.

More formally, suppose that we have some function $f(n, k)$ defined on
nonnegative integers by the equations
$$
\begin{align}
    f(n + 1, k + 1) &= f(n, k + 1) - f(n, k) &(k \geq n \geq 0) \\
    f(n, n) &= g(n) &(n \geq 0) \\
    f(n, k) &= 0 &(k < n),
\end{align}
$$
where $g$ is some "known" function. This says that $f$ is a difference table of
the sequence $a(k) = f(0, k)$, and that $g(n)$ is the first entry of the $n$th
row. Can we determine $f(0, k)$ in terms of $g$?

# Enter: Generating functions

Given the definition of $f$, there seem to be three natural candidates for
a generating function. They are:

- $A_n(x) = \sum_k f(n, k) x^k$
- $B_k(x) = \sum_n f(n, k) y^n$
- $C(x, y) = \sum_{k, n} f(n, k) x^k y^n$

If we choose $A_n(x)$, then we are looking for the coefficients of $A_0(x)$. If
we choose $B_k(x)$, then we are looking for the constant term of $B_k(x)$. The
generating function $C(x, y)$ looks hard, so we won't choose that.

For no particular reason, let's try $A_n(x)$. The recurrence

$$
    f(n + 1, k + 1) = f(n, k + 1) - f(n, k)
$$

is valid for $n, k \geq 0$, so multiply by $x^k$ and sum over $k \geq 0$:

$$
    \sum_{k \geq 0} f(n + 1, k + 1) x^k
        = \sum_{k \geq 0} f(n, k + 1) x^k - \sum_{k \geq 0} f(n, k) x^k.
$$

If we go through the motions here, we obtain

$$
    \frac{A_{n + 1}(x) - f(n + 1, 0)}{x}
        = \frac{A_n(x) - f(n, 0)}{x} - A_n(x).
$$

Since we must have $n \geq 0$, by our definition of $f$ we get $f(n + 1, 0)
= 0$. If $n \geq 1$, then we also get $f(n, 0) = 0$. Thus, for $n \geq 1$, we
obtain

$$
    A_{n + 1}(x) = (1 - x) A_n(x) \qquad (n \geq 1)
$$

and for $n = 0$ we obtain

$$
    A_1(x) = (1 - x) A_0(x) + g(0).
$$

Unrolling this equation will yield

$$
    A_{n + 1}(x) = (1 - x)^{n + 1} A_0(x) + (1 - x)^n g(0)
$$

for all $n \geq 0$.

This looks promising, save for one slight problem: We don't know what $A_0(x)$
is! That is exactly what we want to know, in fact. Discouraging though this may
be, we can take this one step further and uncover a neat result.

Our left hand side is the generating function $A_{n + 1}(x) = \sum_k f(n + 1,
k) x^k$. The coefficient on $x^{n + 1}$ is $f(n + 1, n + 1) = g(n + 1)$, so we
can probably link some terms on the right hand side to $g(n + 1)$ with this new
equality.

Indeed, let's find the coefficient of $x^{n + 1}$ in the right-hand side of

$$
    A_{n + 1}(x) = (1 - x)^{n + 1} A_0(x) + (1 - x)^n g(0).
$$

The term $(1 - x)^n g(0)$ contributes nothing, so

$$
    [x^{n + 1}] \left\{ (1 - x)^{n + 1} A_0(x) + (1 - x)^n g(0) \right\}
    =
    [x^{n + 1}] \left\{ (1 - x)^{n + 1} A_0(x) \right\}.
$$

This term requires some work:

$$
\begin{align*}
    (1 - x)^{n + 1} A_0(x) &= \sum_{j, k} {n + 1 \choose j} (-x)^{j} f(0, k) x^k \\
                           &= \sum_{j, k} {n + 1 \choose j} (-1)^j f(0, k) x^{j + k}.
\end{align*}
$$

Therefore,

$$
\begin{align*}
    [x^{n + 1}] \left\{ (1 - x)^{n + 1} A_0(x) \right\} &=
    [x^{n + 1}] \sum_{j, k} {n + 1 \choose j} (-1)^j f(0, k) x^{j + k} \\
    &= \sum_{j, k} [j + k = n + 1] {n + 1 \choose j} (-1)^j f(0, k) \\
    &= \sum_{j = 0}^{n + 1} {n + 1 \choose j} (-1)^j f(0, n + 1 - j) \\
    &= \sum_{j = 0}^{n + 1} {n + 1 \choose j} (-1)^{n + 1 - j} f(0, j).
\end{align*}
$$

Finally, equating the coefficients from both sides gives us the lovely equation

$$
    g(n + 1) = \sum_{j = 0}^{n + 1} {n + 1 \choose j} (-1)^{n + 1 - j} f(0, j),
$$

valid for $n \geq 0$, or

$$
\begin{equation}
    g(n) = \sum_{j = 0}^n {n \choose j} (-1)^{n - j} f(0, j),
\end{equation}
$$

valid for $n \geq 1$.

This seems like an awful lot of work to get a result that is nearly the
opposite of what we want, but just you wait until the sequel!

# Enter: The binomial transform

There is a wonderful theorem that runs like this:

$$
a(n) = \sum_{k = 0}^n {n \choose k} b(k)
$$

if and only if

$$
b(n) = \sum_{k = 0}^n {n \choose k} (-1)^{n - k} a(k).
$$

That is, the [*binomial transform*](https://oeis.org/wiki/Binomial_transform)
has a simple and unique inverse. We have proven that

$$
g(n) = \sum_{j = 0}^n {n \choose j} (-1)^{n - j} f(0, j),
$$

for $n \geq 1$, which can be inverted to the equation

$$
\begin{equation}
    f(0, n) = \sum_{j = 0}^n {n \choose j} g(j),
\end{equation}
$$

valid for $n \geq 1$. Note that this holds for $n = 0$ as well, for $f(0, 0)
= g(0)$. Our initial inequality---that seemingly had no direct way
forward---has been solved.

Let's try it out on our original problem. I noticed that the $g$ function was
$g(n) = 2^{3(n + 1)}$. That means that, according to our results,

$$
\begin{equation*}
    f(0, n) = \sum_{k = 0}^n {n \choose k} 2^{3(k + 1)} = 9^k \cdot 8.
\end{equation*}
$$

Amazing.

# A step further

We "unrolled" our recurrence for $A_n(x)$ down to $0$, but we could have
stopped earlier. In fact, for $1 \leq m \leq n$, we would obtain

$$
A_n(x) = (1 - x)^{n - m} A_m(x).
$$

Going through the same argument in the previous section would tell us that

$$
g(n) = \sum_j {n - m \choose j} (-1)^{n - m - j} f(m, m + j),
$$

and then a quick binomial inversion yields

$$
f(m, m + n) = \sum_j {n - m \choose j} g(j).
$$

This formula is only valid for $1 \leq m \leq n$, so it isn't *that*
interesting. We can only compute things like $f(n, 2n)$ and up, which isn't
quite a complete description of $f(n, k)$. But this seems like a good place to
stop.

## Recap

We began with a problem involving difference tables. This was easily translated
into a two-variable recurrence with some natural choices for generating
functions. The resulting generating functions gave us some interesting
equalities, which wound up being invertible binomial transforms. What are the
big takeaways here?

1. Difference tables are amenable to attack by generating functions. In
   particular, *the first diagonal of a difference table is the binomial
   transform of the first row*.

2. Useless-looking equalities can sometimes be quite helpful. The binomial
   transform is one of those. (For more examples, see the [Möbius
   function](https://en.wikipedia.org/wiki/M%C3%B6bius_function) in number
   theory, which is famous for inverting sums over integer divisors.)

3. Sequences are uniquely determined by the first diagonal of their difference
   tables.
