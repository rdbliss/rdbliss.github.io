print(`This is dioph.mpl, a Maple package accompanying Robert Dougherty-Bliss' article`):
print(`"Diophantine facts about (6, 28)",`):
print(`dedicated to Natasha Ter-Saakov on her floor(exp(pi))-th birthday.`):
print(`For help, run "ezra();"`):

ezra:=proc()
if args=NULL then
 print(`The main procedures are: goodPells, goodDiophs, intsolns, isGoodPell, badlines`):
 print(`For help with a specific procedure, type 'ezra(procedure_name);'`):

elif nops([args])=1 and op(1,[args])=isGoodPell then
print(`isGoodPell(a, b, u, v): returns true if a (x^2 - u^2) - b (y^2 - v^2) has (u, v)`):
print(`as its first positive integer solution.`):
print(`Try:`):
print(`isGoodPell(109, 5, 6, 28);`):
print(`isGoodPell(109, 5, 6, 27);`):
print(`isGoodPell(4, 1, 6, 28);`):

elif nops([args])=1 and op(1,[args])=goodPells then
print(`goodPells(A, B, u, v, x, y): returns the set of equations`):
print(`a x^2 - b y^2 = (a u^2 - b v^2)`):
print(`such that (x, y) = (u, v) is the first positive integer solution`):
print(`and (a, b) ranges over [A] x [B].`):
print(`Try:`):
print(`goodPells(30, 1, 6, 28, x, y);`):

elif nops([args])=1 and op(1,[args])=intsolns then
print(`intsolns(p, x, y, X, Y): returns the set of roots of p(x, y) in [X] x [Y].`):
print(`Try:`):
print(`intsolns(109 * x^2 - 5 * y^2 - 4, x, y, 6, 28);`):

elif nops([args])=1 and op(1,[args])=badlines then
print(`badlines(u, v, a, b): returns the set of lines in the (a, b) plane`):
print(`such that a x^2 - b y^2 = (a u^2 - b y^2) has (x, y) = (u, v) as the`):
print(`first positive integer solution iff (a, b) avoids all lines.`):
print(`Try:`):
print(`badlines(6, 28, a, b);`):

elif nops([args])=1 and op(1,[args])=goodDiophs then
print(`goodDiophs(p, params, x, y, u, v): returns the Diophantine equations p(x, y) = p(u, v)`):
print(`such that (u, v) is the first positive solution, where p(x, y) depends on a set of parameters.`):
print(`The parameter list is of the form [[a, A], [b, B], ...], where a ranges from 1 to A, b ranges`):
print(`from 1 to B, and so on.`):
print(`Try:`):
print(`goodDiophs(a * x^2 - b * y^2, [[a, 30], [b, 2]], x, y, 6, 28)`):
fi:
end:

isGoodPell := proc(a, b, u, v)
    local c, solns:
    c := a * u^2 - b * v^2:
    if c < 0 then
        return false:
    fi:

    solns := intsolns(a * x^2 - b * y^2 - c, x, y, 6, 28):

    return evalb(solns = {[u, v]}):
end:

# Determine the positive integer solutions to p(x, y) = 0 in [X] x [Y].
intsolns := proc(p, x, y, X, Y)
    local a, b:
    select(L -> subs(x=L[1], y=L[2], p) = 0, [seq(seq([a, b], a=1..X), b=1..Y)]):
end:

badlines := proc(u, v, a, b)
    local x, y:
    {seq(seq(a * (x^2 - u^2) - b * (y^2 - v^2), x=1..u-1), y=1..v-1)}:
end:

avoidLines := proc(pt, lines, a, b)
    andmap(l -> subs([a=pt[1], b=pt[2]], l) <> 0, lines):
end:

goodPells := proc(A, B, u, v, x, y)
    local lines, c, goodPt, goods, a, b, L:
    lines := badlines(u, v, a, b):
    c := pt -> pt[1] * u^2 - pt[2] * v^2:
    goodPt := pt -> c(pt) > 0 and avoidLines(pt, lines, a, b):
    goods := select(goodPt, {seq(seq([a, b], a=1..A), b=1..B)}):

    {seq(L[1] * x^2 - L[2] * y^2 = c(L), L in goods)}:
end:

with(Iterator):
goodDiophs := proc(expr, params, x, y, u, v)
    local goods, bounds, cur_expr, c, p, point, k:
    goods := []:
    bounds := seq([seq(1..p[2])], p in params):

    for point in CartesianProduct(bounds) do
        cur_expr := subs([seq(params[k][1] = point[k], k=1..nops(params))], expr):
        c := subs([x = u, y = v], cur_expr):
        if c < 0 then
            next:
        fi:
        cur_expr := cur_expr - c:
        if intsolns(cur_expr, x, y, u, v) = [[u, v]] then
            goods := [op(goods), cur_expr]:
        fi:
    od:

    goods:
end:
