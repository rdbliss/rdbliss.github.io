---
title: Ergonomics in computer science
date: 2019-02-15
tags:
    - computer algebra
    - expressive complexity
---

In computer science we often care about *computational complexity*. How long
will an algorithm take asymptotically? How will it perform on average? In
essence, *how fast can we go?* Though this is an important consideration, it
omits a crucial implementation detail: the human factor. Is the algorithm
painful or tedious to write? Is it overly complicated for the average
programmer? That is, *is it ergonomic to use?* It is easy to demand that
performance trumps all, but this is a costly mistake. Tools and environments
must account for human factors; programming languages are no exception.

Ergonomics is the study of human relationship with work. It seeks to make
necessary burdens easier and more enjoyable. This goal is based upon the
observation that "long faces are not always efficient, nor are smiling ones
idle"[^hancock] .
Ergonomics considers physical and psychological *human factors*, such as
comfort and stress, respectively. It may, for example, suggest appropriate
levels and types of lighting for the workplace to improve morale, or recommend
chairs with a certain amount of back support to avoid long-term injury. This is
all to improve the human condition and workplace efficiency.

[^hancock]:
    ["On the Future of
    Work."](https://peterhancock.ucf.edu/on-the-future-of-work/) Peter Hancock,
    1997.

It is important to remember ergonomics is not confined to study physical
factors. Beginning in the 1970s, researchers in ergonomics began to study
*mental workload*. Roughly, this is how mentally taxing certain tasks are. If
a worker's mental workload is too high, they are likely to make mistakes or
"burnout" faster than a relaxed employee. The following is a more technical
definition:

> [Mental workload is] the relation between the function relating the mental
resources demanded by a task and those resources available to be supplied by
the human operator[^parasurman].

[^parasurman]:
    ["Situation Awareness, Mental Workload, and Trust in
    Automation."](http://alltvantar.com/SA%20contents/Situation%20awareness%20mental%20workload%20and%20trust%20in%20automation%20-%20Viable%20empirically%20supported%20cognitive%20engineering%20constructs.pdf)
    Parasuraman et al., 2008.

This problem is not constrained to office workers. Two studies in aviation
accidents found that as much as 18% of pilot errors related to reading
instruments were due to confusing instrument design that made it difficult for
pilots to understand their readouts[^handbookhuman].

[^handbookhuman]: *Handbook of Human Factors and Ergonomics*, 4th edition, pg. 244.

This is all to say that the tools we use and the tasks we complete should be
simple and easy to understand. The consequences of ignoring this can range from
decreased worker productivity and longevity, to introducing grave, avoidable
mistakes.

Consideration of mental workload is especially important in programming
language design. Programming, more than other activities, is centered around
thought. Its primary tool, the programming language, is a means to express
computational thought in a way that the computer can understand. The task of
the programmer is to mentally construct a solution to a problem, then translate
this mental solution into a concrete programming language[^1]. It is this
translation step that increases mental workload.

[^1]:
    Of course, in actuality the lines are blurred. The programmer may have an
    idea of how to solve the problem in a mechanical way, and then later build
    a complete mental solution. That is, once a programmer becomes adept at
    thinking "like the machine," they can use that intuition to build
    solutions.

As an example, consider a student beginning to learn programming. They must
learn the mantra that computers are "stupid," and will only do exactly as they
are told, and no more. They must learn to translate their mental solutions into
mechanical steps. Along the way they learn how to think in terms of this
translation. The successful student will overcome this initial hurdle, but the
mental workload of translation is always present. The mental workload that
remains is largely a function of the programming language a programmer uses.

In the context of software, I call the contributions to this mental workload
*expressive complexity*, in opposition to traditional *computational
complexity*. Expressive complexity, then, measures how complicated algorithms
are to implement, how difficult a language is to use, and how much mental
strain is imposed on a programmer by these objects.

# Examples

Consider the following task: Sum the integers from 1 to 100. Here are three
solutions:

### [Haskell](https://www.haskell.org/)

```haskell
sum [1..100]
```

### [Python](https://www.python.org/)

```python
sum(range(101))
```

### [C](https://en.wikipedia.org/wiki/C_(programming_language))

```c
int sum = 0;
for(int k = 0; k <= 100; k++) {
    sum += k;
}
```

All three solutions have the same computational complexity. However, they
clearly differ in their *expressive complexity*. The Haskell and Python
solutions are almost exact 1-1 translations of the obvious solution: Just sum
the integers from 1 to 100. In particular, the programmer does not have to
think about *explicit iteration*, which is how computers think. Instead, they
can essentially write down their mental solution.

In comparison, the C solution is very mechanical. It shows how the *computer*
thinks of the process of summing integers, rather than how the *programmer*
thinks of it. A separate `sum` variable must be accounted for, because
computers must do such things, not because humans must do such things.

This example shows that expressive complexity is not just a feature of
a particular algorithm, but rather a feature of particular *languages*. We may
thus compare languages by their expressive complexity and decide which best
suit our purpose.

There are a number of ways to measure expressive complexity. The earliest is
the [Halstead
metrics](https://en.wikipedia.org/wiki/Halstead_complexity_measures), a set of
metrics invented by Maurice Halstead to put this type of comparison on firmer
footing. These metrics include measures such as "difficulty," "effort," and
"vocabulary."

# Looking forward

My undergraduate thesis compares the expressive complexity of certain popular
computer algebra systems. I chose this topic because I am deeply interested in
the applications of computers to mathematics, and hope to develop a framework
to help choose the "best" computer system.

Outside of my own efforts, it seems clear that ergonomically-minded languages
are on the rise. Though languages like C and [Java][java] are the most popular
right now, they are losing some ground. Many programming language research
groups are focusing on newer, functional languages like Haskell and
[F#][fsharp]. Python is becoming an increasingly popular first language for
people to learn, and has an enormous community with a great set of ergonomic
libraries. The historical trend shows an improvement that hopefully continues.

[java]: https://en.wikipedia.org/wiki/Java_(programming_language)
[fsharp]: https://fsharp.org/
