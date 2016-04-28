import static org.junit.Assert.*;

public class Test_Randomize {

  @org.junit.Test
  public void testRandomize(){
    Randomize random = new Randomize(1000, 2000, 3);
    int rAge = random.rAge();
    assertTrue(rAge >= 0 && rAge <  3);

    int rStatus = random.rStatus();
    assertTrue(rStatus == 0 || rStatus == 1);

    int rFamily = random.rFamily();
    assertTrue(rFamily >= 0 && rFamily <  3);

    int rFamSick = random.rFamSick(3);
    assertTrue(rFamSick == 0 || rFamSick == 1);

    int rPlaceSick = random.rPlaceSick(15, 100);
    assertTrue(rPlaceSick == 0 || rPlaceSick == 1);
 
    int rCitySick = random.rCitySick(100, 2000);
    assertTrue(rCitySick == 0 || rCitySick == 1);

    int nextInt = random.nextInt(100);
    assertTrue(nextInt > 0 || nextInt < 100);

  }
}
