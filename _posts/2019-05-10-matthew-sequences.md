---
title: Matthew sequences
date: 2019-05-14
---

$\renewcommand{\floor}[1]{\left\lfloor #1 \right\rfloor}$

I was recently shown a fun problem by Matthew, my younger brother in ninth
grade. It goes like this:

> What is the probability of answering this question correctly by guessing?
> 1. 60%
> 2. 25%
> 3. 25%
> 4. 30%

The answer is that there is no answer. The probability of choosing a correct
answer by guessing is

$$P = \frac{\text{# of ways to choose correct answer}}{4}.$$

None of the answers equal the $P$ value that they generate, so none of the
answers work.

This problem sounds silly at first, but has some fascinating ideas in it. It is
essentially asking us this: Given a sequence of numbers, what numbers are equal
to how often they occur in the sequence? The following is my normalized
reframing of it.

**Definition.** A *Matthew sequence* is a finite sequence of reals in $(0, 1]$
that sum to $1$. For such a sequence $S$ consisting of terms $a_1, \dots, a_n$,
let $f_S(x)$ be the proportion of elements of $S$ that equal $x$. That is,

$$f_S(x) = \frac{\sum_{k = 1}^n [x = a_k]}{n}.$$

A *fixed point* of $S$ is a fixed point of $f_S$ in $S$. That is, it is a real
$x \in S$ such that

$$x = \frac{\sum_{k = 1}^n [x = a_k]}{n}.$$

The fixed point $1$ of the Matthew sequence $[1]$ is called *trivial*.

In this language, the problem is asking us to find the fixed point of a given
finite sequence.

Examples:
- $1$ is a fixed point of $[1]$.
- $1/3$ is a fixed point of $S = [1 / 2, 1 / 3, 1 / 6]$.
- $2 / 5$ is a fixed point of $[2 / 5, 2 / 5, 1/15, 1/15, 1/15]$.
- The sequence $[1/4, 1/4, 1/3, 1/6]$ has no fixed point.

I think that there are a few natural questions:

1. What numbers can occur as fixed points of a Matthew sequence?
2. How many fixed points can occur in a Matthew sequence of fixed length?
3. Do there exist Matthew sequences with arbitrarily many fixed points?
4. If we know a particular fixed point, can we say anything about the size of
   the sequence it comes from?

In this post, I shall answer the first three questions.

# Classifying fixed points

Not every number can be a fixed point of a Matthew sequence. Fixed points must
be rational, for instance, but we can get even harsher restrictions. For
example, it is impossible for $\tfrac{1}{2}$ to be a fixed point of any Matthew
sequence. For it to be a fixed point it would need to make up exactly
$\tfrac{1}{2}$ of the elements of the sequence. However, since the sequence
must sum to $1$, this means that the sequence must be $[1/2, 1/2]$, of which
$1/2$ is *not* a fixed point. This argument generalizes to numbers greater than
$\tfrac{1}{2}$ as well.

**Lemma.** Every nontrivial fixed point of a Matthew sequence is strictly less
than $1/2$.

**Proof.** Suppose that a Matthew sequence $S$ had a fixed point $p \geq 1/2$.
Since $2p \geq 1$, the multiplicity of $p$ can be at most $2$. If it is exactly
$2$, then we have $2p \leq 1$ by the sum condition, which them implies $p
= 1/2$. We must conclude that $S = [1/2, 1/2]$, but then $p = 1/2$ is not
a fixed point.

Suppose that there is exactly a single $p$ present in $S$. For $p$ to be
a fixed point, we must have $p = 1 / n$ where $n$ is the size of our Matthew
sequence. Since $p \geq 1 / 2$, this implies $n \leq 2$, so our sequence is
either $[p]$ or $[p, 1 - p]$. The first case is possible only when $p$ is
nontrivial, so we must be in the second case. But then $p$ could only be
a fixed point if $p = 1/2$, which produces the sequence $[1/2, 1/2]$. Therefore
$p$ cannot be a fixed point. $\blacksquare$

**Proposition.** If $\tfrac{a}{b}$ is a nontrivial fixed point of a Matthew
sequence, then $1 \leq a^2 < b$ and $b > 2$.

**Proof.** Suppose that $a / b$ is nontrivial fixed point with multiplicity $m$
in a Matthew sequence of length $n$. Since $a / b$ is a fixed point, it follows
that $an = bm$. We can assume that $a$ and $b$ are coprime, hence $a$ divides
$m$, meaning that $a \leq m$. By the sum condition we have $a \leq m \leq
\floor{b / a}$, so $a \leq \floor{b / a}$. If $b / a$ is an integer, then $a
= 1$ since $a$ and $b$ are coprime. The previous lemma then implies $b > 2$,
which gives $a^2 < b$. If $b / a$ is not an integer then we immediately obtain
$a^2 < b$. $\blacksquare$

**Proposition.**
If $a / b$ is a rational such that $1 \leq a^2 < b$ and $b > 2$, then $a / b$
is a fixed point of some Matthew sequence.

**Proof.** We will construct a Matthew sequence with $b$ elements. Begin by
placing $a$ copies of $a / b$ into $S$. This gives the partial sum $a^2 / b$,
which is strictly less than $1$. The remaining sum to recover is $1 - a^2 / b$.
If $a \neq 1$, then

$$\frac{1 - a^2 / b}{b - a} \neq \frac{a}{b}.$$

Thus, we may add $b - a$ copies of

$$\frac{1 - a^2 / b}{b - a}$$

to $S$. If $a = 1$, then instead add $1/2 - 1/2b$ and $b - 2$ copies of

$$\frac{1 - \frac{1}{b} - \frac{1}{2} + \frac{1}{2b}}{b - 2}.$$

This only equals $1 / b$ or $1 / 2 - 1 / 2b$ for non-integer values of $b$. In
both cases, $a / b$ is in fact a fixed point. $\blacksquare$

**Theorem.** The rational $a / b$ is a nontrivial fixed point of some Matthew
sequence iff $1 \leq a^2 < b$ and $b > 2$.

**Proof.** Combine the two previous propositions.

# Counting fixed points

**Theorem.** Given a positive integer $n$, there exists a Matthew sequence of
length $O(n^3)$ with at least $n$ fixed points.

**Proof.** Let $N$ be a really big, to-be-determined number. Construct $S$ by
adding a single $1 / N$, two $2 / N$'s, three $3 / N$'s, and so on; each step
of this construction produces a new fixed point if $S$ ends with $N$ elements.
We may thus produce $n$ fixed points so long as

$$\sum_{k = 1}^n k \frac{k}{N} \leq 1.$$

That is, so long as

$$n(n + 1)(2n + 1) \leq 6N.$$

The left hand side is $O(n^3)$, so taking $N = cn^3$ for a suitable
constant $c$ will produce $n$ fixed points in $S$.

To finish the construction we need to ensure that $S$ sums to $1$ and has $N$
elements without ruining too many of the previous fixed points. When done with
our initial construction, we will have added $S_n = n(n + 1) / 2$ elements. If
we let $p$ be the sum of the first $S_n$ elements, then we could add $N - S_n$
copies of

$$\frac{1 - p}{N - S_n}$$

to make $S$ sum to $1$. This removes at most one fixed point, so we have at
least $n - 1$ fixed points. If we carry out this process from the beginning
with $n + 1$ instead of $n$, then we will still obtain a sequence of length
$O(n^3)$ with at least $n$ fixed points. $\blacksquare$

**Observation.** A fixed point of a Matthew sequence is determined by its
multiplicity. That is, if $x$ is a fixed point in a sequence of length $n$ that
occurs $m$ times, then $x = m / n$. Note that then $x$ contributes $m \cdot
m / n = m^2 / n$ to the sum of $S$.

**Proposition.** A fixed point in a Matthew sequence of length $n$ has
multiplicity not exceeding $\sqrt{n}$.

**Proof.** Let $x$ be a fixed point of the Matthew sequence $S$ of length $n$
with multiplicity $m$. Then $x = m / n$, and $x$ contributes $m^2 / n$ to the
sum of $S$. By the sum condition on $S$,

$$\frac{m^2}{n} \leq = 1.$$

Therefore $m \leq \sqrt{n}$. $\blacksquare$

**Theorem.** The number of fixed points in a Matthew sequence of length $n$
does not exceed $O(n^{1/3})$.

**Proof.** Suppose that there are exactly $r$ fixed points in $S$. Since fixed
points are determined by their multiplicities, each must have a distinct
multiplicity as well, call them $m_1, m_2, \dots, m_r$. The fixed points
contribute exactly

$$\sum_{k = 1}^r \frac{m_k^2}{n}$$

to the sum of $S$, therefore

$$\sum_{k = 1}^r \frac{m_k^2}{n} \leq 1$$

However, since the multiplicities are distinct integers in $[1, n]$, the
smallest that the sum on the left could be occurs when $m_k = k$. This yields

$$\sum_{k = 1}^r \frac{k^2}{n} \leq 1,$$

which gives, approximately,

$$\frac{r^3}{6n} \leq 1.$$

Therefore $r \leq (6n)^{1/3}$. $\blacksquare$

# Required Length of Matthew sequences

If $a / b$ is a fixed point of some Matthew sequence, we know that the sequence
length must be a multiple of $b$. Can it be anything other than $b$ itself?

As an example, consider $4 / 17$. By one of our previous theorems, we know that
$4 / 17$ must be a fixed point of *some* Matthew sequence. How long is this
sequence? If $4 / 17$ has multiplicity $m$ in a sequence of length $n$, then

$$n = m \frac{4}{17},$$

$17$ divides $n$, and $m \leq \floor{17 / 4}$. These all give us the inequality

$$17 \leq n \leq \left( \frac{17}{4} \right)^2 = 18.0625.$$

Since $n$ is a multiple of $17$, it follows that $n = 17$.

This argument works because $17$ is not much bigger than $4^2 = 16$. A similar
argument under the same hypotheses gives a partial result.

**Theorem.** If $a / b$ is a fixed point of a Matthew sequence $S$ such that
$a$ and $b$ are coprime and $b - a^2 < a$, then $|S| = b$.

**Proof.** Let $n = |S|$ and $m$ be the multiplicity of $a / b$. By definition,
we have

$$n = m \frac{b}{a}.$$

Since $m \leq \floor{b / a}$ and $b$ divides $n$, we have

$$b \leq n \leq \left( \frac{b}{a} \right)^2.$$

By a previous lemma, for $a / b$ to be a fixed point we must have $1 \leq a^2
\leq b$. If we write $b = a^2 + k$ for some nonnegative integer $k$, then our
inequality becomes

$$b \leq n \leq b + k + \frac{k^2}{a^2}.$$

Since $k = b - a^2 < a$ and $n$ is an integer, the inequality reduces to

$$b \leq n \leq b + k.$$

Since $k = b - a^2 < b$, the only multiple of $b$ satisfying this inequality is
$b$ itself. Since $n$ is a multiple of $b$, it follows that $n = b$.
$\blacksquare$

In general, this question remains open. We could probably think a little harder
with our number theory brains to find a better answer, but this seems like
a good place to stop for now.
