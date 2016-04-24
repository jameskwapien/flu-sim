import java.util.Random;
//handles all randomization since we only set the seed here
//handles family for now since it is one function

public class Randomize {
    private Random random;
    private int CITYPOP;
    private int CITYFAM;
    int familyCount = 0;
    int count = 0;

    Randomize(int SEED, int CITYPOP, int CITYFAM){
        random = new Random(SEED);
        this.CITYPOP = CITYPOP;
        this.CITYFAM = CITYFAM;
    }

    public int rAge(){
        return random.nextInt(3);
    }
    
    public int rStatus(){
        //5% chance of starting off as sick
        int sick = random.nextInt(100);
        return (sick>=95) ? 1 : 0;
    }
    
    public int rFamily(){
        //for every three people right now we put them in a new family
        if (count == CITYPOP){
            count = 0;
            familyCount = 0;
        }
        if (count % CITYFAM == 0) {
            if (count > 2)
                familyCount++;
        }
        count++;
        return familyCount;
    }
    
    public int rFamSick(int x)
    {//the larger the x the better chance you have
      if(x==0) return 0;
      else{
          int roll= random.nextInt(100);//roll random
          return (roll>=(100-(15*x))) ? 1 : 0; //15% chance increase per person in family sick
      }
    }
    
    public int rPlaceSick(int x, int y) {
        //implemented as a percentage of people around you at the moment
        float percent = (float) x / y;
        int roll = random.nextInt(100);
        int sickLevel;
        sickLevel = 100 - (int) (percent * 100 / y);
        return (roll > sickLevel) ? 1 : 0;
    }

    public int rCitySick(int x, int y) {
        //implemented as a percentage of people around you at the moment
        float percent = ((float) x / y) * 100;
        int roll = random.nextInt(5000);
        return (roll <= percent) ? 1 : 0;
    }

    public int nextInt(int range){
        return random.nextInt(range);
    }    
}
