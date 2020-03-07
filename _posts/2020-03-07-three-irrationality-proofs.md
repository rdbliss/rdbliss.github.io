---
title: Algebraic and analytic irrationality proofs
---

At the behest of mathematicians wiser than myself, I have been thinking about
number theory generally and irrationality proofs in particular. I think that
there are two *flavors* of irrationality proofs available to us: algebraic and
analytic. Here I will sketch three irrationality proofs which naturally present
clear examples of these two flavors.

Roughly speaking, *analytic* proofs of irrationality construct infinite
approximations of a number which are "too good," while *algebraic* proofs use
only number-theoretic tools, such as primality. This is not such a clear
definition. We shall prove the following claim in three ways to demonstrate
this:

**Proposition.** $\sqrt{a^2 + 4}$ is irrational for all nonzero integers $a$.

**Algebraic Proof 1.** Suppose that $a^2 + 4 = b^2$ for some integer $b$.
Without loss of generality suppose that $a$ and $b$ are nonnegative. Since $4
= (b - a)(b + a)$, we have only three possible cases:

1. $b - a = 4$ and $b + a = 1$. This implies $2b = 5$, which is impossible.

2. $b - a = 1$ and $b + a = 4$. This also implies $2b = 5$, which is still
   impossible.

3. $b - a = b + a = 2$. Then $b = 2$ and $a = 0$.

Therefore $(a, b) = (0, 2)$ is the only integer solution. $\blacksquare$

**Algebraic Proof 2.** Without loss of generality, suppose that $a$ and $b$ are
nonnegative. If $a = 0$ then $b = 2$, so suppose that $a \geq 1$ (and $b \geq
1$ follows). If $a = 1$ then $b^2 = 5$, which is impossible. Thus suppose $a
\geq 2$. We clearly have $b > a$, so $b^2 \geq (a + 1)^2 > a^2 + 4$. This shows
that $(a, b) = (0, 2)$ is the only integer solution. $\blacksquare$

The analytic proof requires a bit of work.

**Lemma.** For every nonzero integer $a$, the polynomial $1 - az - z^2$ has
distinct nonzero roots, one inside the unit circle, and one outside.

**Proof.** The discriminant is $\sqrt{a^2 + 4} \neq 0$, so there are two roots.
The minus root which comes from the quadratic formula lies inside the unit
circle, and the fact that the roots multiply to $1$ in absolute value shows
that the other is outside the unit circle. $\blacksquare$

**Lemma.** Let $p_n$ and $q_n$ be the numerator and denominator, respectively,
of the $n$th convergent to the infinite continued fraction $[a, a, \dots]$.
Then

$$
    \frac{p_n}{q_n} = (a + r) (1 + O(\epsilon)^n),
$$

where $r$ is the root inside the unit circle of $1 - az - z^2$ and $0
< \epsilon < 1$.

I won't prove this lemma, but here is how a proof would go: Derive generating
functions for $p_n$ and $q_n$ from their well-known recurrences. These are
rational and give us a closed form. You can factor out a $1 / r$ times some
constants from both closed forms, and dividing them gives the asymptotic
expansion above with $\epsilon < 1$ since $r$ is the smaller root.

(I am too lazy to type this proof, but it really is a routine computation.)

**Analytic conclusion.** By the above lemmas, the continued fraction $[a, a,
\dots]$ equals $a + r$ when $a \neq 0$, so this number is irrational since it
has an infinite continued fraction. By the quadratic formula $a + r$ is
a rational linear combination of $1$ and $\sqrt{a^2 + 4}$, so it is irrational
iff $\sqrt{a^2 + 4}$ is irrational.

Is either method better? I'm not sure. The algebraic proofs are shorter here,
but the analytic proof is pretty interesting. I really like generating
functions, so I'm biased. It seems good to know both.
