import java.util.Collections;
import java.util.List;

float muttationRate = 5;

class Population{
  int deadAmount;
  int populationSize;
  Utils utils = new Utils();
  List<Cell> citizens = new ArrayList<>();
  
  Population(){}
  Population(int populationSize, int sizeX, int sizeY, int bodySize){
    this.populationSize = populationSize;
    
    for(int i = 0; i<populationSize;i++){
      Cell cell = new Cell(((int)random(sizeX-2)+1), ((int)random(sizeY-2)+1), bodySize);
      int count = 0;
      while(citizens.contains(cell) && count<20){
        cell = new Cell(((int)random(sizeX-2)+1), ((int)random(sizeY-2)+1), bodySize);
        count++;
      }
      if(count<20){
        citizens.add(cell);
      }
    }
  }
  
  public int getAliveAmount(){
    return populationSize-deadAmount;
  }
  
  public void doStep(){
    for(Cell cell : citizens){
      
      cell.step2();
    }
  }
  
  public void display(){
    noStroke();
    deadAmount=0;
    for(Cell cell : citizens){
      cell.display();
      if(cell.health<=0)deadAmount++;
    } 
  }
  
  public void repopulate(){
      Collections.sort(citizens, (cell1, cell2)->cell2.health.compareTo(cell1.health));
                                      println("============== top 10 ===================");
                                      for(int i = 0; i<15; i++){
                                        println("["+i+"]\t"+citizens.get(i));
                                      }
                                      println("==============              ===================");
                                            utils.savePopulation(this);

      List<Cell> nextGeneration = new ArrayList<>();
      for(int i = 0; i<populationSize; i++){
        nextGeneration.add(generateFromParrents(citizens.get((int)random(populationSize/10)), citizens.get((int)random(populationSize/10))));
      }
      citizens = nextGeneration;
  }
  
   public Cell generateFromParrents(Cell parrent1, Cell parrent2){
      Cell chield = new Cell((int)random(cellAmountX-2)+1, (int)random(cellAmountY-2)+1, cellSize);
      int pointer1=(int)random(chield.genome.length);
      int pointer2=pointer1-chield.genome.length/2;
      pointer2=pointer2<0?chield.genome.length+pointer2:pointer2;
      if(pointer1>pointer2){
        int tmp=pointer1;
        pointer1=pointer2;
        pointer2=tmp;
      }
      for(int i = 0;i<pointer1;i++){
        chield.genome[i]=parrent1.genome[i];
      }
      for(int i = pointer2;i<chield.genome.length;i++){
        chield.genome[i]=parrent1.genome[i];
      }
      for(int i = pointer1;i<pointer2;i++){
        chield.genome[i]=parrent2.genome[i];
      }
      for(int i = 0;i<chield.genome.length;i++){
        if(random(100)<muttationRate){
          chield.genome[i]=(byte)random(64);
        }
      }
      int sum=0;
      int amount=0;
      for(int i = 0; i<chield.genome.length;i++){
          if(chield.genome[i]>55){
            break;
          }
         if(chield.genome[i]<8){
           sum+=chield.genome[i];
           amount++;
         }
      }
      if(amount>0)chield.statData.setAvgSpeed(sum/amount);
      //println("p1\t"+parrent1.toString());
      //println("p2\t"+parrent2.toString());
      //println("ch\t"+chield.toString());
      return chield;
  }
}
