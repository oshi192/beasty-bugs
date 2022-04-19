
class Statistics{
 int eatedFood=0; 
 int eatedPoison=0; 
 int avgSpeed=0; 
 byte dnaLength=67;

  public void incEatedFood(){
    eatedFood++;
  }
  public void setDnaLength(byte dnaLength){
    this.dnaLength=dnaLength;
  }
  public void setAvgSpeed(int avgSpeed){
    this.avgSpeed=avgSpeed;
  }
  public void incEatedPoison(){
    eatedPoison++;
  }
  
  public int getEatedPoison(){
   return eatedPoison; 
  }
  
  public int getEatedFood(){
   return eatedFood; 
  }
  
  @Override
  public String toString(){
   return  "eatedFood:"+eatedFood+
   ", eatedPoison:"+eatedPoison +
   ", dnaLength:"+dnaLength+
   ", avgSpeed:"+avgSpeed
   ;
  }
  
}
