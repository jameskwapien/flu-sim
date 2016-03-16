
import java.util.Random;
//handles all randomizations since we only set the seed here
//handles family for now since it is one function

public class Randomize {
    Random r;
    int familyCount = 0;
    int count=0;
    
    void init(int x)
    {              
        r = new Random(x);
    }
    
    public int rAge()
    {                
        return r.nextInt(3);              
    }
    
    public int rStatus()
    {//5% chance of starting off as sick
        
        int sick = r.nextInt(100);
        if(sick>=95)
            return 1;
        else
            return 0;
    }
    
    public int rPlace(int x)
    {//a number to assign it in an array
        return r.nextInt(x);        
    }
    
    public int rFamily()
    {//for every three people right now we put them in a new family
        count++;
        if (count%3==0)
            familyCount++;        
        return familyCount;        
    }
    
    public int rFamSick(int x)
    {//the larger the x the better chance you have
      int sick=0;
      if(x==0)
          sick=0;
      else        
      {
        int roll= r.nextInt(100);//roll random
        if(roll>=(100-(15*x)))//15% chance increase per person in family sick
            sick=1;
        else
            sick=0;
      }        
      return sick;
    }
    
    public int rPlaceSick(int x, int y)
    {//implemented as a percentage of people around you at the moment        
        float percent = (float)x/y;
        int roll = r.nextInt(100);
        int sickLevel;
        sickLevel = 100-(int)(percent*100/y);
        if(roll>sickLevel)
            return 1;
        else 
            return 0;
    }
    
    public int rZeroHundred(){ 
        return r.nextInt(100); 
    }    
}
