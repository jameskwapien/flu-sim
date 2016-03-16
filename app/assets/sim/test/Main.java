
import java.sql.ResultSet;
import java.sql.SQLException;


public class Main {
static final int POPULATION = 500000;
static final int CITY_COUNT = 250;
static int SEED = 0;
static int DAYS = 0;
static String GROUP;
static int vaccines =0;
static int schoolOnOff = 0;

  public static void main(String[] args){
    System.out.println("Starting Simulation");    
    final long start = System.currentTimeMillis();
    
    if(args.length > 0){
        GROUP = args[0];
    }else{
        System.out.println("Error, no group name provided.");
    } 
    
    SEED=9;//bring in from outside   
    City[] map;
    map = new City[CITY_COUNT];//map is the array that contains all of our cities
    //this will be split in R after this simulation is complete, so it doesnt have to be a double array    
    
    Randomize rand = new Randomize();
    rand.init(SEED);//this object is created once, that way we get deterministic results
    DB data = new DB();
    data.init();
         
    try{
    int i=0;
    ResultSet inputs = data.getInputs(GROUP);
    ResultSet inputsTemp = inputs;
    
      for(int j=0;j<CITY_COUNT;j++){
        inputsTemp.beforeFirst();
        inputsTemp.next();
        vaccines = inputsTemp.getInt("vaccines")/CITY_COUNT;        
        inputsTemp.beforeFirst();                                         
        
        map[j] = new City(j, rand, POPULATION/CITY_COUNT, vaccines);
        while(inputsTemp.next()){
          DAYS=inputsTemp.getInt("days"); //bring in from outside            
          vaccines = inputsTemp.getInt("vaccines")/CITY_COUNT;
          schoolOnOff = inputsTemp.getInt("school_off");                           
          map[j].run(i, DAYS); 
          i=DAYS;
        }
        
        map[j].commit(i, data, GROUP);
        if(j>0)
          map[j-1].free();//keeps other city there for reference if we wanted
          //this way we could have the city immediatley before it at least effect the 
          //population of the one that we are in          
      }
    }
    catch(SQLException e)
    {
        System.out.println("SQL Failed! "+e.getMessage());
    }
    //currently all cities have the same populations then it is cleaned up in post
    final long end = System.currentTimeMillis();
    System.out.printf("Time to run: %02.2f seconds\n",(float)(end-start)/1000);    
  }

}
