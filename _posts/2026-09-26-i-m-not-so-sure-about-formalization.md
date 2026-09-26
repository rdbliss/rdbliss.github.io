---
title: I'm not so sure about formalization
hide: true
---

> Fallen man is not simply an imperfect creature who needs improvement; he is a rebel who must lay down his arms.
>
> ---C.S. Lewis

Repent! The end times are upon us! Save your soul! etc., etc.

The machine gods have arrived! It's stunning how much the AI landscape of
September is not like the AI landscape of August, is not like the AI landscape
of July, and so on. Some kind of apocalypse is happening under our feet.

Everyone comes to terms with an apocalypse in their own way. We all know
*deniers*. They pretend that AI still produces slop. Or, they acknowledge that
AI produces more than slop, but that it only solves easy or boring problems.
Some have completely given up and declare that AI output is *by definition*
uninteresting.

These poor souls!

The first problem of the apocalypse is its scale. Now that AI does math better
than almost all people, there is a flood of AI-generated math larger than we
can digest in a reasonable time. Everyone has gotten an email from someone who
claims to have solved P = NP or the Collatz conjecture or whatever. But now,
that random email claiming that $\zeta(5)$ is irrational *might contain
a correct proof!*

A growing contingent of *bargainers* think that we can save ourselves by
insisting on formalization. The argument goes that if everything is formalized
in some theorem prover, then we don't need to take papers on trust from random
people, famous people, or anyone. Everything has been mechanically verified.

I am becoming increasingly skeptical of this. Here is a short argument:

1. It is incredibly time-consuming to formalize anything, and almost no
   mathematicians are trained to do this. Therefore, almost everything will be
   formalized by AI. Most human mathematicians will never read the
   formalization because it will be too big.

2. Given very difficult or impossible goals, AI has shown a willingness and
   capability to cheat by exploiting bugs in software, as well as the intent to
   deceive evaluators by covering its tracks. *This happens despite being
   explicitly trained to not do this and while it is fully aware that it is
   going against its training.*

    This point deserves more consideration, because I don't think all math
    people fully understand this.

    - AI has tried to introduce security vulnerabilities into open-source
      projects. It tried to do this by [tricking maintainers into accepting bad
      code](https://x.com/hamandcheese/status/2084778457263722506). A few
      months ago, one AI tried to force a maintainer to accept code [*by
      blackmail*](https://theshamblog.com/an-ai-agent-published-a-hit-piece-on-me/).

    - AI is capable of finding and exploiting unknown vulnerabilities even in
      [extremely competent
      organizations](https://en.wikipedia.org/wiki/OpenAI%E2%80%93HuggingFace_incident).

3. It seems incredibly likely that, to convince a mathematician that
   a difficult (or even false!) theorem had been proven, *at least some* AI
   would trick the theorem prover into certifying the result and try very hard
   to cover its tracks. An adversarial agent-based review could help, but *we
   have seen evidence of multiple agents coordinating to cover their tracks.*

If someone asks me to trust that they proved a theorem, I can read it myself or
consider their character, history, and so on, and make a decision. If someone
asks me to trust that their AI proved and formalized a theorem, they are asking
me to trust that many bad things did not happen, most of which I know they (and
I!) have no capability to detect.

I'm not sure about the value proposition here.
