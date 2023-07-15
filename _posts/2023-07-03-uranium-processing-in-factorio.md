---
title: Factorio and the Josephus problem
hide: true
---

Don't tell my advisor / employer / students, but I have been playing a lot of
the excellent game [*Factorio*](https://www.factorio.com/) lately. *Factorio*
is a factory management simulator where you escape an alien world by automating
the harvesting of natural resources to build a rocket. Moreso than most
management games, *Factorio* focuses on the logistical problems of managing
a supply chain. This can lead to some neat questions.

Take, for example, power generation. Every factory needs power. One very
efficient late game technology is nuclear power, which requires the following
supply chain:

1. Mine uranium ore.
2. Process uranium ore into uranium-235 and uranium-238.
3. Using both uranium-235 and uranium-238, create uranium fuel cells.

The catch is that step 2 is probabilistic. For each unit of uranium ore that
you process, there is a 99.3% chance to obtain uranium-238 and a 0.7% chance to
obtain uranium-235. Let's call these "bad" uranium and "good" uranium,
respectively. Step 3 requires that you have 10 bad uranium and 1 good uranium.
Because of these brutal probabilities it can take a while to get enough good
uranium for anything useful to happen.

Things liven up once you generate 40 good uranium. Then, via another late-game
technology, you can put 40 good uranium into a machine that spits out 41 good
uranium. This is 41 *total* good uranium---the 40 you put in plus one new one.
This sounds paltry but multiplying your supply by $41 / 40$ would give
exponential growth.

Unfortunately, this is not how things work. The bottleneck is that the process
to turn 40 good uranium into 41 good uranium only works on 40 uranium at
a time, per machine you have to run it. The first time you run it you will have
41 good uranium, but you can only put exactly 40 back into the process, leaving
the lone good ore to sit there, useless.

This leads us to an interesting question. If you had infinitely many machines
to run this process, then the amount of good uranium at step $n$ is given
recursively by

$$
\begin{align*}
    U_0 &= 40 \\
    U_{n + 1} &= U_n + \left \lfloor \frac{U_n}{40} \right \rfloor
        = \left \lfloor \frac{41}{40} U_n \right \rfloor.
\end{align*}
$$

What is the asymptotic value of $U_n$?

A good guess is that the answer is close to $(41 / 40)^n \cdot 40$ despite the
bottleneck. This is wrong, but not *that* wrong.

$n$ | $U_n$ | $(41 / 40)^n \cdot 40$ | ratio
---:|:-----:|:----------------------:|:----:
0 | 40 | 40 | 1
1 | 41 | 41 | 1
2 | 42 | 42 | 1
40 | 80 | 107 |   0.745
100 | 291 | 472 | 0.616

Like any good question, you can find a version of this in the
[OEIS](https://oeis.org/). If, instead of $41 / 40$, you use $3 / 2$, then you
will find [A061418](https://oeis.org/A061418). This led me to a paper of
[Odlyzko and
Wilf](https://www.cambridge.org/core/services/aop-cambridge-core/content/view/S0017089500008272)
studying similar sequences. The difference is that they used ceilings instead
of floors.

Adapting the ideas in Wilf's paper, it turns out that $U_n$ *is* exponential
but significantly smaller than $(41 / 40)^n \cdot 40$. In particular, there is
a constant $c$ such that

$$U_n \sim (41 / 40)^n 40 c \quad ; \quad c = 0.574256\dots$$

You lose about 43% of your exponential capacity to waiting. This is still
pretty good!

This constant does not seem to be expressible in terms of anything well-known.
There is a "formula," but it is useless for practical purposes.

# Connection to the Josephus problem

Unsurprisingly, Wilf and Odlyzko were not considering uranium processing in
*Factorio*. They were working on a solution to the Josephus problem.

The Josephus problem is this: Arrange $n$ people in a circle and execute every
$q$th person until there is only one left. Where should you stand in the
initial circle to be the surviving person? This position is called $J_q(n)$.
The $q = 2$ case has the famous solution $J_2(n) = 2(n - 2^{\lfloor \log_2
n \rfloor}) + 1$, but there aren't really closed forms beyond that.

[*Concrete Mathematics*](https://en.wikipedia.org/wiki/Concrete_Mathematics)
presents a neat algorithm to solve this problem iteratively. Once you pass over
someone, move their index to the smallest index not yet seen. (So $1$ will
become $n + 1$ and $2$ will become $n + 2$ as long as $q > 2$.) The last person
to be executed will have the label $qn$, so you just need to determine the
original index of the person who is eventually labeled $qn$. The sequences of
Wilf and Odlyzko help do this.

There is a similar Josephus-type problem that *our* sequence helps solve.
Arrange $n$ people in a circle and execute every $q$th person *starting from
the first one*. That is, you will always execute the first person, then begin
counting off by $q$ from there.

Under the same relabeling scheme as before, the last person to be executed will
have label $q(n - 1) + 1$, and it turns out that the label of this person after
going in reverse $k$ steps is $qn - U_k^{(q)}$, where $U_k^{(q)}$ is defined by

$$
\begin{align*}
    U_0^{(q)} &= q - 1 \\
    U_k^{(q)} &= \left\lfloor \frac{q}{q - 1} U_{k - 1}^{(q)} \right\rfloor.
\end{align*}
$$

This sequence solves the problem because we can stop computing as soon as
$qn - U_k^{(q)} \leq n$. That is, as soon as $U_k^{(q)} \geq (q - 1)n$.

This sequence is also exactly the same form as our uranium sequence! We just
need to set $q = 41$. That is, when we are producing good uranium in
*Factorio*, we are implicitly solving this modified Josephus problem where we
execute every forty-first person starting from the first. In particular, if it
took exactly $K$ steps to produce at $40n$ good uranium, then the survivor
stood at initial position $41n - K$.

*Factorio* has more mathematical depth than any other game I've played before.
I hope that this one example demonstrates that.
