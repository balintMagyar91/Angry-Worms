class Zone extends Shape{
  
  float w = 40;
  float h = 40;
  boolean active = false;
  
  void Draw(){
    
    noFill();
    //stroke(0);
    noStroke();
    
    beginShape();
    
    vertex(position.x-w/2, position.y+h/2); 
    vertex(position.x+w/2, position.y+h/2); 
    vertex(position.x+w/2, position.y-h/2); 
    vertex(position.x-w/2, position.y-h/2); 
    
    endShape(CLOSE);
    
  }
  
  Boolean Contains(float x, float y){
  
    return (x>= position.x-w/2 &&  x<= position.x+w/2 &&
            y>= position.y-h/2 &&  y<= position.y+h/2);
  }
}
