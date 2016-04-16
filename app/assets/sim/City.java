//a city will hold people and have a set number of work and other locations

public class City {    
    int[] works;
    int[] worksSick;
    int[] worksSickTemp;
    int[] schools;
    int[] schoolsSick;
    int[] schoolsSickTemp; 
    int[] ages; //012 for different groups   
    int[] agesSick;
    int[] agesSickTemp;
    int[] family;
    int[] familySick;    
    int[] familySickTemp; 
    int population;
    int sick;
    int sickTemp;
    int immune;
    int immuneTemp;    
    int cityId;
    int cityVaccines;
    int ads;
    int citySchoolsOff;
    int vacc_chance;
    int money_left;
    int money_spent_vaccines;
    Person[] people;
    Randomize random;
    
City(int id, Randomize random, int CITYPOP, int CITYFAM){
    this.random = random;
    //this is for a new city
    //create your people to go in it    
    people = new Person[CITYPOP]; //people matches number assigned to the city
    //they will not reside outside of the city because at this point they dont need to
    //they will be committed at the end of each day.  
    //No travel between cities as of right now 
    //but what if we had a public one that is effected by the cities next to it
    
    works = new int[CITYPOP/10+1];
    worksSick = new int[CITYPOP/10+1];
    worksSickTemp=new int[CITYPOP/10+1];
    schools = new int[CITYPOP/10+1];
    schoolsSick = new int[CITYPOP/10+1];
    schoolsSickTemp = new int[CITYPOP/10+1];
    ages = new int[4];
    agesSick = new int[4];
    agesSickTemp = new int[4];
    family = new int[CITYPOP/CITYFAM +1];
    familySick = new int[CITYPOP/CITYFAM +1];
    familySickTemp = new int[CITYPOP/CITYFAM +1];
    cityId = id;
    population = CITYPOP;
    
    for(int i=0; i < CITYPOP; i++)
      people[i] = new Person(random, this);
  }

  void run(){
    //reset temp arrays to current day
    agesSickTemp = agesSick;
    familySickTemp = familySick;
    schoolsSickTemp = schoolsSick;
    sickTemp = sick;
    worksSickTemp=worksSick;
    immuneTemp=immune;

    for (Person aPeople : people) aPeople.simulate();

    agesSick = agesSickTemp;
    familySick = familySickTemp;
    schoolsSick = schoolsSickTemp;
    sick = sickTemp;
    worksSick = worksSickTemp;
    immune = immuneTemp;
  }

  boolean vaccinate(){
    if (cityVaccines == 0)
      return false;

    if (random.nextInt(population) < vacc_chance){
      cityVaccines--;
      return true;
    }
    return false;
  }
  
    void commit(int input_id, int day, DB data, String group){
        //this will be the database portion
        data.toDatabase(input_id, this, group, day);
        print(day, this); // Comment out in production.
    }

    // synchronize when printing to console so it doesn't get all messed up
    // City object needed for this static method to print instance variables
    static synchronized void print(int day, City thisCity){
        // System.out.printf("[%d]Population total for City[%d]: %d\n", day, thisCity.cityId, thisCity.population);
        // System.out.printf("[%d]Sick: %d, Immnune: %d\n", day, thisCity.sick, thisCity.immune);
        // System.out.printf("[%d]Ages: %d/%d, %d/%d, %d/%d\n", day,   thisCity.agesSick[0],thisCity.ages[0],
        //                                                             thisCity.agesSick[1],thisCity.ages[1],
        //                                                             thisCity.agesSick[2],thisCity.ages[2]);
        // System.out.println("-------------------------------------");
    }

    void setParams(int vaccines, int ads, int schoolsOff, int vacc_chance, int money_left){
        cityVaccines = vaccines;
        money_spent_vaccines += vaccines * 13;
        this.ads = ads;
        citySchoolsOff = schoolsOff;
        this.vacc_chance = vacc_chance;
        this.money_left = money_left;
    }
}

