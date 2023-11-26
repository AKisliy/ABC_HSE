class Program
{
    static void Main()
    {
        var rnd = new Random();
        int vowels = 0;
        int consonants = 0;
        string lowVows = "aeiouy";
        string bigVows = lowVows.ToUpper();
        string lowCons = "bcdfghjklmnpqrstvwxz";
        string bigCons = lowCons.ToUpper();
        FileStream fs = new FileStream("test.txt", FileMode.OpenOrCreate); // paste path to your file instead of "test.txt"
        StreamWriter sw = new StreamWriter(fs);
        for(int i = 0; i < 1000; ++i) // you can replace 1000 with any number of symbols
        {
            char write = (char)rnd.Next(0,127);
            while(write == '\0')
                write = (char)rnd.Next(0,127);
            sw.Write(write);
            if (i < 10000)
            {
                if ((lowVows.Contains(write) || bigVows.Contains(write)))
                    ++vowels;
                else if (lowCons.Contains(write) || bigCons.Contains(write))
                    ++consonants;
            }
        }
        sw.Flush();
        Console.WriteLine($"{vowels} {consonants}");
    }
}
