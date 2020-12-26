---
title: The Central Limit Theorem from 10,000 feet
---

The Central Limit Theorem (CLT) states, roughly, that averaging large samples
produces an approximately normal distribution. More formally, it says (in
a special case) that if $\\{X_k\\}$ is an iid sequence of random variables with
mean $0$ and variance $1$, then $n^{-1/2} \sum_{k = 1}^n X_k$ converges weakly
to the standard normal distribution.

Every undergrad in the world has probably heard "and proving the central limit
is beyond the scope of this course." Well, here I am to show a very
*high-level* proof. Sort of. I won't give all the technical details, because
I don't think they matter. What's amazing about the theorem is that it follows
from relatively "simple" asymptotics.

So, here's the CLT from 10,000 feet.

"It turns out"[^levy] that weak convergence of distributions is more-or-less
equivalent to pointwise convergence of characteristic functions. If

$$L(t) = \lim_n E[e^{itX_n}]$$

exists everywhere and is continuous at $0$, then $L(t)$ is a characteristic
function of some random variable $X$, and the $X_n$ converge weakly $X$. For
us, this means that $n^{-1/2} \sum_{k = 1}^n X_k$ would converge weakly to
a standard normal if we could show that

$$\lim_n E[e^{it n^{-1/2} \sum_{k = 1}^n X_k}] = e^{-t^2 / 2}.$$

[^levy]: Here's where many of the technical details are hidden. There is a lot
    of functional analysis hidden in the following statement. I don't
    understand it, you don't understand it, so let's just drop it and be on our
    way.

Suppose that the $X_k$ are distributed as $X$. Independence tells us that the
characteristic function of our sum is "nice":

$$E[e^{it n^{-1/2} \sum_{k = 1}^n X_k}] = E[e^{it n^{-1/2} X}]^n.$$

At this point we would love to say, "the characteristic function of $X
/ \sqrt{n}$ is (insert thing related to the characteristic function of $X$),"
but this is not true. Characteristic functions do not behave nice under scalar
multiples. There are no nice answers here. We have to do some approximations.

Let's use the following asymptotic expansion of the exponential function:

$$e^{it n^{-1/2} X} = 1 + \frac{it X}{\sqrt{n}} - \frac{t^2 X^2}{n} + O(n^{-3/2}).$$

Taking expectations yields

$$E[e^{it n^{-1/2} X}] = 1 - \frac{t^2}{2n} + O(n^{-3 / 2}),$$

so the characteristic function of $n^{-1/2} \sum_{k = 1}^n X_k$ is

$$(1 - \frac{t^2}{2n} + O(n^{-3 / 2}))^n.$$

If we take a log and apply its asymptotic expansion, then we get

$$n(-\frac{t^2}{2n} + O(n^{-3 / 2})) = -\frac{t^2}{2} + O(n^{-1/2}).$$

Thus, the characteristic function of $n^{-1/2} \sum_{k = 1}^n X_k$ is

$$-\frac{t^2}{2} + O(n^{-1/2}),$$

which means that it goes to $t^2 / 2$ as $n \to \infty$, which is the (log)
characteristic function of the standard normal. Done!

---

Let's look at some steps in a little more detail. Say, 5,000 feet.

Other than the business about characteristic functions, the only part we
cheated was the asymptotics. I wrote

$$e^{it n^{-1/2} X} = 1 + \frac{it X}{\sqrt{n}} - \frac{t^2 X^2}{n} + O(n^{-3/2}),$$

dropping the implicit $X^3$ factor in the big-Oh term. This is true if we
regard $X$ as just some constant, but as soon as we take expectations in the
next step, we're getting into fishy territory. The $X$'s that we dropped may
have been important. To really examine this, we need to know how that big-Oh
term behaves with the $X$'s back in it.

It turns out that the exponential function has nice remainder properties for
certain arguments. If we write

$$R_n(x) = e^{ix} - \sum_{k = 0}^n \frac{(ix)^k}{k!},$$

then

$$|R_n(x)| \leq \min(2 |x|^n / n!,\ |x|^{n + 1} / (n + 1)!).$$

This is not so hard to prove: Note that $R_n'(x) = i R_{n - 1}(x)$, so that

$$R_n(x) = i \int_0^x R_{n - 1}(t)\ dt.$$

Since $R_0(x) = e^{ix} - 1$ is bounded in absolute value by $\min(2, |x|)$,
induction proves the claim.

Putting all this together, we get

$$e^{i t X} = 1 + it X - \frac{t^2 X^2}{2} + R_2(t X).$$

Expectation will kill the linear term ($E[X] = 0$), and the remainder satisfies

$$|R_2(t X)| \leq \min( t^2 |X|^2, |t|^3 |X|^3 / 6),$$

or

$$|R_2(t X)| \leq t^2 \min( X^2, |t| |X|^3 / 6).$$

The minimum is bounded by the integrable $X^2$, and also goes to $0$ as $t \to
0$. Thus

$$E[R_2(t X)] = o(t^2),$$

meaning that dividing by $t^2$ produces something that tends to $0$ as $t \to
0$. Letting $t \mapsto t / \sqrt{n}$ gives

$$E[e^{it n^{-1/2} X}] = 1 - \frac{t^2}{2n} + o(t^2 / n),$$

so the full characteristic function is

$$(1 - \frac{t^2}{2n} + o(t^2 / n))^n.$$

Taking a log and doing the right simplifications yields a log-characteristic
function of

$$-\frac{t^2}{2} + n o(t^2 / n) \to -\frac{t^2}{2}$$

for all $t$. *Now* we're done.

---

So, back to the 10,000 foot view. What did we do?

1. Note that the characteristic functions had a *kind of* nice form, but needed
   some asymptotic analysis.

2. Do asymptotic analysis assuming that the random variables are unimportant
   with respect to $n$, then go back and check this if we need to.

With this in mind, let's try to prove something else: *Poisson distributions
with large means are approximately normal*.

More formally, let's prove this: Let $X_n$ be a sequence of Poisson random
variables with mean $\lambda_n$ where $\lambda_n \to \infty$. I want to show
that

$$G_n = \frac{X_n - \lambda_n}{\sqrt{\lambda_n}}$$

converges weakly to a standard normal distribution.

Fortunately, here the characteristic functions are easy to compute. Let
$\phi_X(t) = E[e^{itX}]$ be the characteristic function of a random variable
$X$. Then,

$$\phi_{G_n}(t) = E[e^{itG_n}] = e^{-it\sqrt{\lambda_n}} \phi_{X_n}(t / \sqrt{\lambda_n}).$$

The characteristic function for a Poisson random variable is well-known:

$$\phi_{X_n}(x) = e^{\lambda_n(e^{ix} - 1)}.$$

So, with $x = t / \sqrt{\lambda_n}$, we get

$$
\begin{align*}
    \log \phi_{G_n}(t) &= -it \sqrt{\lambda_n} + \log \phi_{X_n}(x) \\
                       &= -it \sqrt{\lambda_n} + \lambda_n (e^{ix} - 1).
\end{align*}
$$

We can do some asymptotics here, since $e^{ix} - 1 = ix - x^2 / 2 + O(x^3)$. This gives

$$
\begin{align*}
    \log \phi_{G_n}(t) &= -it \sqrt{\lambda_n} + it \sqrt{\lambda_n} - \frac{t^2}{2} + O(t^2 / \sqrt{\lambda_n}) \\
                       &= -\frac{t^2}{2} + O(t^2 / \sqrt{\lambda_n}).
\end{align*}
$$

Letting $n \to \infty$ shows that $G_n$ converges weakly to a standard normal.
