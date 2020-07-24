---
title: An experimental approach to the drunk passenger problem
---

An apparently common question in
[quant](https://en.wikipedia.org/wiki/Quantitative_analysis_(finance))
interviews is as follows:

> Suppose that 100 passengers are boarding an airplane, all with assigned
seats. The first passenger is drunk, and sits in a random seat. Each following
passenger sits in their assigned seat, if it is available, and in a random seat
otherwise. What is the probability that the last passenger sits in their
assigned seat?

I just wanted to quickly write up what I thought were four nifty proofs,
including one "experimental."

First, you have to observe the fundamental recurrence. Let $p(n)$ be the
probability that the last passenger sits in the correct seat given that there
are $n$ passengers. It's easy to check that $p(1) = 1$ and $p(2) = p(3) = 1/2$.

Suppose that there are $n$ passengers. If the drunk sits in his seat, then the
probability of success is $1$. If the drunk sits in the $k$th person's seat
with $k > 1$, then the problem has been reduced to a drunk passenger with
a total of $n - k + 1$ passengers. (After the drunk sits, passengers $2$
through $k - 1$ sit, then passenger $k$ is so irate that they drink themselves
into a stupor.) Therefore,

$$p(n) = \frac{1}{n} \sum_{1 \leq k < n} p(k).$$

We now have a few ways to go about this.

## Guess-and-check

It's easy to see that $p(2) = p(3) = 1 / 2$, so maybe the sequence is just
constant after $n = 2$? In principle we would want to compute a few more terms,
but without a computer this gets hard to do in your head. We can jump straight
to induction:

$$\sum_{1 \leq k < n + 1} p(k) = 1 + \frac{n - 1}{2} = \frac{n + 1}{2}.$$

Dividing by $n + 1$ gives $1 / 2$, so $p(n)$ is constant beyond $n \geq 2$.

## Smarter recurrences

There's a standard trick to get rid of summations in recurrences, and in this
case it works exceptionally well. We can replace $n$ with $n + 1$ in the
fundamental recurrence, giving the following two equations:

$$
\begin{align*}
p(n) &= \frac{1}{n} \sum_{1 \leq k < n} p(k) \\
p(n + 1) &= \frac{1}{n + 1} \sum_{1 \leq k < n + 1} p(k).
\end{align*}
$$

Having the denominators on the right-hand side is a little awkward, so let's
multiply them to the other side, then subtract the two equations:

$$(n + 1)p(n + 1) - n p(n) = p(n).$$

Simplifying yields

$$(n + 1)(p(n + 1) - p(n)) = 0,$$

and since $n$ is positive, we see that $p(n)$ is constant for $n \geq 2$.

## *True* guess-and-check

The previous method works so well because $p(n + 1) = p(n)$ falls out, and the
first guess-and-check method works because the induction is easy. However,
I claim that the *true* guess and check method is even easier!

We know, *a priori*, that the sequence $p(n)$ defined by $p(2) = 1 / 2$ and

$$p(n) = \frac{1}{n} \left( 1 + \sum_{2 \leq k < n} p(k) \right)$$

satisfies a linear recurrence with polynomial coefficients. (We just showed how
to prove such a thing in the previous method. Even without getting supremely
lucky, the result still holds.) Therefore, since $p(n) = 1 / 2$ for the first
dozen terms or so (exercise!), it follows[^follows] that $p(n) = 1 / 2$ for all
$n \geq 2$.

[^follows]: To be completely rigorous, we need to say, "and the order of the
    recurrence is no larger than $K$," and then check $K$ terms, but at a glance we
    know that $K$ is certainly no more than ten, or whatever.

## Generating functions

This is an almost completely different way to do it.

Let $P(z) = \sum_{k \geq 2} p(k) z^k$. The fundamental recurrence can be
rewritten as

$$(n + 1) p(n) = 1 + \sum_{2 \leq k \leq n} p(k)$$

for $n \geq 2$, and it is an easy application of well-known
generatingfunctionology that this implies

$$zP'(z) + P(z) = \frac{z^2}{1 - z} + \frac{P(z)}{1 - z}.$$

This is a linear differential equation, with general solution given by

$$P(z) = \frac{c + z^2 / 2}{1 - z}$$

for some constant $c$. It is easy to check that $P''(0) = 1$, and this gives $c
= 0$. Thus

$$P(z) = \frac{z^2}{2(1 - z)} = \frac{z^2}{2} + \frac{z^3}{2} + \frac{z^4}{2}
+ \cdots.$$

We should note that this approach is almost entirely mechanical. Computers can
derive the differential equation and then solve it, almost unaided by humans.

## Conclusions

I don't know what this problem has to do with the stock market, but it sure is
fun!
