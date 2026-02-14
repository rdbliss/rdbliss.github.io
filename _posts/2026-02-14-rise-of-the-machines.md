---
title: Rise of the machines
---

> Dear Children,
>
> Do you know that until fifty years ago most of mathematics was done by
humans? Even more strangely, they used human language to state and prove
mathematical theorems. Even when they started to use computers to prove
theorems, they always translated the proof into the imprecise human language,
because, ironically, computer proofs were considered of questionable rigor!
>
> ---Plane  Geometry: An Elementary Textbook By SHALOSH  B.  EKHAD, XIV (circa  2050)
>
> [Downloaded  from  the  future](https://sites.math.rutgers.edu/~zeilberg/PG/gt.html) by DORON ZEILBERGER

A few weeks ago I printed out a copy of Zeilberger's [Opinion 102: Some Soul
Reckoning on Yom
Kippur](https://sites.math.rutgers.edu/~zeilberg/Opinion102.html) and taped it
to the wall in my office. In that opinion, Zeilberger argues that many, perhaps
most, theorems we want to prove are too complicated for humans to tackle. His
thesis is that we would be better off spending our time training computers to
prove theorems for us.

Boy, was he right! GPT is [doing physics
research](https://openai.com/index/new-result-theoretical-physics/). Tao is
[integrating AI into his
work](https://www.renaissancephilanthropy.org/news-and-insights/is-math-the-next-ai-frontier-a-conversation-with-terence-tao).
Undergrads are [solving Erdős problems by typing them into
ChatGPT](https://github.com/teorth/erdosproblems/wiki/AI-contributions-to-Erd%C5%91s-problems).
We might look back on Zeilberger's fantastical 2050 prediction and say that it
was *too conservative*.

As a mathematician, that last point about Erdős problems is really astounding.
Just in the first two months of 2026, AI has helped solved at least two
nontrivial Erdős problems. One was [Problem
205](https://www.erdosproblems.com/205):

> Can all sufficiently large $n$ be written as $n = 2^k + m$ where $m$ has less than $\log \log m$ prime divisors (counted with multiplicity)?

The answer is no. This was found by essentially asking a recent version of GPT
to construct a counterexample, which it did and then formalized in Lean. You
can read the
[comments](https://www.erdosproblems.com/forum/thread/205?order=oldest) on the
problem and watch Tao and others realize in real-time how the counterexample
works.

Admittedly this was not a serious, capital-E-capital-P Erdős Problem, but it
feels ridiculous to entirely discount it. A few years ago I watched an early
ChatGPT stumble on basic real analysis theorems, and now I'm saying "well it
didn't solve a *real* Erdős problem."

Zeilberger was right! He was right in 2009 when he wrote Opinion 102, before
anyone knew what an LLM was, he was right in 2001 when we wrote a science
fiction story predicting that all math would be automatically done by
computers, and he was right in 1993 when he wrote ["Theorems for a price:
tomorrow's semi-rigorous mathematical
culture"](https://sites.math.rutgers.edu/~zeilberg/mamarim/mamarimhtml/priced.html).
He's still right today!

# More about AI

I want to explain some technical reasons that I think AI is becoming much more
useful. The Erdős problems are interesting, but not what I care about. (Maybe
we eventually get serious AI-produced math on a large-scale, but for now it's
just pockets of isolated people working very hard to make it work. Casual
attempts fail pretty badly.)

AI has become very good at running semi-autonomous computational experiments.

In February 2026, it is almost trivial to have AI design, write, and run code
for you. I do not mean talking to a web-interface and copying code. I mean that
the AI will create files on your machine, run them, and report back on the
output. If you're a good programmer, it probably won't write code *better* than
you, but it will certainly write something that works, and it will write it
much faster than you.

I don't want to oversell anything, so let me just give a small example.

In a current project, I'm interested in these two sums:

$$
\begin{align*}
    a_r(n, k) &= \sum_{d \mid \gcd(n, k)} {n / d \choose k / d} B_r(d) \\
    b_r(n, k) &= \sum_{d \mid \gcd(n, k)} {n / d \choose k / d} B_r(d) (-1)^{k/d + k}.
\end{align*}
$$

This function $B_r(d)$ is a number-theoretic function:

$$B_r(d) = \sum_{d \mid \gcd(r, d)} j \mu(d / j).$$

You'll note that the sums defining $a_r(n, k)$ and $b_r(n, k)$ are *very*
similar. They only differ by this $(-1)^{k / d}$ term. The $B_r(d)$ function is
not nonnegative, so there's a chance that these two sums are sometimes equal.
When?

I wrote exactly this[^polite] to [Claude](https://claude.ai/):

```
hi claude!

In a current project, I'm interested in these two sums:

$$
\begin{align*}
    a_r(n, k) &= \sum_{d \mid \gcd(n, k)} {n / d \choose k / d} B_r(d) \\
    b_r(n, k) &= \sum_{d \mid \gcd(n, k)} {n / d \choose k / d} B_r(d) (-1)^{k/d + k}.
\end{align*}
$$

This function $B_r(d)$ is a number-theoretic function:

$$B_r(d) = \sum_{d \mid \gcd(r, d)} j \mu(d / j).$$

You'll note that the sums defining $a_r(n, k)$ and $b_r(n, k)$ are *very*
similar. They only differ by this $(-1)^{k / d}$ term. The $B_r(d)$ function is
not nonnegative, so there's a chance that these two sums are sometimes equal.
When?

Write and run short python script that reports on equalities up to n <= 30,
with 0 <= k, r <= n. Look for patterns.
```

[^polite]: Why did I say `hi claude!`? Would you be rude to your boss?

Claude wrote a Python script that computed these sums, ran it, analyzed the
output, and reported this:

```
======================================================================
CONCLUSIONS:
======================================================================

1. If k is ODD, then a_r(n,k) = b_r(n,k) ALWAYS (regardless of n, r).

2. If k is EVEN, then a_r(n,k) may or may not equal b_r(n,k).
   They differ when:

   sum_{d | gcd(n,k), k/d odd} binom(n/d, k/d) * B_r(d) ≠ 0

   This sum involves only those divisors d where k/d is odd.
   Since B_r(d) can be positive, negative, or zero, these terms
   can cancel each other out, making the sums equal even when
   k is even.

3. The key is that B_r(d) depends on gcd(r, d), so the equality
   depends on the specific relationship between r and the divisors
   of gcd(n, k).

4. SIMPLEST CHARACTERIZATION:
   - a_r = b_r always when k is odd
   - a_r = b_r when k is even AND the weighted sum of B_r values
     over odd quotients vanishes
```

I then asked Claude to show me a table of the difference $a_2(n, k) - b_2(n,
k)$ up to $n = 20$, and it gave me this:

```
Differences: a_2(n,k) - b_2(n,k) for n <= 20, r = 2
==========================================================================================

     k =   0   1   2   3   4   5   6   7   8   9  10  11  12  13  14  15  16  17  18  19  20
n    ------------------------------------------------------------------------------------
 1 |   .   .
 2 |   .   .   2
 3 |   .   .   .   .
 4 |   .   .   4   .  -4
 5 |   .   .   .   .   .   .
 6 |   .   .   6   .   .   .   .
 7 |   .   .   .   .   .   .   .   .
 8 |   .   .   8   .  -8   .   8   .   .
 9 |   .   .   .   .   .   .   .   .   .   .
10 |   .   .  10   .   .   .  20   .   .   .   .
11 |   .   .   .   .   .   .   .   .   .   .   .   .
12 |   .   .  12   . -12   .  36   .   .   .  12   .   .
13 |   .   .   .   .   .   .   .   .   .   .   .   .   .   .
14 |   .   .  14   .   .   .  70   .   .   .  42   .   .   .   .
15 |   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .
16 |   .   .  16   . -16   . 112   .   .   . 112   . -16   .  16   .   .
17 |   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .
18 |   .   .  18   .   .   . 162   .   .   . 252   .   .   .  72   .   .   .   .
19 |   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .   .
20 |   .   .  20   . -20   . 240   .   .   . 500   . -40   . 240   .   .   .  20   .   .

Legend: '.' means a_r = b_r (difference is 0)

Key Observations from the Table:

1. **All odd columns (k = 1, 3, 5, 7, 9, ...)** are entirely dots - confirming
   that a_2(n,k) = b_2(n,k) whenever k is odd.

2. **Even k = 0**: Always 0 (special case - binomial coefficients make this
   trivial)

3. **Even k = 2**: Nonzero differences appear only when gcd(n,2) = 2 (i.e.,
   when n is even). The pattern is diff = 2 · C(n/2, 1) · B_2(2) = 2 · (n/2)
   · 1 = n.

4. **Even k = 4**: Nonzero differences only when 4 | n. We get diff
   = 2 · C(n/4, 1) · B_2(4) = 2 · (n/4) · (-2) = -n.

5. **Even k = 6**: More interesting! When n = 6, the terms cancel: d=2
   contributes +2 and d=6 contributes -2, giving difference 0.

6. **Even k = 8, 16, 20**: All zeros for r=2 because B_2(8) = B_2(16) = B_2(20)
   = 0 (since gcd(2,8) = 2 and the Möbius sum vanishes).

7. **Diagonal pattern**: Notice that the differences grow roughly with n when
   they're nonzero, and there's a beautiful symmetry in some columns (e.g.,
   k=16 has the pattern ..., -16, 0, 16, ...).

The table clearly shows that for r=2, most cases have a_2 = b_2, and when they
differ, the differences follow predictable arithmetic patterns based on the
divisibility structure!
```

This is all great stuff!

Now, I should say that the problem here was pretty simple. I could have done
this experiment myself with better, easier to read code. I could probably get
more explicit conjectures than Claude by feeding the results into some other
programs, or just looking at them a little harder. But it would take me some
time and thought to do this, and Claude did all the preliminary work in about
five minutes. All I did was describe what I wanted[^mistake].

[^mistake]: Did you catch that I made a mistake? I said that the sums were the same except for a factor of $(-1)^{k/d}$, but it's actually $(-1)^{k / d + k}$. Claude caught this and fixed it for me!

This situation reminds me of an old programmer's joke:

```c
int main(int argc, char *argv[])
{
    ...
    // I'm starting to think the compiler isn't reading my comments...
    ...
}
```

It seems impossible to believe, but we might be approaching a world where the
compiler *only* reads your comments. As long as I can remember, we said that
computers were stupid. That they can only follow simple, direct instructions,
and that our job is to arrange these instructions into complicated patterns to
get what we want. We were using punched cards to program computers only fifty
or sixty years ago! All of this is out the window. We have thinking machines.

How far is this going to go? Where will we eventually put AI on the "historic
inventions" leaderboard? Are they more impactful than the internet? Oral
contraceptives? Nuclear weapons? The printing press? *Stone tools?*

Maybe in ten years we can look back on this whole thing and laugh. Or maybe the
[AI 2027](https://ai-2027.com/) people are right and we should panic, even
though I thought they were insane just a year ago. I don't know. Either way, we
were warned:

> There are writings on the wall that, now that the silicon savior has arrived,
a new testament is going to be written. 
>
> [THEOREMS FOR A PRICE: Tomorrow’s Semi-Rigorous Mathematical Culture](https://arxiv.org/pdf/math/9301202)
>
> ---Doron Zeilberger, 1991

Happy Valentine's Day!
