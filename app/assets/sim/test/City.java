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
    Person[] people;
    
City(int id, Randomize rand, int total, int vaccines)
  {             
    //this is for a new city
    //create your people to go in it    
    people = new Person[total]; //people matches number assigned to the city
    //they will not reside outside of the city because at this point they dont need to
    //they will be committed at the end of each day.  
    //No travel between cities as of right now 
      //but what if we had a public one that is effected by the cities next to it
    
    works = new int[total/10+1];
    worksSick = new int[total/10+1];
    worksSickTemp=new int[total/10+1];
    schools = new int[total/10+1];
    schoolsSick = new int[total/10+1];
    schoolsSickTemp = new int[total/10+1];
    ages = new int[4];
    agesSick = new int[4];
    agesSickTemp = new int[4];
    family = new int[200000];
    familySick = new int[200000];        
    familySickTemp = new int[200000];        
    cityId = id;
    cityVaccines = vaccines;
    
    for(int i=0; i<total; i++)    
      people[i]=new Person(rand, total, this);         
  }

  void run(int start, int days){      
    for(; start<=days; start++)
    {      
      //reset temp arrays to current day
      agesSickTemp = agesSick;
      familySickTemp = familySick;
      schoolsSickTemp = schoolsSick;
      sickTemp = sick;
      worksSickTemp=worksSick;
      immuneTemp=immune;
      
//      getInput();
      for(int j=0; j<people.length; j++)            
          people[j].simulate(); 
      
      agesSick = agesSickTemp;
      familySick = familySickTemp;
      schoolsSick=schoolsSickTemp;
      sick = sickTemp;
      worksSick=worksSickTemp; 
      immune=immuneTemp;
    }       
    //commit(days);
    //free();//need to clear it out or else heap error
  }
  
  void commit(int x, DB data, String group)
  {//this will be the database portion
    data.toDatabase(this, group, x);
    System.out.printf("[%d]Population total for City[%d]: %d\n", x, cityId, population);
    System.out.printf("[%d]Sick total: %d\n", x, sick);    
    System.out.printf("[%d]Ages: %d/%d, %d/%d, %d/%d\n",x, agesSick[0],ages[0],agesSick[1],ages[1],agesSick[2],ages[2]);
    System.out.println("-------------------------------------");
  }
    
  void free()
  {
    //below is everything for garbage collection, it runs out of heap space if not
    works=null;
    worksSick=null;
    worksSickTemp=null;
    schools=null;
    schoolsSick=null;
    schoolsSickTemp=null;
    ages=null;
    agesSick=null;
    agesSickTemp=null;
    family=null;
    familySick=null;
    familySickTemp=null;
    System.gc();//suggest to java to clear space back
  }
  
  void getInput()
  {//this will be a call to the database from what the students input
      //either get something everyday or add a prefix of how many days the data
      //is good for and start to count down
  }
}

