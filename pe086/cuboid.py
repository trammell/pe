#!/usr/bin/env python2.4

def gcd(a,b):
    if b: return gcd(b,a % b)
    else: return a

def are_legs(a,b):
    # exactly one of a,b is odd
    if (a + b) % 2 == 0:
        return False

def find_triple(a,b,c):
    if (a, b+c)


def f(m):
    n = 0
    for p in range(1,m+1):
        for q in range(1,p+1):
            pq = p * q
            pm = p * m
            qm = q * m
            if q < m and p < m:     # thus pq < pm, qm



            elif




            # need to find the smallest of
            #   (p+q)^2 + m^2 = p^2 + 2pq + q^2 + m^2
            #   (p+m)^2 + q^2 = p^2 + 2pm + q^2 + m^2
            #   (q+m)^2 + p^2 = p^2 + 2qm + q^2 + m^2
            # equivalent to smallest of pq, pm, qm

            if find_triple(q,p,m):
                n += 1
    return 3

def main():
    sum = 0
    for m in range(101):
        x = f(m)
        sum += x
        print "%3d %4d %7d" % (m,x,sum)

if __name__ == '__main__':
    main()

