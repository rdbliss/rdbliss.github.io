---
title: Round reciprocals of Fibonacci numbers
---

The Fibonacci numbers $F_n$ are roughly equal to $\phi^n / \sqrt{5}$, where
$\phi = (1 + \sqrt{5}) / 2$ is the golden ratio. In fact, they're so close that
*rounding* $\phi^n / \sqrt{5}$ will give you the right answer:

$$
\begin{align*}
    \frac{\phi^5}{\sqrt{5}} &= 4.9596747752\dots \\
    F_5 &= 5.
\end{align*}
$$

This implies that the series $\sum_{k = 1}^\infty \frac{1}{F_k}$ converges
because it is essentially a geometric series with ratio $\phi^{-1}$. In
particular, this means that the *tails* of this series must go to zero, which
means that the *reciprocals* of the tails get big. More explicitly, the
sequence

$$S(n) = \left(\sum_{k = n}^\infty \frac{1}{F_k}\right)^{-1}$$

goes to infinity. Here are the first few terms:

| n | S(n) |
----|--------
| 2 |  0.4237  |
| 3 |  0.7354  |
| 4 |  1.1629   |
| 5 |  1.8991   |
| 6 |  3.0623   |
| 7 |  4.9615   |
| 8 |  8.0238   |

Do you notice anything interesting about this table? Let's see it one more
time, with a new column.

| n | S(n) | round(S(n))
----|--------|
| 2 |  0.42404  | 0
| 3 |  0.73537  | 1
| 4 |  1.1629   | 1
| 5 |  1.8991   | 2
| 6 |  3.0623   | 3
| 7 |  4.9615   | 5
| 8 |  8.0238   | 8

If you round the tails, you get the Fibonacci numbers again! That is, it looks
like

$$\mathrm{round}\left(\left(\sum_{k = n}^\infty \frac{1}{F_k}\right)^{-1}\right) = F_{n - 2}.$$

This turns out to be correct. In fact, it turns out to be correct for a pretty
broad class of sequences. Here, I'm going to show a quick proof, summarize what
we know about these sequences, and point out where there are gaps in our
knowledge.

# Why does this work?

The intuition here is that, since $F_n$ is basically $\phi^n / \sqrt{5}$,
something like this should be true:

$$\sum_{k \geq n} \frac{1}{F_k} \approx \sum_{k \geq n} \frac{\sqrt{5}}{\phi^k} = \frac{\sqrt{5}}{\phi^{n - 1} (\phi - 1)}.$$

Then we reciprocate both sides, and get something useful to play with. The
proof just makes this intuition more rigorous. It uses the asymptotic identity
$(1 + O(a(n)))^{-1} = 1 + O(a(n))$, valid whenever $a(n) \to 0$.

**Proof.** By Binet's formula, $F_n = A \phi^n + B \psi^n$ for some constants
$A$ and $B$, where $\phi$ and $\psi$ are the golden ratio and its conjugate,
respectively. Therefore,

$$
\begin{align*}
\frac{1}{F_k} &= (A \phi^k)^{-1} (1 + O((\psi / \phi)^k))^{-1} \\
              &= (A \phi^k)^{-1} (1 + O((\psi / \phi)^k)) \\
              &= (A \phi^k)^{-1} + O((\psi / \phi^2)^k).
\end{align*}
$$

If we sum this over $k \geq n$, then we obtain

$$\sum_{k \geq n} \frac{1}{F_k} = (A \phi^{n - 1} (\phi - 1))^{-1} + O((\psi / \phi^2)^n).$$

Reciprocating yields

$$
\begin{align*}
    \left(\sum_{k \geq n} \frac{1}{F_k}\right)^{-1}
        &= ((A \phi^{n - 1} (\phi - 1))^{-1} + O((\psi / \phi^2)^n))^{-1} \\
        &= A \phi^{n - 1} (\phi - 1) (1 + O((\psi / \phi)^n)) \\
        &= A \phi^{n - 1} (\phi - 1) + O(\psi^n).
\end{align*}
$$

Now, note that $A \phi^{n - 1} (\phi - 1) = F_n - F_{n - 1} + O(\psi^n)$, and
that $F_n - F_{n - 1} = F_{n - 2}$. This gives us

$$
\left(\sum_{k \geq n} \frac{1}{F_k}\right)^{-1} = F_{n - 2} + O(\psi^n).
$$

Since $|\psi| < 1$, eventually the left-hand side is within $1/2$ of
$F_{n - 2}$, so rounding the left-hand side for sufficiently large $n$ gives
$F_{n - 2}$. $\blacksquare$

The key insights were something like this:

1. The Fibonacci numbers have characteristic equation $(x - \phi)(x - \psi)$.
2. One root, $\phi$, is greater than $1$. The other root, $\psi$, has absolute
   value less than $1$.
3. The reciprocal sums are $F_{n - 2} + O(\psi^n)$.

It turns out that this proof applies to nearly any sequence whose
characteristic polynomial satisfies these properties. The theorem goes
something like this.

**Theorem.** Let $c(n)$ be an integer-valued sequence which satisfies a linear
recurrence with constant coefficients. If the characteristic equation of this
recurrence has one root outside the unit circle and all other roots strictly
inside the unit circle, then

$$\mathrm{round} \left( \left( \sum_{k \geq n} \frac{1}{c(k)} \right)^{-1} \right) = c(n) - c(n - 1)$$

for sufficiently large $n$.

# What don't we know?

Fix an integer-valued sequence $c(n)$ which satisfies a linear recurrence with
characteristic polynomial $P(x)$. Let

$$S(n) = \left( \sum_{k \geq n} \frac{1}{c(k)} \right)^{-1}.$$

The question is what happens to $\mathrm{round}(S(n))$.

1. If the largest root of $P(x)$ is outside the unit circle and the smaller
   roots are inside the unit circle, then $S(n)$ rounds to $c(n) - c(n - 1)$
   for sufficiently large $n$. This is the previous theorem I mentioned.

    There are lots of papers which say this, then provide an example of its
    application. They mostly have the flavor of, "look at an infinite family of
    polynomials I found which satisfies this property that we need."

2. When does $S(n)$ *not* round to $c(n) - c(n - 1)$? Is the previous condition
   about the roots necessary? What if there are roots *on* the unit circle?

3. When does $\mathrm{round}(S(n))$ satisfy a linear recurrence with constant
   coefficients? Perhaps it does not equal $c(n) - c(n - 1)$, but it might
   still satisfy a recurrence of some kind. This would be a neat closure
   property of [C-finite
   sequences](https://en.wikipedia.org/wiki/Constant-recursive_sequence).

These last two questions seem open.

# Roots on the unit circle

Let me demonstrate that "one root is outside the unit circle and the others are
inside" is not a necessary condition. Take the example sequence $c(n) = 2^n
- 1$, which has the characteristic polynomial $(x - 1)(x - 2)$. Let

$$S(n) = \left( \sum_{k \geq n} \frac{1}{2^k - 1} \right)^{-1}.$$

There is very convincing data that $S(n)$ will round to $2^{n - 1}$:

| n | S(n) |
----|------
  2 | 0.622     |
  3 | 1.648     |
  4 | 3.658     |
  5 | 7.662     |
  6 | 15.665    |
  7 | 31.666    |

However, the previous proof does *not* work. If we try to follow the argument
again, we'll get

$$S(n) = 2^{n - 1} + O(1),$$

which is not good enough to say what $S(n)$ will round to. This is because one
root of the polynomial is *on* the unit circle rather than inside it.

Nevertheless, there is an argument. We just need to be more careful with our
asymptotics. Start by writing

$$
\begin{align*}
    \frac{1}{2^k - 1}
        &= \frac{1}{2^k} \left(1 + \frac{2^{-k}}{1 - 2^{-k}}\right) \\
        &= \frac{1}{2^k} +  \frac{2^{-2k}}{1 - 2^{-k}}.
\end{align*}
$$

If we sum this over $k \geq n$, then we get

$$S(n)^{-1} = 2^{-n + 1} + \sum_{k \geq n} \frac{2^{-2k}}{1 - 2^{-k}}.$$

Call that last sum $E(n)$. In the previous proof, we essentially say $E(n)
= O(2^{-2n})$ and call it a day, which ends up giving us an $O(1)$ error. By
being more careful, we can determine the constant on $2^{-2n}$ and thereby
improve our final error term. It looks like this:

$$
\begin{align*}
    \sum_{k \geq n} \frac{2^{-2k}}{1 - 2^{-k}}
        &= \sum_{k \geq n} (2^{-2k} + O(2^{-3k})) \\
        &= \frac{2^{-2n}}{1 - 2^{-2}} + O(2^{-3n}).
\end{align*}
$$

So, in fact, $E(n) = \frac{4}{3} 2^{-2n} + O(2^{-3n})$. If we stick with
$E(n)$, we have

$$
\begin{align*}
    S(n) &= (2^{-n + 1} + E(n))^{-1} \\
         &= 2^{n - 1} (1 + 2^{n - 1} E(n))^{-1} \\
         &= 2^{n - 1} (1 - 2^{n - 1} E(n) + O(2^{2n} E(n)^2)).
\end{align*}
$$

Now we can plug-in our improved estimate for $E(n)$:

$$
\begin{align*}
    S(n) &= 2^{n - 1} - 2^{2n - 2} (2^{-2n} (1 - 2^{-2})^{-1} + O(2^{-3n})) + O(2^{-n}) \\
         &= 2^{n - 1} - \frac{1}{3} + O(2^{-n}).
\end{align*}
$$

The sequence $S(n)$ is almost exactly a third away from $2^{n - 1}$, so
eventually we'll have $\mathrm{round}(S(n)) = 2^{n - 1}$.

The takeaway is that sometimes $S(n)$ will round to $c(n) - c(n - 1)$ even when
the characteristic equation of $c(n)$ has a root on the unit circle. So we
still don't know a necessary condition for this rounding behavior.
