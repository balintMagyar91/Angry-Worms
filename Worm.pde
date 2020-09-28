class Worm extends Shape{
  
  float w = 8;
  float h = 25;
  float r = 4;
  
  void Draw(){

    fill(255, 255, 0);
    noStroke();
    
    beginShape();
    
    vertex(position.x-w/2, position.y+h/2);
    vertex(position.x+w/2, position.y+h/2);
    vertex(position.x+w/2, position.y-h/2);
    vertex(position.x-w/2, position.y-h/2);
    
    float step = 2*PI / detailness; 
    
    for(int i = 0; i< detailness; i++){
      float alpha = i* step;
      float x = position.x + r*sin(alpha);
      float y = position.y-12 + r*cos(alpha);
      vertex(x,y);
      alpha = i* step;
      x = position.x + r*sin(alpha);
      y = position.y+12 + r*cos(alpha);
      vertex(x,y);
      
    }
    
    endShape(CLOSE);
  }
  
  Boolean Contains(float x, float y){
  
    return (x>= position.x-w/2 &&  x<= position.x+w/2 &&
            y>= position.y-h/2 &&  y<= position.y+h/2);
  }
  
}
