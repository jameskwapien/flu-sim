public class Person {       
  public int city;//int returned is the i*max rows + j can be decomposed
  public int age;
  public int status;
  public int work;
  public int school;
  public int other;
  public int family;
  City home;
  Randomize rand;
  
  Person(Randomize given, int total, City from){
    //todo initialization values will probably need to pass which city they are in
    //fill cities until population reached   
    home=from;
    rand=given;
    
    age = rand.rAge();
    home.ages[age]++;                           
    if(age>0){
      work = rand.rPlace(home.works.length);
      home.works[work]++;      
    }
    else{    
      school = rand.rPlace(home.works.length);        
      home.schools[school]++;
    }              
    
    family = rand.rFamily();    
    home.family[family]++;         
    status = rand.rStatus();   

    home.population++;         
  }
  
  void simulate(){
    //where does the flu shot go in this?
    
    if(status==0)//susceptible
      if (vaccinate()){
          status = 31;
          home.immuneTemp++;
      }
      else walkDay();
     
    if(status>1)
        status++;    
    if(status==1)//infect others
      arrayAdd();        
    
    if(status==14)//possibly die    
      rollDeath();          
    if(status==15)//no longer infect others    
      arraySub();
          
    if(status==30)//no longer immune
        status=0;        
    if(status==120)
        status=0;//no longer immune from vaccine
  }
  
  void walkDay(){
    vaccinate();
    status = rand.rFamSick(home.familySick[family]);    
    if(age>0)
        status = (rand.rPlaceSick(home.worksSick[work], home.works[work])|status); 
    else
        status = (rand.rPlaceSick(home.schoolsSick[school], home.schools[school])|status);
    status = (rand.rPlaceSick(home.sick, home.population)|status);                
  }
  
  void arrayAdd(){
//same as init?              
    home.agesSickTemp[age]++;
    home.familySickTemp[family]++;            
    home.sickTemp++;
    if(age>0)
      home.worksSickTemp[work]++;
    else
      home.schoolsSickTemp[school]++;                    
    status++;
  }
  
  void arraySub(){
    home.agesSickTemp[age]--;
    home.familySickTemp[family]--;            
    home.sickTemp--;
    if(age>0)
      home.worksSickTemp[work]--;
    else
      home.schoolsSickTemp[school]--;   
    status++;
  }
  
  void rollDeath(){
      //no deaths yet
  }
  
  boolean vaccinate(){
    if (home.cityVaccines == 0)
      return false;

    if (rand.rZeroHundred() < (home.population-home.sick)/home.cityVaccines) {
      home.cityVaccines--;
      return true;
    }
    return false;
  }
}
