import java.util.Map;

int [][] coordinateMap = {
    {-1,-1},
    {0,-1},
    {1,-1},
    {1,0},
    {1,1},
    {0,1},
    {-1,1},
    {-1,0}
  };
  
class Cell{
  //statistics data
  Statistics statData = new Statistics();
  //
  byte genomePointer = 0;
  int avgSpeed = 0;
  int wasChecked = -2;
  byte whatToDoLength=64;
  byte howToEatLength=4;//food poison border c
  //base characteristics
  int x,y,direction, bodySize;
  Integer health;
  int cininAmount = 0;

  byte[]genome = new byte[whatToDoLength+howToEatLength];

  /*
    0X - go or not to go
    1_ - wait
    2X - turn/-4-4
    3X - check
    4X - eat
    5X - skipSeveralInstructions / 0-7
    6X - skip 8-15
    7X - end operation
  */

  Cell(int x, int y, int bodySize){
    this.x = x;
    this.bodySize = bodySize;
    this.y=y;
    this.health = 500;
    direction=(int)random(8);
    for(int i =0; i< genome.length; i++){
      genome[i]=(byte)random(64); 
    }
  }
  
  Cell(int x, int y,int health, int direction, int bodySize, Map<ItemType, Integer> actions){
    this.x = x;
    this.y=y;
    this.bodySize = bodySize;
    this.health = health;
    this.direction = direction;
  }
  
  public FieldItem [][] calculateNearest(){
    int [] xy = coordinateMap[direction];
      FieldItem [][] newItems = new FieldItem [3][3];
      for(int i = 0; i<3; i++){
        for(int j = 0; j<3; j++){
          newItems[i][j]=items[x+i-1][y+j-1];
        }
      }
      return newItems;
  }
  
  public void step2(){
     health--;
     if(health<0)return;
    switch(genome[genomePointer]/8){
      case 0 : {
        for(int i = 0; i<genome[genomePointer];i++){
          if(calculateNearest()[coordinateMap[direction][0]+1][coordinateMap[direction][1]+1].type!=ItemType.BORDER){
            x += coordinateMap[direction][0];
            y += coordinateMap[direction][1];
            health--;
          }else{
            health--;
            break;
          }
        }
        break;
      }
      case 1 : {
        health--;
        break;
      }
      case 2 : {
        int tmp = direction+genome[genomePointer]%8-4;
        direction = tmp<0?(8+tmp):tmp%8;
        health--;
        break;
      }
      case 3 : {
        wasChecked=genomePointer;//todo remove this
         health--;
        break;
      }
      case 4 : {
        if(wasChecked+1==genomePointer){
          FieldItem item = calculateNearest()[coordinateMap[direction][0]+1][coordinateMap[direction][1]+1];
          tryToEat(item);
          int tmpDirection = direction==0?7:direction-1;
          item = calculateNearest()[coordinateMap[tmpDirection][0]+1][coordinateMap[tmpDirection][1]+1];
          tryToEat(item);
          tmpDirection = direction==7?0:direction+1;
          item = calculateNearest()[coordinateMap[tmpDirection][0]+1][coordinateMap[tmpDirection][1]+1];
          tryToEat(item);
           health-=3;
          //eat
        }else{
          wasChecked=-2;
        }
        break;
      }
      case 5 : {
        genomePointer+=genome[genomePointer]%8; 
         health--;
        break;
      }
      case 6 : {
        genomePointer+=8+genome[genomePointer]%8;
         health--;
        break;
      }
      case 7 : {
        statData.setDnaLength(genomePointer);
        genomePointer=-1;
         health--;
        break;
      }
    }
    genomePointer+=1;
      if(genomePointer>63){
        genomePointer=0;
    }
  }
  public void tryToEat(FieldItem item){
    switch (item.type){
       case  FOOD : {
         if(genome[whatToDoLength]>31){
           statData.incEatedFood();
           health+=50;
           item.type = ItemType.EMPTY;
         }
         break;
       }
       case  POISON : {
         if(genome[whatToDoLength+1]>31){
           statData.incEatedPoison();
           if(cininAmount>0){
             health+=80;
           }else{
             health-=50;
           }
           item.type = ItemType.EMPTY;
         }
         break;
       }
       case  BORDER : {
         if(genome[whatToDoLength+2]>31){
           int tmp = direction+genome[whatToDoLength+2]%8-4;
           direction = tmp<0?(8+tmp):tmp%8;
         }
         break;
       }
       case  CININ : {
         if(genome[whatToDoLength+3]/8>3){
           if(cininAmount<genome[whatToDoLength+3]%8){
             cininAmount++;
             item.type = ItemType.EMPTY;
           }
         }
         break;
       }
    }
  }
    
  public void display(){

    if(health>0){
      int size = bodySize/3 + health/30;
      fill(40*cininAmount,100,250);
      ellipse(x* bodySize + bodySize/2,y*bodySize+bodySize/2, size-1, size-1);
          stroke(255);
      line( x* bodySize + bodySize/2,
            y*bodySize+bodySize/2, 
            x* bodySize + bodySize/2 + coordinateMap[direction][0]*bodySize/2, 
            y*bodySize+bodySize/2+coordinateMap[direction][1]*bodySize/2);
    }else{
      fill(0);
      rect(x* bodySize, y* bodySize, bodySize, bodySize);
    }

  }
  
  @Override
  public boolean equals(Object obj) {
    Cell item = (Cell) obj;
      return this.x==item.x && this.y==item.y;
  }
  
  @Override
  public String toString(){
    String result = "";
    //for(int i =0;i<genome.length;i++){
    //  result+=genome[i]+(genome[i]<10?"  ":" ");
    //}
    return "health+\t"+health+", statData: "+statData+"\nactions: ["+result+"]";
  }
}
