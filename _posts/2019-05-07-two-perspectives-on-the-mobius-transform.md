---
title: Two perspectives on the Möbius transform
date: 2019-05-08
---

The Möbius function $\mu$ is special because of its inversion principle:

$$
g(n) = \sum_{d \backslash n} f(d) \iff f(n) = \sum_{d \backslash n} \mu(d) g(n / d).
$$

That is, every sum over divisors can be uniquely inverted. This seems pretty
surprising to me. I want to discuss two ways that we can think of the Möbius
function. First as a function dreamed up exactly to give us that inversion
identity, and then as a natural object to study in generating functions.

# Recurrences

It is easy to retrospectively conjure up the Möbius function. Suppose that we
want to show that we can invert a sum over divisors. That is, we want to turn

$$
g(n) = \sum_{d \backslash n} f(d)
$$

into something like

$$
f(n) = \sum_{d \backslash n} q(n / d) g(d)
$$

for some suitable $q$. (This exact form seems like a questionable step, but
could be motivated. It's something like the convolution of two sequences,
tailored for number theory.) We would begin by looking at that inner sum:

$$
\sum_{d \backslash n} q(n / d) g(d) = \sum_{d \backslash n} \sum_{k \backslash d} q(n / d) f(k).
$$

Interchanging the order of summation turns this into

$$
\sum_{k \backslash n} \sum_{d \backslash n / k} q(n / kd) f(k)
    = \sum_{k \backslash n} f(k) \sum_{d \backslash n / k} q(n / kd).
    = \sum_{k \backslash n} f(k) \sum_{d \backslash n / k} q(d).
$$

We would *really* like for that inner sum to equal $[n = k]$, or $[n / k = 1]$.
That is, we would like for $q(d)$ to satisfy the identity

$$
\sum_{d \backslash m} q(d) = [m = 1]
$$

for all nonnegative integers $m$. This is precisely the definition of the
Möbius function, so $q(d) = \mu(d)$. The proof ends with

$$
\sum_{k \backslash n} f(k) \sum_{d \backslash n / k} \mu(d)
    = \sum_{k \backslash n} f(k) [n / k = 1]
    = f(n).
$$

So, armed with a little bit of foresight (or hindsight), it isn't *too* hard to
guess what the Möbius function should be.

# Generating functions

The previous derivation of the Möbius function still requires some ingenuity.
You need to conjecture that the inversion formula will take a certain form,
then know enough about interchanging sums over divisors so that everything
becomes clear. There is another way to discover the Möbius function that is
entirely ingenuity-free: With generating functions.

The two usual types of generating functions are the *exponential* and
*ordinary* kind. However, there are others. The one useful for us is the
*Dirichlet* generating function (dgf) of a sequence, defined as

$$
D(s) = \sum_{n \geq 1} \frac{a_n}{n^s}
$$

for a sequence $\{a_n\}$. As an example, the Riemann zeta function is just the
Dirichlet generating function of the sequence $a_n \equiv 1$:

$$
\zeta(s) = \sum_{n \geq 1} \frac{1}{n^s}.
$$

Like other generating functions, dgfs satisfy a useful multiplication rule. If
$F(s)$ and $G(s)$ generate $\{a_n\}$ and $\{b_n\}$, respectively, then $F(s)
G(s)$ generates

$$
\sum_{d \backslash n} a_d b_{n / d}.
$$

This lets us formulate the inversion principle in terms of dgfs. The equation

$$
g(n) = \sum_{d \backslash n} f(d)
$$

is equivalent to saying that

$$
G(s) = F(s) \zeta(s),
$$

where $G$ and $F$ are the dgfs of $g(n)$ and $f(n)$. Simply multiplying by
$\zeta^{-1}(s)$ gives

$$
F(s) = G(s) \zeta^{-1}(s).
$$

Equating coefficients gives us a relationship between $f(n)$ and $g(n)$. All
that remains is to find the coefficients of $\zeta^{-1}(s)$. Suppose that

$$
\zeta^{-1}(s) = \sum_{n \geq 1} \frac{z_n}{n^s}.
$$

Then, the equation $\zeta(s) \zeta^{-1}(s) = 1$ is equivalent to saying that

$$
\sum_{d \backslash n} z_d = [n = 1].
$$

This is exactly the definition of the Möbius function. That is, $z_n = \mu(n)$.
From this perspective, the Möbius transform is a trivial consequence of the
relation

$$G(s) = F(s) \zeta(s) \iff F(s) = G(s) \zeta^{-1}(s).$$

In some sense, the Möbius inversion is the simplest possible thing that we
could prove here. The dgf $\zeta(s)$ is the simplest generating function that
we could imagine, and the Möbius inversion formula just comes from looking at
its inverse. We could easily discover other, more complicated identities by
considering more complicated generating functions.

For example, the dgf of the sequence $a_n = n$ is $\zeta(s - 1)$. Right away,
we can generate the sum of divisors sequence with $\zeta(s) \zeta(s - 1)$:

$$
\zeta(s) \zeta(s - 1) = 1 + \frac{3}{2^s} + \frac{4}{3^s} + \frac{7}{4^s} + \cdots
$$

However, this seems like a topic to explore another day.
