---
title: Factorio and the Josephus problem
hide: true
---

Don't tell my advisor / employer / students, but I have been playing a lot of
the excellent game [*Factorio*](https://www.factorio.com/) lately. *Factorio*
is a factory management simulator where you escape an alien world by automating
the harvesting of natural resources to build a rocket. Moreso than most
management games, *Factorio* focuses on the logistical problems of running
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
These probabilities make the setup for nuclear power very slow.

Things liven up once you generate 40 good uranium. Then, via another late-game
technology, you can put 40 good uranium into a machine that spits out 41 good
uranium. This is 41 *total* good uranium---the 40 you put in plus one new one.
It doesn't sounds like much but multiplying your supply by $41 / 40$ forever
would lead to exponential growth.

Unfortunately, this is not how things work. The process to turn 40 good uranium
into 41 good uranium only works on 40 uranium at a time per machine you have to
run it. The first time you run it you will have 41 good uranium, but you can
only put exactly 40 back into the process. The lone new uranium sits there,
useless.

This brings us to the neat question. If you had infinitely many machines to run
this process, then the amount of good uranium at step $n$ is given recursively
by

$$
\begin{align*}
    U_0 &= 40 \\
    U_{n + 1} &= U_n + \left \lfloor \frac{U_n}{40} \right \rfloor
        = \left \lfloor \frac{41}{40} U_n \right \rfloor.
\end{align*}
$$

What is the asymptotic value of $U_n$?

A good idea is to ignore the floor and guess that the answer is close to $(41
/ 40)^n \cdot 40$ anyway. This is wrong, but it's not *that* wrong.

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
studying similar sequences.

Adapting the ideas in Wilf's paper, it turns out that $U_n$ *is* exponential
but smaller than $(41 / 40)^n \cdot 40$. There is a constant $c$ such that

$$U_n \sim (41 / 40)^n 40 c \quad ; \quad c = 0.574256\dots$$

So you lose about 43% of your exponential capacity to waiting, but this is
still pretty good!

The constant $c$ does not seem to be expressible in terms of anything
well-known. There is a "formula," but it is useless for practical purposes.

# Connection to the Josephus problem

Unsurprisingly, Wilf and Odlyzko were not considering uranium processing in
*Factorio*. They were working on a solution to the Josephus problem.

The Josephus problem is this: Arrange $n$ people in a circle and execute every
$q$th person until there is only one left. Where should you stand in the
initial circle to be the surviving person? This position is called $J_q(n)$.
The $q = 2$ case has the famous solution $J_2(n) = 2(n - 2^{\lfloor \log_2
n \rfloor}) + 1$, but there aren't closed forms beyond that.

[*Concrete Mathematics*](https://en.wikipedia.org/wiki/Concrete_Mathematics)
has a neat algorithm to solve this problem. Once you pass over someone, move
their index to the smallest index not yet seen. (If $q = 3$ then $1$ will
become $n + 1$ and $2$ will become $n + 2$.) The last person to be executed
will have the label $qn$, so you just need to determine the original index of
the person who is eventually labeled $qn$. The sequences of Wilf and Odlyzko
help do this.

Our sequence helps solve a similar Josephus-type problem. Arrange $n$ people in
a circle and execute every $q$th person *starting from the first one*. That is,
you will always execute the first person, then count off by $q$ from there.
Under the same relabeling scheme as before, the last person to be executed will
have label $q(n - 1) + 1$. It turns out that the label of this person after
going in "reverse" $k$ steps is $qn - U_k^{(q)}$, where $U_k^{(q)}$ is defined
by

$$
\begin{align*}
    U_0^{(q)} &= q - 1 \\
    U_k^{(q)} &= \left\lfloor \frac{q}{q - 1} U_{k - 1}^{(q)} \right\rfloor.
\end{align*}
$$

This sequence solves the problem because we can stop computing as soon as
$qn - U_k^{(q)} \leq n$. That is, as soon as $U_k^{(q)} \geq (q - 1)n$.

This sequence is also exactly the same form as our uranium sequence if we set
$q = 41$. That is, when we are producing good uranium in *Factorio*, we are
implicitly solving this modified Josephus problem where we execute every
forty-first person. If you have $U$ good uranium the first time that you cross
$40n$, then then the survivor stood at initial position $41n - U$.

This is not quite proving that *Factorio* is Turing complete ([it
is](https://www.reddit.com/r/factorio/comments/43giwy/i_made_a_programmable_turingcomplete_computer_in/)),
but it is a neat fact to notice. *Factorio* has more mathematical depth than
any game I've played before. I hope that this one example demonstrates that.
