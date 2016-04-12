public class Person {
  Randomize random;
  public int city;//int returned is the i*max rows + j can be decomposed
  public int age;
  public int status;
  public int work;
  public int school;
  public int other;
  public int family;
  City home;

  Person(Randomize given, City from){
    // values will probably need to pass which city they are in
    home = from;
    random = given;
    
    age = random.rAge();
    home.ages[age]++;                           
    if(age>0){
      work = random.nextInt(home.works.length);
      home.works[work]++;      
    }
    else{    
      school = random.nextInt(home.works.length);
      home.schools[school]++;
    }              
    
    family = random.rFamily();
    home.family[family]++;         
    status = random.rStatus();

  }
  
  void simulate(){
    if(status==0)//susceptible
      if (home.vaccinate()){
          status = 31;
          home.immuneTemp++;
      }else walkDay();
     
    if(status > 1)
      status++;

    if(status == 1)//infect others
      arrayAdd();
    else if(status == 14)//possibly die
      rollDeath();          
    else if(status == 15)//no longer infect others
      arraySub();
    else if(status == 30) {//no longer immune
      status = 0;
      home.immuneTemp--;
    }else if(status == 120)
      status = 0;//no longer immune from vaccine
  }
  
  void walkDay(){
    status = random.rFamSick(home.familySick[family]);
    if(age>0)
        status = (random.rPlaceSick(home.worksSick[work], home.works[work])|status);
    else
        status = (random.rPlaceSick(home.schoolsSick[school], home.schools[school])|status);
    status = (random.rPlaceSick(home.sick, home.population)|status);
  }
  
  void arrayAdd(){
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
    home.immuneTemp++;
    if(age>0)
      home.worksSickTemp[work]--;
    else
      home.schoolsSickTemp[school]--;   
    status++;
  }
  
  void rollDeath(){
      //no deaths yet
  }

}
