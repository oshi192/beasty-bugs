public class Utils{
  static final String POPULATION_FILE_PATH = "data/new.json";
  public void savePopulation(Population population){
   //loadJSONObject("response.json"); 
    JSONObject json = new JSONObject();
    json.setInt("deadAmount",population.deadAmount);
    json.setInt("populationSize",population.populationSize);
    JSONArray citizens=new JSONArray();
    for(int i = 0; i<population.citizens.size(); i++){
      JSONObject citiP = new JSONObject();
      citiP.setInt("wasChecked", population.citizens.get(i).wasChecked);
      citiP.setInt("x", population.citizens.get(i).x);
      citiP.setInt("y", population.citizens.get(i).y);
      citiP.setInt("direction", population.citizens.get(i).direction);
      citiP.setInt("bodySize", population.citizens.get(i).bodySize);
      citiP.setInt("health", population.citizens.get(i).health);
      citiP.setInt("whatToDoLength", population.citizens.get(i).whatToDoLength);
      citiP.setInt("howToEatLength", population.citizens.get(i).howToEatLength);
      citiP.setInt("genomePointer", population.citizens.get(i).genomePointer);
      String result = "[";
      for(int j =0;j<population.citizens.get(i).genome.length;j++){
        result+=population.citizens.get(i).genome[j]+ (j==population.citizens.get(i).genome.length-1?"]":", ");
      }
      citiP.setString("genome", result);
      
      citizens.setJSONObject(i, citiP) ;
    }
    json.setJSONArray("citizens",citizens);
    saveJSONObject(json, "data/new.json");
  }
  
  public Population savePopulation(){
    Population population = new Population();
    //todo
    return population;    
  }
}
