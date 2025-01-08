---
title: Arithmetic performance in the Chinese Remainder Theorem
date: 2025-01-07
---

There's a common belief in the analysis of algorithms that arithmetic
operations take roughly [constant
time](https://en.wikipedia.org/wiki/Analysis_of_algorithms#Cost_models). This
is true when working with types of a fixed size, like 64-bit integers, but
wrong for "big" problems.

In "big" problems we encounter objects with *unbounded* sizes. Arbitrary length
integers, arbitrary degree polynomials, recurrence relations of arbitrary
orders, and so on. In these problems it matters how long it takes to do
operations on objects of different sizes. The Chinese Remainder Theorem is
a good example of this.

The Chinese Remainder Theorem (CRT) states that the system of congruences

$$
\begin{align*}
    x &\equiv a_1 \pmod{m_1} \\
    x &\equiv a_2 \pmod{m_2} \\
    &\cdots \\
    x &\equiv a_n \pmod{m_n}
\end{align*}
$$

has a unique solution $x$ modulo $m_1 m_2 \cdots m_n$. The term "CRT" also
refers to the process of *finding* the smallest solution, and this is where
things get interesting.

In one sense, CRT can be done in "constant time." If we set $M = m_1 \cdots
m_n$, then we can write down an explicit solution:

$$x = \sum_{k = 1}^n a_k \frac{M}{m_k} \left( \left(\frac{M}{m_k}\right)^{-1} \bmod m_k \right).$$

The $k$th term is divisible by $m_i$ for every $i \neq k$, and is congruent to
$a_k$ modulo $m_k$, so we're done!

This solution looks "constant time" because it seems to require a fixed number
of arithmetic operations, but each implied arithmetic operation operates on
arbitrary length integers, and we need to consider how long these things take.

To get a sense for how things can break down, consider the system

$$
\begin{align*}
    x &\equiv 1 \pmod{2} \\
    x &\equiv 2 \pmod{3} \\
    x &\equiv 3 \pmod{5} \\
      &\cdots \\
    x &\equiv n \pmod{p_n},
\end{align*}
$$

where $p_n$ is the $n$th prime. For $n = 6$, the formula gives

$$x = 15015 + 40040 + 18018 + 102960 + 81900 + 41580 = 299513.$$

This is the correct answer, but way bigger than the smallest one. Each term of
the summand is about the same order of magnitude as the modulus $2 \times
3 \times 5 \times 7 \times 11 \times 13 = 30030$, so this is *guaranteed* to be
much bigger than the smallest answer. In fact, if the modular inverses behave
randomly, then the $k$th term of our sum would be, on average, $k M / 2$. This
would give our formula an approximate magnitude of $M \times (n^2 / 4)$, when
we know the real answer can't be bigger than $M$ itself!

The worst part about the formula, performance-wise, is *not* its too-big
answer---we can reduce that with a single division. The worst part is that
there are $n$ inverses $(M / m_k)^{-1} \bmod m_k$ to compute, and the numbers
$M / m_k$ can be pretty big.

There is a CRT algorithm which slightly sidesteps this issue. The idea is to
write our solution in "mixed radix" form

$$x = d_0 + d_1 m_1 + d_2 m_1 m_2 + \cdots + d_{n - 1} m_1 m_2 \cdots m_{n - 1},$$

which is unique if we stipulate $0 \leq d_k < m_{k + 1}$. Then our original
system turns into the following triangular one:

$$
\begin{align*}
    d_0 &\equiv a_1 \pmod{m_1} \\
    d_0 + d_1 m_1 &\equiv a_2 \pmod{m_2} \\
    d_0 + d_1 m_1 + d_2 m_1 m_2 &\equiv a_3 \pmod{m_3} \\
    &\cdots \\
    d_0 + d_1 m_1 + d_2 m_1 m_2 + \cdots + d_{n - 1} m_1 \cdots m_{n - 1} &\equiv a_n \pmod{m_n}.
\end{align*}
$$

We can solve this system from top to bottom for the $d_k$. In the first step we
need no modular inverses, in the second we need to invert $m_1 \bmod m_2$, in
the third we need to invert $m_1 m_2 \bmod m_3$, in the fourth $m_1 m_2 m_3
\bmod m_4$, and so on.

The difference between the two methods is that the formula computes inverses of
numbers that are all around the same size, while the triangular approach starts
with small numbers and works up to big ones.

# Implementations and profiling

Below are implementations of the formula-based method and the triangular system
method in Python, using `sympy` for modular inverses and prime calculations.
It's ready to be run with `line_profiler`, though I've done that and put the
outputs below.

```python
from math import prod
from sympy import prime, primepi, log, primerange, mod_inverse
from line_profiler import profile
from itertools import islice
from functools import cache

@profile
def naiveCRT(ims, mods):
    M = prod(mods)

    terms = []

    for im, mod in zip(ims, mods):
        a = M // mod
        b = mod_inverse(a, mod)
        term = im * a * b
        terms.append(term)

    soln = sum(terms)
    smallest = soln % M

    return terms, soln, smallest

@profile
def triangularCRT(ims, mods):
    ds = []

    part_sum = 0
    part_prod = 1
    for im, mod in zip(ims, mods):
        inv = mod_inverse(part_prod, mod)
        new_d = (im - part_sum) * inv
        new_d %= mod
        ds.append(new_d)
        part_sum += ds[-1] * part_prod
        part_prod *= mod

    return part_sum

def testSystem(n, naive=True):
    # sympy is not very good at generating the first n primes. this is a faster
    # method.
    k = 2
    while primepi(int(k * n * log(n))) < n:
        k += 1

    ims = list(range(1, n + 1))
    ps = list(islice(primerange(int(k * n * log(n))), n))
    if naive:
        return naiveCRT(ims, ps)

    return triangularCRT(ims, ps)

if __name__ == "__main__":
    testSystem(50000, True)
    testSystem(50000, False)
```

And the profiling results:

```python
Timer unit: 1e-06 s

Total time: 17.2698 s
File: /home/rdb/crt.py
Function: triangularCRT at line 24

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
    24                                           @profile                                 
    25                                           def triangularCRT(ims, mods):            
    26         1          1.4      1.4      0.0      ds = []                              
    27                                                                                    
    28         1          0.3      0.3      0.0      part_sum = 0                         
    29         1          0.2      0.2      0.0      part_prod = 1                        
    30     50001       8836.1      0.2      0.1      for im, mod in zip(ims, mods):       
    31     50000   12761469.0    255.2     73.9          inv = mod_inverse(part_prod, mod)
    32     50000     928981.4     18.6      5.4          new_d = (im - part_sum) * inv    
    33     50000    2329583.1     46.6     13.5          new_d %= mod                     
    34     50000       6508.7      0.1      0.0          ds.append(new_d)                 
    35     50000     779081.8     15.6      4.5          part_sum += ds[-1] * part_prod   
    36     50000     455358.8      9.1      2.6          part_prod *= mod                 
    37                                                                                    
    38         1          0.5      0.5      0.0      return part_sum                      


Total time: 35.5329 s
File: /home/rdb/crt.py
Function: naiveCRT at line 7

Line #      Hits         Time  Per Hit   % Time  Line Contents
==============================================================
     7                                           @profile                          
     8                                           def naiveCRT(ims, mods):          
     9         1     464805.5 464805.5      1.3      M = prod(mods)                
    10                                                                             
    11         1          1.5      1.5      0.0      terms = []                    
    12                                                                             
    13     50001      11683.0      0.2      0.0      for im, mod in zip(ims, mods):
    14     50000    4864532.1     97.3     13.7          a = M // mod              
    15     50000   27588076.0    551.8     77.6          b = mod_inverse(a, mod)   
    16     50000    1885445.3     37.7      5.3          term = im * a * b         
    17     50000       9369.0      0.2      0.0          terms.append(term)        
    18                                                                             
    19         1     708921.2 708921.2      2.0      soln = sum(terms)             
    20         1         80.7     80.7      0.0      smallest = soln % M           
    21                                                                             
    22         1          1.7      1.7      0.0      return terms, soln, smallest  


 17.27 seconds - /home/rdb/crt.py:24 - triangularCRT
 35.53 seconds - /home/rdb/crt.py:7 - naiveCRT

```

For $n = 50,000$, the triangular method was around twice as fast, mostly
because the bulk of the runtime is in computing the modular inverses, and the
triangular method was twice as fast on average in this part.

Ignoring the inverses, the inner loop in the formula method took approximately
130 microseconds per iteration and only 90 microseconds in the triangular
method. This is a less favorable comparison, but it's clear that even caching
the inverses beforehand would not save the formula.

# Back of the envelope calculations

The product of the first $n$ primes is something like $n^n$, which has $O(n
\log n)$ bits. Thus $M / m_k$ has something like $O(n \log n)$ bits, and
computing a modular inverse of this number with the Euclidean algorithm might
cost about $O(n^2 \log^2 n)$, which we need to do $n$ times. This puts the
total runtime of the formula approach at around $O(n^3 \log^2 n)$.

For the triangular method, our cost will be something like

$$
\begin{equation*}
    \sum_{k = 1}^n (k \log k)^2.
\end{equation*}
$$

There should probably be $O$'s here, and constants are floating around, but the
point is that this sum works out to be a constant factor smaller than $n^3
\log^2 n$. Maple can compute the following asymptotic ratio:

$$
\begin{equation*}
    \frac{\sum_{k = 1}^n (k \log k)^2}{n^3 \log^2 n}
    =
    \frac{1}{3} + O \left( \frac{1}{\log n} \right).
\end{equation*}
$$

So, at least for inverses, the triangular method should take around a third of
the time for large $n$, but it approaches that point pretty slowly.
