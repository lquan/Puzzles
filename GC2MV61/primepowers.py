import itertools
from sympy import primerange


"""Generate prime powers smaller than m"""
def prime_power_generator(m: int):
    for p in primerange(1, m):
        pe = p
        while pe < m:
            yield pe
            pe *= p


def main():
    n = 6
    min_num = 10**(n-1)
    max_num = 10**n
    prime_powers = list(i for i in prime_power_generator(max_num) if i >= min_num and '0' in str(i))
    print(f"prime powers: (len={len(prime_powers)})")
    
    s = "{" + ",".join(str(i) for i in prime_powers) + "}"
    print(s)


if __name__ == '__main__':
    main()
