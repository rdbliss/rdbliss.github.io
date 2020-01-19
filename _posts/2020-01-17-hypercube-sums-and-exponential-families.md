---
title: Hypercube sums and exponential families
date: 2020-01-18
---

Sums over hypercubes are strange. By a "hypercube," I mean $\\{x, y\\}^n$ where
$x$ and $y$ are distinct symbols. For example, take $x = -1$ and $y = 1$. If we
define

$$\DeclareMathOperator{\sgn}{sgn}
\sgn v = (-1)^{\sum_k [v_k = -1]}$$

for $v \in \\{-1, 1\\}^n$, then

$$\sum_{v \in \{-1, 1\}^n} \sgn v = 0.$$

Here's another one:

$$\sum_{v \in \{-1, 1\}^n} (\sgn v) \left( \sum_{k = 1}^n v_k k \right)^n = 2^n (n!)^2.$$

And another:

$$\sum_{v \in \{-1, 1\}^n} (\sgn v) {-\sum_{k = 1}^n v_k \choose n} = (-2)^n.$$

Aren't these *weird*? What's going on here? I want to try and explain at least
a small collection of these.

# Products, products, products

Despite what I just said about hypercube sums being weird, they are actually
quite natural objects. If you ever want to expand a product of binomials into
a sum, then you are secretly thinking about hypercube sums. Given the product

$$\prod_{k = 1}^n (a_k + b_k),$$

any length-$n$ string consisting of two distinct symbols will tell you how to
form one term in the expansion. For example, if `L` means "left," and `R` means
"right," then the string `LRL` might correspond to the term $x^2 y$ in the
product $(x + y)^3$.

We can write this formally like so:

$$\prod_{k = 1}^n (a_k + b_k) = \sum_{v \in \{0, 1\}^n} \prod_{k = 1}^n a_k^{[v_k = 0]} b_k^{[v_k = 1]}.$$

This right-hand side has lots of flexibility: Pick any two values for the
hypercube that might be convenient, then use them in the expression however you
like. For example, given any function $f$,

$$\prod_{k = 1}^n (f(x) - f(-x)) = \sum_{v \in \{-1, 1\}^n} (\sgn v) f(x)^{n - \sgn v} f(-x)^{\sgn v}.$$

This is a little too general to be interesting. Let's see something more
concrete.

# Generating functions, generating functions, generating functions

In the land of generating functions, it is often natural to consider functions
of the form $e^{D(x)}$, where $D(x)$ is some generating function such that
$D(0) = 0$. These arise in the study of *exponential families*, and help count
things like graphs and partitions of sets and so on[^gfunology]. Here, these
functions are just the proper form to generate our identities.

[^gfunology]: See Chapter 3 of Herbert Wilf's
              [*generatingfunctionology*](https://www.math.upenn.edu/~wilf/gfologyLinked2.pdf)
              for an exposition on exponential families.

Let $D(x)$ be a generating function such that $D(0) = 0$. Consider the
difference

$$e^{a_k D(x)} - e^{-a_k D(x)}$$

where $a_k$ is some constant. If we set $d = [x] D(x)$, then

$$e^{a_k D(x)} - e^{-a_k D(x)} = 2 d a_k x + O(x^2).$$

Multiplying the first $n$ of these differences yields

$$\prod_{k = 1}^n (e^{a_k D(x)} - e^{-a_k D_k(x)}) = (2d)^n x^n \prod_{k = 1}^n a_k + O(x^{n + 1}).$$

Only a single term of $x^n$ appears, so the coefficient on $x^n$ in this
product is

$$
\begin{equation}
\label{product-side}
    [x^n] \prod_{k = 1}^n (e^{a_k D(x)} - e^{-a_k D(x)}) = (2d)^n x^n \prod_{k = 1}^n a_k.
\end{equation}
$$

On the other hand, from the previous section we can write our product as
a convenient hypercube sum over $\\{-1, 1\\}^n$:

$$
\begin{align*}
    \prod_{k = 1}^n (e^{D_k(x)} - e^{-D_k(x)}) &= \sum_{v \in \{-1, 1\}^n} (\sgn v) \prod_{k = 1}^n e^{v_k D_k(x)} \\
                                           &= \sum_{v \in \{-1, 1\}^n} (\sgn v) e^{D(x) \sum_{k = 1}^n v_k a_k}.
\end{align*}
$$

The sum in the exponential looks like an inner product, so let's not shy away
from that; define $(a, v) = \sum_{k = 1}^n a_k v_k$ for any two vectors of the
appropriate length. Now we can write

$$\prod_{k = 1}^n (e^{D_k(x)} - e^{-D_k(x)}) = \sum_{v \in \{-1, 1\}^n} (\sgn v) e^{D(x) (a, v)}.$$

If we equate coefficients with \eqref{product-side}, then we have a final
identity

$$
\begin{equation}
\label{ident}
\sum_{v \in \{-1, 1\}^n} (\sgn v) [x^n] e^{D(x) (a, v)} = (2d)^n \prod_{k = 1}^n a_k.
\end{equation}
$$

We are now within striking distance of excitement. Let's see some examples to
get the fire going.

# Examples

The simplest possible example is $D(x) = 0$. The requisite coefficients in
\eqref{ident} are

$$[x^n] \exp(0) = [x^n] 1 = 0$$

for $n \geq 1$. Thus \eqref{ident} reads

$$\sum_{v \in \{-1, 1\}^n} \sgn v = 0$$

for $n \geq 1$.

Next up is $D(x) = x$. Our coefficients are

$$[x^n] \exp(x (a, v)) = \frac{(a, v)^n}{n!}.$$

Since $d = 1$ here, equation \eqref{ident} yields

$$\sum_{v \in \{-1, 1\}^n} (\sgn v) (a, v)^n = 2^n n! \prod_{k = 1}^n a_k.$$

Define $w(v) = \sum_{k = 1}^n v_k$. Taking $a$ to be the all-ones sequence, our
identity yields

$$\sum_{v \in \{-1, 1\}^n} (\sgn v) w(v)^n = n! 2^n.$$

Before we continue, let's check some small cases. If $n = 1$, then this
identity reduces to

$$(-1) \cdot (-1) + (1) \cdot (1) = 2^1.$$

Good. For $n = 2$, it is

$$(1) (-1 - 1)^2 + (-1) (-1 + 1)^2  + (-1) (1 - 1)^2 + (1)(1 + 1)^2 = 2^2 \cdot 2.$$

It checks.

Let's turn the heat up a little. If we set $D(x) = -\log(1 - x)$, then the
generating function part of the summand in \eqref{ident} is $(1 - x)^{-(a,
v)}.$ The binomial theorem tells us that

$$[x^n] (1 - x)^{-(a, v)} = (-1)^n {-(a, v) \choose n}.$$

Since $d = 1$ here, equation \eqref{ident} now reads

$$\sum_{v \in \{-1, 1\}^n} (\sgn v) {-(a, v) \choose n} = (-1)^n 2^n \prod_{k = 1}^n
a_k.$$

If we rewrite that binomial coefficient, then we could also say

$$\sum_{v \in \{-1, 1\}^n} (\sgn v) {n + (a, v) - 1 \choose n} = 2^n \prod_{k = 1}^n
a_k.$$

As before, taking $a$ to be the all-ones sequence yields interesting special
cases:

$$
\begin{align*}
    \sum_{v \in \{-1, 1\}^n} (\sgn v) {-w(v) \choose n} &= (-1)^n 2^n \\
    \sum_{v \in \{-1, 1\}^n} (\sgn v) {n + w(v) - 1 \choose n} &= 2^n.
\end{align*}
$$

These three examples are enough to generate all of the identities we stated in
the previous section, but we have one more application to see.

# More about exponential families

Let's look at \eqref{ident} more closely[^admonition]. The equation is valid
for any generating function $D(x)$ with $D(0) = 0$, but any generating function
of the form $\exp(D(x))$ shouts "Exponential families!" until you listen. An
exponential family is a sequence of "decks" of "cards" from which we form
"hands." The sequence $d_n$ is the number of cards in the $n$th deck for $n
\geq 1$. We define $h(n, k)$ to be the number of hands of weight $n$ with $k$
cards. The bivariate, mixed-type generating function

[^admonition]: I will now mostly assume that you read [*generatingfunctionology*](https://www.math.upenn.edu/~wilf/gfologyLinked2.pdf) like I told you to.

$$H(x, y) = \sum_{n, k \geq 0} h(n, k) \frac{x^n}{n!} y^k$$

is called the *hand-enumerator* of the exponential family, and the
single-variable exponential generating function

$$D(x) = \sum_{n \geq 0} \frac{d_n}{n!} x^n$$

is the *deck-enumerator* of the family. The *exponential formula* states that

$$H(x, y) = e^{y D(x)}.$$

This is supremely interesting to us, because the left-hand side of
\eqref{ident} contains an expression of the form $e^{y D(x)}$ where $y = (a,
v)$ is just some number. Thus, if we are working in an exponential family,

$$[x^n] e^{D(x) (a, v)} = \frac{1}{n!} \sum_k h(n, k) (a, v)^k,$$

and plugging this into the full identity gives

$$\sum_{\substack{v \in \{-1, 1\}^n \\ k}} (\sgn v) h(n, k) (a, v)^k = n! (2d)^n \prod_{k = 1}^n a_k.$$

For simplicity, let's take $a$ to be the all-ones sequence, so that this reads

$$
\begin{equation}
\label{hand-sum}
    \sum_{\substack{v \in \{-1, 1\}^n \\ k}} (\sgn v) h(n, k) w(v)^k = n! (2d)^n.
\end{equation}
$$

This is a very strange identity. It holds for *all* exponential families, yet
the only parameter specific to the family on the right-hand side is $d$, the
number of cards of weight $1$ in the family.

For example, \eqref{hand-sum} holds with $h(n, k)$ defined as the number of:

- labeled graphs with vertex set $[n]$ and $k$ connected components;
- permutations on $[n]$ with $k$ disjoint cycles; and
- partitions of $[n]$ into $k$ disjoint parts.

This identity is so general that it must have a combinatorial proof, yet it
almost seems too general to believe that one could exist! I haven't come up
with one yet, but I learn one eventually.

To be honest, I don't quite believe this last identity. Here is some code to at
least numerically settle your stomach if you also have doubts:

```python
import itertools
from sympy import binomial
from sympy.functions.combinatorial.numbers import stirling


def sgn(v):
    return (-1)**sum(1 for x in v if x == -1)

def prod(a, v):
    return sum(a[k] * v[k] for k in range(len(a)))

def weight(v):
    a = [1] * len(v)
    return prod(a, v)

def sgn_sum(a):
    n = len(a)
    vs = itertools.product([-1, 1], repeat=n)

    return sum(sgn(v) * prod(a, v)**n for v in vs)

def binomial_sum(a):
    n = len(a)
    vs = itertools.product([-1, 1], repeat=n)

    return sum(sgn(v) * binomial(-prod(a, v), n) for v in vs)

# This should always be 2^n * n!, which I don't quite believe.
def stirling_sum(n, kind=2):
    vs = itertools.product([-1, 1], repeat=n)

    return [sgn(v) * stirling(n, k, kind=kind) * weight(v)**k for v in vs for k in range(n + 1)]

```

# Credits

I am out of easy examples, but I should say where these ideas originated.

This approach was merely a generalization of a single step (!) from a proof
contained in David and Jonathan Borwein's ["Some Remarkable Properties of Sinc
and Related
Integrals"](https://carma.newcastle.edu.au/resources/db90/pdfs/db90-119.00.pdf).
Theorem 2 of this paper contains the identity

$$\sum_{\gamma \in \{-1, 1\}^n} \epsilon_\gamma b_\gamma^n = 2^n n! \prod_{k = 1}^n a_k,$$

which, in the language of this post, is essentially

$$\sum_{v \in \{-1, 1\}^n} (\sgn v) (a, v)^n = 2^n n! \prod_{k = 1}^n a_k.$$

The proof of this identity is done in exactly the way we have described here,
by first considering the product

$$\prod_{k = 1}^n (e^{a_k x} - e^{-a_k x})$$

as a hypercube sum, and then expanding the product's factors and looking at the
coefficient on $x$ in the end result. This is just taking $D(x) = x$ in
\eqref{ident}.

From the exponential family perspective, this is the most boring family
possible: It has a single nonempty deck with a single card. Even so, the
identity shows that generating functions can make boring toys exciting again.
