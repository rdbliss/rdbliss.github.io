---
title: An addendum to a Z talk
---

Doron Zeilberger recently gave a talk at RUMA, the Rutgers Undergraduate Math
Association, about mathematical gambling. In the talk he mentioned a [lovely
half-page
article](https://sites.math.rutgers.edu/~zeilberg/mamarim/mamarimPDF/pepys.pdf)
he wrote confirming a centuries-old conjecture by Newton and Pepys. The proof
is very short but relies on some hidden machinery, which I will explain here.

The basic idea is that we want to prove the identity

$$
\begin{equation}
    \label{goal}
\sum_{k = 0}^{n - 1} {6n \choose k} \left( \frac{1}{6} \right)^k \left( \frac{5}{6} \right)^{6n - k}
=
\sum_{k = 0}^{n - 1} R(k) {6k \choose k} \left( \frac{1}{6} \right)^k \left( \frac{5}{6} \right)^{5k}
\end{equation}
$$

where $R(k)$ is some explicit rational function. The reason is that the sum on
the right has no $n$ in it, and after seeing $R(k)$ written out, is obviously
monotonic because the terms are positive. The sum on the left contains a bunch
of $n$'s, so it isn't obvious if it gets bigger or smaller as $n$ grows.

First, a quick lesson on WZ theory. A sequence $a(n, k)$ is called
*hypergeometric* provided that $a(n + 1, k) / a(n, k)$ and $a(n, k + 1) / a(n,
k)$ are both explicit rational functions in $n$ and $k$. Certain nice
hypergeometric sequences have a "partner" $b(n, k)$ which satisfies the
identity

$$a(n + 1, k) - a(n, k) = b(n, k + 1) - b(n, k).$$

In this case $(a, b)$ is called a *WZ pair*. It is simple to algorithmically
determine whether any explicit sequence is hypergeometric or part of a WZ pair.
Our summand happens to be both.

# The theory

Say that you have a WZ pair $(a, b)$. That is,

$$
\begin{equation}
\label{wz}
a(n + 1, k) - a(n, k) = b(n, k + 1) - b(n, k).
\end{equation}
$$

Let

$$S(n) = \sum_{k = 0}^{n - 1} a(n, k)$$

be the sum that we are interested in. Summing over \eqref{wz} from $k = 0$ to
$k = n$ gives

$$S(n + 1) - S(n) - a(n, n) = b(n, n + 1) - b(n, 0).$$

If we move $a(n, n)$ to the right-hand side, then the left-hand side is
telescoping, so summing again recovers $S(n)$ itself. The end-result will be

$$S(n) = \sum_k (a(k, k) + b(k, k + 1) - b(k, 0)),$$

where the bounds are too tedious to determine. By some standard theory about
hypergeometric sequences, it turns out that $b(k, k + 1)$ and $b(k, 0)$ are
rational multiples of $a(k, k)$, so we can write

$$S(n) = \sum_k R(k) a(k, k),$$

the kind of sum we desired.

# The proof

The proof now is merely a matter of executing the steps outlined in the
previous section. All of these have been implemented in *Maple* or
*Mathematica* for decades. If we download
[EKHAD](https://sites.math.rutgers.edu/~zeilberg/tokhniot/EKHAD) and read it
into *Maple*, then executing `zeillim(a(n, k), k, n, N, 0, 1)` produces output
that implies \eqref{goal}. The rational function is

$$R(k) =
\frac{\frac{4375}{36} k^{4}+\frac{59675}{216} k^{3}+\frac{285955}{1296} k^{2}+\frac{281215}{3888} k +\frac{15625}{1944}}{\left(5 k +1\right) \left(k +1\right) \left(5 k +4\right) \left(5 k +3\right) \left(5 k +2\right)}.
$$
