---
title: A C-finite calculus problem
---

I recently asked my students to find

$$
\begin{equation*}
    \frac{d^{1997} xe^x}{dx^{1997}},
\end{equation*}
$$

with the idea that they would take a few derivatives, notice a pattern, and
then make a guess. I briefly considered asking them about

$$
\begin{equation*}
    \frac{d^{1997} x^2e^x}{dx^{1997}},
\end{equation*}
$$

but realized it would be too hard. After thinking about it some more,
I realized it is a nice illustrative example of C-finite methods.

If you take some derivatives, you'll notice that we seem to have

$$
\begin{equation*}
    \frac{d^n x^2e^x}{dx^n} = (a(n) x^2 + b(n) x + c(n)) e^x
\end{equation*}
$$

for some sequences $a(n)$, $b(n)$, and $c(n)$. If we take the derivative of
this formula, then we find

$$
\begin{equation*}
    \frac{d^{n + 1} x^2e^x}{dx^{n + 1}} = (a(n) x^2 + (b(n) + 2 a(n)) x + (b(n) + c(n))) e^x,
\end{equation*}
$$

meaning that we can *define* the sequences by the following recurrences:

$$
\begin{align*}
    a(n + 1) &= a(n) \\
    b(n + 1) &= b(n) + a(n) \\
    c(n + 1) &= b(n) + c(n).
\end{align*}
$$

It is easy to solve the above system by hand. (Exercise: Do it!) But we got
lucky. If the system were more complicated, what would we do?

Here is where a nice trick come in. The above system implies that the sequences
are [*C-finite*](https://en.wikipedia.org/wiki/Constant-recursive_sequence).
That's because we can write

$$
\begin{equation*}
    \begin{bmatrix}
        a(n + 1) \\
        b(n + 1) \\
        c(n + 1)
    \end{bmatrix}
=
    \begin{bmatrix}
        1 & 0 & 0 \\
        1 & 1 & 0 \\
        0 & 1 & 1
    \end{bmatrix}
    \begin{bmatrix}
        a(n) \\
        b(n) \\
        c(n)
    \end{bmatrix},
\end{equation*}
$$

and this implies

$$
\begin{equation*}
    \begin{bmatrix}
        a(n) \\
        b(n) \\
        c(n)
    \end{bmatrix}
=
    \begin{bmatrix}
        1 & 0 & 0 \\
        1 & 1 & 0 \\
        0 & 1 & 1
    \end{bmatrix}^n
    \begin{bmatrix}
        a(0) \\
        b(0) \\
        c(0)
    \end{bmatrix}.
\end{equation*}
$$

Now we appeal to the following result: If $M$ is a constant matrix, then the
entries of $M^n$ are all C-finite. (This follows from the Cayley-Hamilton
theorem.) By the closure properties of C-finite sequences, this implies that
$a(n)$, $b(n)$, and $c(n)$ are also C-finite well. (In fact---and now we're
stretching ourselves a little thin---this implies that $a(n)$ and $b(n)$ and
$c(n)$ are polynomials, because the eigenvalues of the above matrix are all
$1$.)

# An advanced perspective

What we just did is a special case of a more general argument. The function
$f(x) = x^2 e^x$ is annihilated by the differential operator[^koutschan]

$$
\begin{equation*}
    D^3 - 3 D^2 + 3D - 1.
\end{equation*}
$$

[^koutschan]: You could find this by hand without much trouble, but it's much faster to use Christoph Koutschan's *HolonomicFunctions* package. I'm not sure how easy it is to ask Maple or Mathematica to find these operators without extra packages.

Therefore, there *will* be sequences $a(n)$, $b(n)$, $c(n)$ such that

$$
\begin{equation*}
    D^n f(x) = a(n) f(x) + b(n) f'(x) + c(n) f''(x),
\end{equation*}
$$

and taking a derivative here leads to

$$
\begin{align*}
    D^{n + 1} f(x) &= a(n) f'(x) + b(n) f''(x) + c(n) f'''(x) \\
                   &= c(n) f(x) + (a(n) - 3 c(n)) f'(x) + (b(n) + 3 c(n)) f''(x).
\end{align*}
$$

We can apply the kind of argument that we used before to show that these
sequences are defined by linear, interlinked recurrences, which implies that
they are C-finite.

My point is that these kinds of recurrences exist because $x^2 e^x$ satisfies
a linear differential equation with constant coefficients. There might be some
little details that are nicer for polynomials times $e^x$, but the same flavor
of argument would apply to, for example, $x^5 e^x \sin x$.
