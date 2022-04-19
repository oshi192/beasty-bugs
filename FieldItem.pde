class FieldItem{
  int x;
  int y;
  int size;
  color c;
  ItemType type;
  int lifeCount = 50+(int)random(250);
  FieldItem(){
    
  }
  FieldItem(int x, int y, int size, ItemType type){
    this.x = x;
    this.y = y;
    this.size = size;
    this.type = type;
  }
  
  public void display(){
    noStroke();
    fill(type.c);
    rect(x+1,y+1, size-1, size-1);
  }
  public void action(){
    if(type!=ItemType.EMPTY && type!=ItemType.BORDER){
      lifeCount--;
      if(lifeCount<=0){
        type = ItemType.EMPTY; 
      }
    }
    
  }
  
  @Override
  public boolean equals(Object obj) {
    FieldItem item = (FieldItem) obj;
      return this.x==item.x && this.y==item.y;
  }
}
