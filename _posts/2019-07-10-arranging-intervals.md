---
title: Arranging intervals
date: 2019-07-21
---

Suppose that we have a collection of $n$ tasks which can be started or stopped
at any of $k$ possible points in time. For instance, if we have the tasks `a`
and `b` with 4 distinct points in time, here are the possible ways to arrange
the tasks to take up all 4 blocks of time:

    a-a-b-b
    a-b-a-b
    b-a-a-b
    a-b-b-a
    b-a-b-a
    b-b-a-a

The string `a-a-b-b` denotes that task `a` starts at the first time slot,
finishes in the second, and is then replaced by task `b` for two time slots.
The string `a-b-a-b` denotes that task `a` begins, task `b` begins while `a` is
ongoing, task `a` finishes, then task `b` finishes.

If we require that the $n$ tasks take up *all* $k$ of the time slots, then the
six possibilities above are *all* of the possibilities for $n = 2$ and $k = 4$.
If we had fewer time slots or more tasks, then there would be some overlap. We
write two tasks in the same time slot by juxtaposing the task names, such as
`ab`. For example, filling two time slots with two tasks `a` and `b` can only
be written as `ab-ab`. We do not distinguish this from `ba-ba` or `ba-ab`.

Let's agree to call these "tasks" *intervals*, in the sense that they represent
intervals of time between points. The intervals we have seen so far all have
two points. In an analogous way, we could discuss intervals with three, four,
or any number of points. For example, if tasks `a` and `b` occupy intervals of
length 3, then we could arrange them into 4 slots as follows:

    a-ab-ab-b

Here is a general question about intervals:

> How many ways can you arrange $n$ intervals of length $s$ into $k$ slots?

Let $\lambda_s(k, n)$ be the number of arrangements of $n$ intervals of length
$s$ into $k$ slots. We shall prove the following result about $\lambda_s$.

**Theorem.** For each positive integer $s$, $\lambda_s$ satisfies the
$(s + 1)$-term recurrence

$$
\begin{equation}
    \label{lambda-recurrence}
    \lambda_s(k, n) = {k \choose s} \sum_j {s \choose j} \lambda_s(k - j, n - 1)
\end{equation}
$$

with initial conditions $\lambda_s(k, 0) = [k = 0]$. Further, $\lambda_s$ may
be expressed as the sum


$$
\begin{equation}
    \label{lambda-sum}
    \lambda_s(k, n) = \sum_j {k \choose j} (-1)^{k - j} {j \choose s}^n.
\end{equation}
$$

**Proof of recurrence.** Single out the $n$th interval. For some $j$ in $[n]$,
this interval must occupy exactly $j$ slots where no other task is present. If
we remove those points along with all occurrences of the $n$th interval itself,
we are left with an arrangement of $n - 1$ intervals onto $k - j$ points, of
which there are $\lambda(k - j, n - 1)$. There are ${k \choose j}$ ways to
choose the initial $j$ points which the $n$th interval occupies alone, and then
${k - j \choose s - j}$ ways to place the remaining $s - j$ points. This means
that each $j$ contributes exactly

$$\lambda_s(k - j, n - 1) {k \choose j} {k - j \choose s - j}$$

arrangements to the total. Therefore

$$\lambda_s(k, n) = \sum_j \lambda_s(k - j, n) {k \choose j} {k - j \choose s - j}.$$

Our recurrence follows from the well-known binomial coefficient identity

$${k \choose j}{k - j \choose s - j} = {k \choose s} {s \choose j}. \quad \blacksquare$$

To prove the summation identity we need a lemma about falling factorials and
exponential generating functions.

**Lemma.** If $f$ is the exponential generating function (egf) of the sequence
$a(n)$, then the egf of $n^{\underline{m}} a(n)$ is $x^m D^m f$, where $D$ is
the differential operator.

The lemma's proof is a routine computation.

**Proof of summation identity.** Let $a_n(k) = \lambda_s(k, n)$ and

$$f_n(x) = \sum_{k \geq 0} \frac{a_n(k)}{k!} x^k$$

be the exponential generating function of $a_n(k)$ in $k$. Further let

$$g_n(x) = f_n(x) e^x = \sum_{k \geq 0} \frac{b_n(k)}{k!} x^k$$

be the egf of the binomial transform of $a_n(k)$. The coefficients $a_n(k)$ and
$b_n(k)$ are related via the binomial transform, so knowing either one tells us
the other. Using this, we will instead find $b_n(k)$.

Taking the egf of both sides of \eqref{lambda-recurrence} yields, by our lemma,

\begin{equation}
    \label{egf-eqn}
    f_n = \frac{x^s}{s!} \sum_j {s \choose j} D^{s - j} f_{n - 1}
\end{equation}

Fortunately, $g_n$ satisfies the miraculous identity[^g-identity]

[^g-identity]: This is routine to verify by induction.

$$D^s g_n = e^x \sum_j {s \choose j} D^{s - j} f_n,$$

so multiplying \eqref{egf-eqn} by $e^x$ yields

$$g_n = \frac{x^s}{s!} D^s g_{n - 1}.$$

This does not have an easy solution for the egf $g_n$ itself, but it does for
its coefficients. For every nonnegative integer $k$, the coefficient on $x^k
/ k!$ in the left-hand side is $b_n(k)$. The right-hand side is

$$\frac{x^s}{s!} D^s g_{n - 1}
    = \frac{x^s}{s!}
        \sum_{j \geq 0} \frac{(j + s)^{\underline{s}}}{(j + s)!} b_{n - 1}(j + s) x^j,$$

so the coefficient on $x^k / k!$ here is

$$
\begin{align*}
    \frac{k!}{s!} [x^{k - s}]
        \sum_{j \geq 0} \frac{(j + s)^{\underline{s}}}{(j + s)!} b_{n - 1}(j + s)
        &= \frac{k!}{s!} \frac{k^{\underline{s}}}{k!} b_{n - 1}(k) \\
        &= {k \choose s} b_{n - 1}(k).
\end{align*}
$$

Therefore,

$$b_n(k) = {k \choose s}^n b_0(k).$$

To compute the remaining $b_0(k)$, note that it comes from the binomial
transform:

$$b_0(k) = [x^k / k!] f_0(x) e^x = \sum_{j = 0}^k {k \choose j} a_0(k) = 1,$$

So the $b_0(k)$ factor washes out and we get

$$b_n(k) = {k \choose s}^n.$$

Inverting the binomial transform now yields

$$a_n(k) = \sum_j {k \choose j} (-1)^{k - j} {j \choose s}^n,$$

which is exactly what we claimed. $\blacksquare$

# Using the closed form

Despite the intimidating appearance of \eqref{lambda-sum}, we can obtain some
neat information from it.

For fixed $k$ and $s$, equation \eqref{lambda-sum} is a proper closed form. The
variable $n$ only appears as a power in \eqref{lambda-sum}, never as
a summation limit or binomial coefficient variable. For example, if $a_{s,
k}(n) = \lambda_s(k, n)$, then

$$a_{3, 4}(n) = 4^n - 1$$

for all $n$.

We can also immediately see the ordinary generating function (ogf) of the
sequence $a_{s, k}(n)$:

$$
\begin{equation}
    \label{gf}
    \sum_{n \geq 0} a_{s, k}(n) x^k =
    \sum_j \frac{ {k \choose j} (-1)^{k - j}}{1 - {j \choose s} x}.
\end{equation}
$$

This tells us to expect the ogf to be some rational function where the
numerator is confusing and the denominator is the product of $(1 - {j \choose
s} x)$ for all $j$. In particular, for $s = 2$ we should observe the triangular
numbers.

Since the generating function for $a_{s, k}(n)$ is rational, we know that our
sequence is C-finite: it satisfies a linear recurrence with constant
coefficients. We don't know what the recurrence is, but we know that it exists
and could probably find it if we wanted.

The generating function in \eqref{gf} has poles at $x = {j \choose s}^{-1}$ for
$s \leq j \leq k$. If we assume that $k \geq s$ (a perfectly reasonable
assumption), then the smallest pole is $x = {k \choose s}^{-1}$. This means
that the radius of convergence of our generating function is ${k \choose
s}^{-1}$, and so

$$\limsup_n \sqrt[n]{a_{s, k}(n)} = {k \choose s}.$$

In other words, for every $\epsilon > 0$ we have

$$a_{s, k}(n) \leq \left( {k \choose s} + \epsilon \right)^n$$

for sufficiently large $n$.

This is quite a bit of information to learn from such a gnarly-looking sum!

# Notes

The sequence $\lambda_2(k, n) = \lambda_{2, k}(n)$ is
[A059117](http://oeis.org/A059117) in the OEIS. I stumbled upon it while
working on a seemingly unrelated problem about lines. I thought that the
$\lambda_s$ numbers might be related to a different set of sequences sequence
somehow. In retrospect I'm certainly wrong, but they're cool anyway. I was
helped immensely in the special case $s = 2$ by Michael Somos's answer to [my
Math.SE](https://math.stackexchange.com/questions/3288280/) question. This is
all really just generalizing his answer and playing with the result.
