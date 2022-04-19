import java.util.List;

int cellSize = 9;
int cellAmountX = 100;
int cellAmountY = 100;

FieldItem[][] items = new FieldItem[cellAmountX][cellAmountY];
Population currentPopulation;
int currentStep = 0;
int populationNumber = 0;
int statSize =120;
int maxDays=500;

public void settings(){
  size(cellAmountX * cellSize+statSize, cellAmountY * cellSize);
  setField();
  currentPopulation = new Population(150, cellAmountX, cellAmountY, cellSize);
}

public void draw(){
  drawField();
  updateStuff();
  if(currentStep < maxDays){
      currentPopulation.doStep();
  }else{
      currentPopulation.repopulate();
      setField();
      currentStep=0;
      populationNumber++;
      println("population "+populationNumber+" has started");
  }
  displayInfo(currentStep++);
  currentPopulation.display();
  addItemsToField(items, 3, random(100)<30? ItemType.POISON: ItemType.FOOD); 
}

public void drawField(){
  background(240,240,240);
  stroke(200,200,200);
  for(int i = 0; i<cellAmountX; i++){
    line(i*cellSize,0,i*cellSize,cellAmountY*cellSize);
  }
  for(int i = 0; i<cellAmountY; i++){
    line(0,i*cellSize,cellAmountX*cellSize,i*cellSize);
  }
}

public void setField(){ 
  //set empty fields
  for(int x = 0; x<cellAmountX; x++){
    for(int y = 0; y<cellAmountY; y++){
      items[x][y] = new FieldItem(x*cellSize, y*cellSize, cellSize, ItemType.EMPTY);
    }
  }
  //add border
  for(int i = 0; i<cellAmountY; i++){
          items[0][i] = new FieldItem(0, i*cellSize, cellSize, ItemType.BORDER);
          items[cellAmountX-1][i] = new FieldItem((cellAmountX-1)*cellSize, i*cellSize, cellSize, ItemType.BORDER);
  }
  for(int i = 0; i<cellAmountX; i++){
          items[i][0] = new FieldItem(i*cellSize, 0, cellSize, ItemType.BORDER);
          items[i][cellAmountY-1] = new FieldItem(i*cellSize, (cellAmountY-1)*cellSize,  cellSize, ItemType.BORDER);
  
  }
  //add food
  addItemsToField(items, 100, ItemType.FOOD); 
  //add poison
  addItemsToField(items, 100, ItemType.POISON); 
}


public void addItemsToField(FieldItem[][] field, int amount, ItemType type){
  for(int i = 0; i<amount; i++){
    int x = (int)random(cellAmountX-50)+25;
    int y = (int)random(cellAmountY-50)+25;
    int tryes=0;
    while(field[x][y].type != ItemType.EMPTY && tryes<20){
      tryes++;
      x = (int)random(cellAmountX-50)+25;
      y = (int)random(cellAmountY-50)+25;
    }
    if(field[x][y].type == ItemType.EMPTY){
        field[x][y] = new FieldItem(x*cellSize, y*cellSize, cellSize, type);
    }
  }
}

public void updateStuff(){
  for(int x = 0; x<cellAmountX; x++){
    for(int y = 0; y<cellAmountY; y++){
      if(items[x][y].type != ItemType.EMPTY){
        items[x][y].display();
        items[x][y].action();
      }
    }
  }
}
public void displayInfo(int days){
  fill(0);
  text("population# "+populationNumber,cellAmountX*cellSize+10,20);
  text("alive : "+currentPopulation.getAliveAmount(),cellAmountX*cellSize+10,40);
  text("day   : "+days+"/"+maxDays,cellAmountX*cellSize+10,60);
}
