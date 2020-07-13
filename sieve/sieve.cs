using System;

namespace sieve
{
    class Sieve
    {
        const int HiPrime = 1000;
        static readonly bool[] Primes = new bool[HiPrime];//by default they're all false

        private static void Main()
        {

            for (var i = 2; i < HiPrime; i++)
            {
                Primes[i] = true;//set all potential primes true
            }

            for (var j = 2; j < HiPrime; j++)
            {
                if (!Primes[j]) continue;
                for (long p = 2; (p * j) < HiPrime; p++)
                {
                    Primes[p * j] = false;
                }
            }

            using (System.IO.StreamWriter file =
    new System.IO.StreamWriter(@"C:\Users\michael\source\repos\sieve\prime.file"))
            {
                for (var index = 2; index < Primes.Length; index++)
                {
                    if (Primes[index]) file.WriteLine(index);
                }
            }
        }
    }
}