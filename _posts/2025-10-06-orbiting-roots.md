---
title: Orbiting roots
date: 2025-10-10
---

I've been dying to explain a picture for months. It's a very nice picture, but
the ideas are all tied up in different papers with different perspectives, and
it seems unlikely that the main point *about the picture* will get out anytime
soon. So, here it is.

![wow!](/images/sectors-11.svg)

I was [recently interested](https://arxiv.org/abs/2508.11043) in knowing when
two polynomials of the form $x^n - x^k + 1$, with $n$ fixed and $k < n$, were
relatively prime. For some reason I thought it made sense to look at the roots
of these, and I was very surprised!

Let me describe what's happening in this picture, in increasing order of
"surprise":

1. The roots of $x^n - x^k + 1$ cluster near the unit circle.

2. The roots of $x^n - x^k + 1$ cluster near the roots of $x^n + 1$.

3. The roots of $x^n - x^k + 1$ are *associated* with the roots of $x^n + 1$, meaning
    that for every root of $x^n + 1$ there is *exactly one* root of $x^n - x^k + 1$
    "nearby."

4. The roots of $x^n - x^k + 1$ *orbit around* the roots of $x^n + 1$ as they
   traverse the unit circle counter-clockwise. That is, as the angle increases,
   you can see the roots of $x^n - x^k + 1$ spinning around the roots of $x^n + 1$.
   It seems like (this took some time to see) the roots of $x^n - x^k + 1$ make
   a full $k + 1$ "orbits."

In hindsight, not everything here is surprising, but the "orbiting behavior"
still seems very strange!

Let me give you the summary before any fluff. It turns out that, if $w$ is
a root of $x^n + 1$, then the root of $x^n - x^k + 1$ that is "near" $w$ can be
approximated by

$$x \approx w - \frac{w^{k + 1}}{n}.$$

This says that $x$ will orbit around $w$ approximately $k + 1$ times as $w$
traverses the unit circle, and that it will hug $w$ closer for large $n$.

This can be made precise for fixed $n$ and $k$. Probably, this is a "good
approximation" in some sense for all $n$ and $k$, but I haven't worked out the
details of that.

# The "easy" part

[Rouché's theorem](https://en.wikipedia.org/wiki/Rouch%C3%A9%27s_theorem) is
the standard way to say that the roots of one function are close to the roots
of another function. In this case, if we could show that the inequality

$$|z^k| < |z^n + 1|$$

holds on the boundary of some region "around" a root of $x^n + 1$, then we
would know that $x^n - x^k + 1$ and $x^n + 1$ both have exactly one root in
that region. One obvious region to try is an annular sector "centered around"
the roots of $x^n + 1$. The angle of these sectors are the sectors you see in
the above picture.

A usual trick to prove these kinds of inequalities is to square both sides.
Here, that gives the equivalent inequality

$$|z|^{2k} < |z|^{2n} + 2 \operatorname{Re} z^n + 1.$$

If $|z|$ is big, then the right-hand side is bigger, because it grows like
$|z|^{2n}$ for large $|z|$. If $|z|$ is small, then the right-hand side is
bigger, because the left-hand side goes to $0$ as $|z| \to 0$ but the
right-hand side goes to $1$. This means that we can draw "inner" and "outer"
arcs of our annulus. We can make the bounds more explicit, but for now we know
that the rough idea works.

How wide should our sector be? I couldn't find a similar "hand-waving" argument
for this part. You might try this: Let $w$ be a root of $x^n + 1$, then let
$\arg z \to \arg w$. This forces $\operatorname{Re} z^n \to -1$, which turns
the inequality into something like $|z|^{2k} < |z|^{2n} - 1$. That's a very
nice *but false* inequality when $|z|$ is close to 1!

To figure this out, I tried this: Say that $z = te^{i\epsilon} w$ for some $t,
\epsilon > 0$. We don't have any say over $t$, but we can change $\epsilon$.
The first step is to notice that $z^n = e^{i \epsilon n} w^n = -e^{i \epsilon
n}$, which turns out inequality into

$$t^{2k} < t^{2n} - \cos(n \epsilon) + 1.$$

It would be really great if that cosine term just vanished. We can do that by
setting $\epsilon = \pi / 2n$, which turns the inequality into

$$t^{2k} < t^{2n} + 1.$$

This is true for all $t \geq 0$.

# The "hard" part

The last section explains why the roots of $x^n - x^k + 1$ cluster near the
roots of $x^n + 1$, but not why they *orbit*.

Let's be concrete and look at $x^{10} - x + 1$. Why do the roots of
$x^{10} - x + 1$ "orbit" around the roots of $x^{10} + 1$? Peter Mucha gave me
the following idea, which is apparently common in applied math.

We first "perturb" the equation into

$$x^{10} - \epsilon x + 1 = 0.$$

Our goal is to find a solution to this equation as a power series in
$\epsilon$, then set $\epsilon = 1$ to recover the actual root.

If you only want a finite number of terms, this is an algorithmic process. If
we pick a root of $x^{10} + 1$, say $w$, then we write
$x = w + a_1 \epsilon + O(\epsilon^2)$ and plug it into the original equation:

$$(w + a_1 \epsilon + O(\epsilon^2))^{10} - \epsilon (w + a_1 \epsilon + O(\epsilon^2)) + 1 = 0.$$

Now we do some algebra and extract only the terms that are linear in
$\epsilon$:

$$10 w^9 a_1 \epsilon - \epsilon w = 0.$$

Equating coefficients in $\epsilon$ gives $a_1 = w^{-8} / 10 = -w^2 / 10$, so
a "first order" approximation is

$$x \approx w - \frac{w^2}{10}.$$

This is basically the whole idea! As $w$ traverses the unit circle, $w^2 / 10$
traverses the circle of radius $1/10$ twice, meaning that $x$ "orbits" $w$
twice. That's exactly what we wanted to say.

If we repeat this process with symbolic $n$ and $k$, then we obtain

$$x \approx w - \frac{w^{k + 1}}{n}.$$

## Error bounds?

We are being *extremely* loose in the above discussion. Why can we set
$\epsilon = 1$ in our series? What is the error from using only the first term?

Some of this can be answered with heavy machinery.

**Step one.** Solve the equation $x^{10} - \epsilon x + 1 = 0$ for $\epsilon$:

$$\epsilon = \frac{x^{10} + 1}{x} =: f(x).$$


**Step two.** Apply the general [Lagrange inversion
formula](https://en.wikipedia.org/wiki/Lagrange_inversion_theorem) to write $x$
in terms of $\epsilon$:

$$x = w + \sum_{j \geq 1} a_j (\epsilon - f(w))^j,$$

where

$$a_j = [(x - w)^{j - 1}] \frac{(x - w)^j}{f(x)^j}.$$

Since $w^{10} + 1 = 0$, we have $f(w) = 0$, so the first series is

$$x = w + \sum_{j \geq 1} a_j \epsilon^j.$$

That's exactly what we want!

**Step three.** Turn the coefficient extraction into an integral:

$$
\begin{align*}
    a_j &= \frac{1}{j} [(x - w)^{j - 1}] \frac{(x - w)^j}{f(x)^j} \\
        &= \frac{1}{j} [(x - w)^{-1}] \frac{1}{f(x)^j} \\
        &= \frac{1}{j} \frac{1}{2 \pi i} \oint_z \frac{1}{f(z)^j} dz.
\end{align*}
$$

This last integral is over a small circle centered at $w$.

**Step four.** Apply [creative telescoping
arguments](https://arxiv.org/abs/2505.05345) to derive a recurrence for $a_j$.
I used Christoph Koutschan's `HolonomicFunctions` package to compute the
following recurrence:

$$
\begin{equation*}
    a_{j + 10} = \frac{81}{10^{10}} \frac{(j + 1)(3j + 13)(3j + 23)(9j - 1) (9j + 19) (9j + 29) (9j + 49) (9j + 59) (9j + 79)}
                                         {(j + 2) (j + 3) (j + 4) (j + 5) (j + 6) (j + 7) (j + 8) (j + 9) (j + 10)}
                                         a_j.
\end{equation*}
$$

It is a small miracle that we can compute this, and that it is so simple!

**Step five.** Study the recurrence for asymptotics.

In this case, because we have an explicit rational function, it is easy to see
that

$$a_{j + 10} \sim \frac{3^{18}}{10^{10}} a_j.$$

Simply because $3^{18} = 387420489 < 10^{10}$, this implies that $a_j$ decays
"exponentially quickly" for big $j$. So we *really can* plug in $\epsilon = 1$,
and we expect the first few terms to be a good approximation to the real
result.

# Next steps?

The next step here would be to repeat this analysis for different $n$ and $k$
and conjecture a more general pattern. Probably, it turns out that the
coefficient sequences always decay exponentially at a rate we can estimate. But
it would be nice to know something more specific about the approximation

$$x \approx w - \frac{w^{k + 1}}{n}$$

other than that it is "probably good."

---

# The real problem

(This last section is more for me than a general audience. Come along for the
ride if you want!)

The original question was actually about the *resultants* of two polynomials of
the form $x^n - x^k + 1$, i.e. $\operatorname{res}(x^n - x^k + 1, x^n - x^j + 1)$.
I wanted to know when this would be a power of 2. This has to do with making
modular arithmetic work faster.

It is not hard to show that

$$\operatorname{res}(x^n - x^k + 1, x^n - x^j + 1) = \pm\operatorname{res}(x^n - x^k + 1, x^{|k - j|} - 1),$$

so we can actually just think about resultants that look like

$$\operatorname{res}(x^n - x^k + 1, x^d - 1).$$

Now, the resultant of two polynomials is a function of their roots. We just
showed that the roots of $x^n - x^k + 1$ are close to the roots of $x^n + 1$,
so I thought that we could write this:

$$\operatorname{res}(x^n - x^k + 1, x^d - 1) \approx \operatorname{res}(x^n + 1, x^d - 1).$$

This may be true in *some* sense, but it is not good enough for our problem.

Why not? Because the roots of $x^n + x^k + 1$ are *also* close to the roots of
$x^n + 1$, but the resultant

$$\operatorname{res}(x^n + x^k + 1, x^d - 1)$$

is never a power of 2. In other words, slightly perturbing the roots of one
polynomial can drastically change arithmetic information about the resultant.
Very annoying!
