---
title: COVID Brings Out the Sun for Stormy Petrels Women's Volleyball
hide: true
---

The 2020-2021 season was strange for sports at all levels. Shortened seasons,
cancelled games, and a surplus of "Out (COVID)" on injury reports. It felt like
everyone, from the NBA to your local rec league, just *barely* made their
seasons work. All this disruption produced some amazingly unlikely outcomes,
one of which I'd like to explore here.

The Oglethorpe Stormy Petrels, my alma mater, have a *terrible* women's
volleyball team. I mean *atrocious*. They have not had a winning season in the
past ten years. In that time, they have won only 16 out of 127 possible
in-conference games, and never more than 3 in a single season. This produces
a *12.6%* in-conference win percentage. New coaches, new players, new staff,
it's always the same. They are the absolute bottom of the barrel of the
Southern Athletic Association (SAA), and they have been for a long time.

| Season     | Oglethorpe Conference record |
| ------------------------------ |
| 2020-2021 | 6-5 |
| 2019-2020 | 0-16 |
 | 2018-2019 | 2-12 |
 | 2017-2018 | 2-12 |
 | 2016-2017 | 3-11 |
 | 2015-2016 | 0-14 |
 | 2014-2015 | 3-11 |
 | 2013-2014 | 0-14 |
 | 2012-2013 | 2-12 |
 | 2011-2012 | 3-11 |
 | 2010-2011 | 1-14 |

And yet, I just can't quit them. I've been hooked since my first volleyball
game. Even though they're awful, even though no one goes to the games, even
though I've been gone for a few years, I still hold out hope that maybe, just
maybe, *this* year is the year they turn it around. Well, finally, *this* year
came to pass, and the Stormy Petrels were not a *complete* joke.

In a shortened, conference-only season, the Stormy Petrels went 6-5. This is
their best percentage, first winning season, and best conference ranking in the
past ten years. You may look at 6-5 and say, "Robert, that's only a 55% season.
It took a shortened season, a COVID-depleted conference, and ten years to
*barely* win half of their games." And while, yes, you would be correct, to to
really explain *how exciting* it is that the women went 6-5, we need some
serious context.

# Introducing: *Elo*

For some context as to how awful the Stormy Petrels are, we need to look at the
*other* teams in the SAA. While we could look at their records, national
rankings, or postseason success, there is another, better way to proceed:
*Elo*.

[Elo](https://en.wikipedia.org/wiki/Elo_rating_system) is a numerical system
used to rate the strength of teams. Arpad Elo first introduced it to rank the
strength of chess players, but it is easily adaptable to any head-to-head
competition. Here's how it works.

An "average" team has an Elo score of 1500. Stronger teams have higher scores,
and weaker teams have lower scores. Your score increases if you win a game, and
decreases if you lose a game. Two teams with equal scores have even odds of
winning, having a score of 70 points higher gives you about a 60% chance of
winning, and having a score of 150 points higher gives you about a 70% chance
of winning. The scale isn't linear, but you can get a good sense for how it
works after some examples.

| Elo difference | Win probability for stronger team |
|----------------|-----------------------------------|
|0|50%|
|75|60.5%|
|150|70%|
|300|85%|
|600|97%|

If an average team (Elo 1500) met an above average team (Elo 1600), we'd
predict that the above average team has about a 64% chance to win. If an
average team (Elo 1500) met a *below* average team (Elo 1400), we'd predict
that the average team *also* has a 64% chance to win. **Elo only cares about
*relative* strength, not *absolute* strength.** Now, if a below average team
(Elo 1400) met an above average team (Elo 1600), we'd give the stronger team
a nearly 76% chance to win.

Like I said, you get a higher Elo score by winning games, and a lower score by
losing games. How much your score changes depends on the following ideas:

1. A strong team beating a weak team gets a small score bump. (We expect strong
   teams to beat weak teams.)

2. A strong team beating a strong team gets a moderate score bump. (We learn
   about the strong teams, but not their relation to a third, weaker team.)

3. A weak team beating a strong team gets a *big* score bump. (This is the most
   surprising situation.)

The exact score chance depends on the implementation of Elo. What never changes
is that Elo is a zero-sum game: The loser's score goes down the exact amount
the winner's goes up.

With this description of Elo out of the way, let's see the main highlight.

![Elo scores](/images/elo.png)

Using data compiled from the 2012-2013 season to the 2019-2020 season, I have
computed the Elo scores of every women's volleyball team in the SAA. Six of
them are plotted above. The graph shows a very clear divide into three groups:

1. **The pack leaders,** Berry, Birmingham-Southern, and Hendrix. These teams
   have always been at least average, and have been moderately to very strong
   in recent years.

2. **The declining fighters,** Centre and Millsaps. These teams were good
   a while ago, but have been in a sharp decline recently. They are firmly below average.

3. **The Stormy Petrels.** Oglethope has been very weak for the *entire* period
   in question. They are, without a doubt, the dregs of the SAA.

Now that we have some context for how bad the Stormy Petrels are, 6-5 doesn't
sound so bad, does it? Why, after looking at that graph, 6-5 is like winning
the SAA championship! How does Oglethorpe's Elo look after this miraculous
winning season?

![Elo redux](/images/elo2.png)

Wow! Oglethorpe's Elo *skyrocketed* after this barely-winning year. The wins
came from Centre (x2), Rhodes, and Millsaps. The losses came from
Birmingham-Southern (x3), Rhodes, and Hendrix. Except for Rhodes, which nearly
cancels out, the losses were to teams so overpowered it barely lowered
Oglethorpe's rating. The wins, since Oglethorpe had such a meagre rating,
produced a lot more.

# A postseason shocker: simulating with Elo

The *real* shocker is that 6-4 was enough to put the Stormy Petrels into the
SAA playoffs as the fourth best team. (The playoffs this year were different,
since only the best four teams played.) However, this scenario was fairly
predictable, and we can quantify that by *simulating* the 2020-2021 season.

Once we know the Elo score of two teams, we can simulate a matchup between them
by flipping a biased coin. If Elo says the stronger team has a 75% chance to
win, then we flip a coin that comes up heads 75% of the time, and tails 25% of
the time. If we see heads, then the stronger team "won," and otherwise they
lost. Proceeding in this way, we can simulate an entire season of games as long
as we know the Elo scores of the teams involved to a sufficiently high
accuracy.

So, I did that. I simulated the 2020-2021 season 10,000 times and figured out
how likely it was that each team made the playoffs. Oglethorpe always had
around a 20% chance, which is probably their best chance at finishing top-4 in
a *long* time. The three top-dogs (Berry, Birmingham-Southern, Hendrix) also
made the playoffs, so Oglethorpe had to leap over the middle-of-the-pack teams
(Centre, Rhodes, Millsaps) to get fourth place.

| Team | Probability of top-4 SAA finish |
|----------------------------------------|
|Berry|                  97.92% |
|Birmingham-Southern|    96.78% |
|Hendrix|                85.73% |
|Millsaps|               53.29% |
|Centre|                 26.08% |
|Rhodes|                 21.09% |
|Oglethorpe|             19.11% |

A 20% event happens, on average, once every five times, so it isn't so crazy
that Oglethorpe would make the top-4. Of course, going any further than the
first round would probably require beating a big-dog team, and accordingly the
probability that Oglethorpe would win the SAA title was exceedingly small.

| Team | Probability of winning SAA title |
|------------------------------------------|
|Berry|                  38.73%|
|Birmingham-Southern|    34.09%|
|Hendrix|                18.22%|
|Millsaps|               4.17%|
|Centre|                 2.72%|
|Rhodes|                 1.31%|
|Oglethorpe|             0.76%|

# What's next for the Stormy Petrels?

Hot off their highest finish in a decade, where do the Stormy Petrels go? While
we don't know for sure, all the machinery I've laid out here will enable us to
make predictions about the next season. As soon as the full schedule is
released I'll be churning out these predictions.

My mind tells me that the likeliest outcome is for Oglethorpe to have
a terrible year, like we always do. My heart tells me that we're going to win
it all, baby.
