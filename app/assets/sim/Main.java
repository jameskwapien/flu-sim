import java.sql.ResultSet;
import java.sql.SQLException;


public class Main {
  private static final int POPULATION = 500000;
  private static final int CITY_COUNT = 250;
  private static final int CITYPOP = POPULATION / CITY_COUNT;
  private static final int CITYFAM = 3;
  private static final int THREADCOUNT = 5; // CITY_COUNT % THREADCOUNT must be ZERO!!
  private static int money_left;
  private static int SEED;
  private static String GROUP;
  private static int input_id;
  private static int last_input_id;
  private static int DAYS;
  private static int vaccines;
  private static int ads;
  private static int school_off;
  private static int dayCount;
  private static int vacc_chance;
  private static float vacc_chance_percent = 0.05f;
  private static City[] map;

  public static void main(String[] args) throws SQLException {
    System.out.println("Starting Simulation");    
    final long start = System.currentTimeMillis();
    input_id = last_input_id = DAYS = vaccines = ads = school_off = dayCount = vacc_chance = 0;

    if(args.length > 0){
        GROUP = args[0];
    }else{
        GROUP = "TEST";
        System.out.println("No group name provided. \"TEST\" provided as name");
    } 
    
    map = new City[CITY_COUNT];//map is the array that contains all of our cities
    //this will be split in R after this simulation is complete, so it doesn't have to be a double array

    //this object is created once, that way we get deterministic results
    DB data = new DB();
    Thread[] threads = new Thread[THREADCOUNT];

    final ResultSet inputs = data.getInputs(GROUP);
    inputs.first();
    SEED = inputs.getInt("seed");
    inputs.last();
    last_input_id = inputs.getInt("id");
    inputs.beforeFirst();

    if (data.checkOutput(last_input_id, GROUP)){
      System.out.println("input_id existent in output");
      System.exit(0);
    }

    // Loop through inputs and simulate with given values for the specified amount of days
    while (inputs.next()) {
      input_id = inputs.getInt("id");
      vaccines += inputs.getInt("vaccines")/CITY_COUNT; //for now, must be greater of equal than city count.
      ads = inputs.getInt("ads"); //for now, must be greater of equal than city count.
      DAYS = inputs.getInt("days");
      school_off = inputs.getInt("school_off"); //for now, must be greater of equal than city count.
      money_left = inputs.getInt("money_left");

      if (!lessVaccMoney(vaccines)){
        System.out.println("Not enough money.");
        System.exit(0);
      }

      setVacc_chance((float) ((ads/1000) * 0.01 ));
      money_left -= ads;

//***** BEGIN THREAD VERSION | COMMENT/UNCOMMENT TO EXPERIMENT *************//
      int counter = 0;
      for (int i = 0; i < CITY_COUNT; i += CITY_COUNT/THREADCOUNT){
        final int begin = i;
        final int end = CITY_COUNT/THREADCOUNT + i;

        //Local class to avoid passing ridiculous arguments.
        class ThreadMe implements Runnable {
          public void run(){
            DB data = new DB();
            for (int i = begin; i < end; i++) {
              if (map[i] == null)
                map[i] = new City(i, new Randomize(SEED + i, CITYPOP, CITYFAM), CITYPOP, CITYFAM);
              map[i].setParams(vaccines, ads, school_off, vacc_chance, money_left);

              for (int j = dayCount; j < DAYS + dayCount; j++) {
                map[i].run();
//                map[i].print(j, map[i]); // Print days
              }

              if (input_id == last_input_id)
                map[i].commit(input_id, DAYS + dayCount, data, GROUP);

            } } }

        threads[counter++] = new Thread(new ThreadMe());
      }

      // run and join threads before simulating next input
      try{
        for (Thread thread : threads) thread.start();
        for (Thread thread : threads) thread.join();
      }catch (InterruptedException e){
        e.printStackTrace();
      }
//******* END THREADED VERSION | COMMENT/UNCOMMENT TO EXPERIMENT **********//

//******* BEGIN NON THREADED VERSION | COMMENT/UNCOMMENT TO EXPERIMENT ****//
//      for(int i = 0; i < CITY_COUNT; i++){
//        if (map[i] == null)
//          map[i] = new City(i, new Randomize(SEED + i, CITYPOP, CITYFAM), CITYPOP, CITYFAM);
//        map[i].setParams(vaccines, ads, school_off, vacc_chance, money_left);
//
//        for (int j = dayCount; j < DAYS + dayCount; j++) {
//          map[i].run();
////          map[i].print(j, map[i]); // Print days
//        }
//        map[i].commit(input_id, DAYS + dayCount, data, GROUP);
//      }
//******* END NON THREADED VERSION | COMMENT/UNCOMMENT TO EXPERIMENT ******//

      // Keeps track of the amount of days that have passed.
      dayCount += DAYS;
      vacc_chance_percent = 0.05f;
    }
    //currently all cities have the same populations then it is cleaned up in post
    /* R needs this */
    try {
      System.out.printf("wtf");
      Runtime rt = Runtime.getRuntime();
      Process pr = rt.exec("Rscript ../Rscripts/pieCharts.R " + GROUP);
      System.out.printf("wtf");
    }
    catch (Exception e){
      System.out.printf("Command line call is not working: " + e);
      System.out.printf("WTF");
    }
    /* end of R call */
    final long finish = System.currentTimeMillis();
    System.out.printf("Time to run: %02.2f seconds\n",(float)(finish-start)/1000);
  }

  public static void setVacc_chance (float upBy){
    vacc_chance_percent += upBy;
    vacc_chance =  (int) (CITYPOP * vacc_chance_percent);
  }

  public static boolean lessVaccMoney(int subtract){
    money_left -= subtract * 13;
    return money_left >= 0;
  }

}
