enum ItemType{
 POISON(#AAFF55), FOOD(#FF99CC), BORDER(#663300), EMPTY(0);
 public color c;
 private ItemType(color c){
   this.c = c;
 }
}
