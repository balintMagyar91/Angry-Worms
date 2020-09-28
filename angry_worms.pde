Worm worm = new Worm();
Worm worm2 = new Worm();
Catapult catapult1 = new Catapult();
Zone zone1 = new Zone();
Catapult catapult2 = new Catapult();
Zone zone2 = new Zone();
boolean player1 = true;
boolean endGame = false;
int winner;
int player1Worms = 3;
int player2Worms = 3;

Rectangle cat1Button = new Rectangle();
Rectangle cat2Button = new Rectangle();

PImage hills;
PVector hillsLoc;
PImage ground;
PVector groundLoc;
PVector bg_color = new PVector(64, 160, 255);

float gravity = 0.1;
float cam_speed = 12;
boolean shot = false;
PVector wormPosition;
PVector wormPosition2;
PVector velocity = new PVector(0, 0);

PVector arrow = new PVector(mouseX, mouseY);
PVector rubber = new PVector(200, 340);
PVector rubber2 = new PVector(2100, 400);
PVector steepness = new PVector(0, 0);
PVector cat1Pos = new PVector(200, 400);
PVector cat2Pos = new PVector(2100, 400);
ArrayList<PVector> impacts = new ArrayList();

boolean toLeft = false;
boolean toRight = false;

float last_time;

void setup() {
  size(800, 600);
  hills = loadImage("hills.png");
  hillsLoc = new PVector(0, 0);
  ground = loadImage("ground.png");
  groundLoc = new PVector(0, 400);
  wormPosition = new PVector(200, 400);
  wormPosition2 = new PVector(600, 400);
  catapult1.position = cat1Pos;
  zone1.position = cat1Pos.copy();
  zone1.position.y -= 60;
  catapult2.position = cat2Pos;
  zone2.position = cat2Pos.copy();
  zone2.position.y -= 60;
  cat1Button.position = new PVector(100, 550);
  cat2Button.position = new PVector(700, 550);
}

void draw() {
  update();
  background(bg_color.x, bg_color.y, bg_color.z);
  image(hills, hillsLoc.x, hillsLoc.y);
  image(ground, groundLoc.x, groundLoc.y);
  if (endGame) {
    String win = "";
    if (winner == 0) {
      win = "A játék döntetlen.";
    } else if (winner == 1) {
      win = "Az 1. játékos nyert.";
      image(loadImage("fire.png"), cat2Pos.x-20, cat2Pos.y-60);
    } else if (winner == 2) {
      win = "A 2. játékos nyert.";
      image(loadImage("fire.png"), cat1Pos.x-20, cat1Pos.y-60);
    }
    textSize(32);
    fill(255);
    text(win, 260, 300); 
    if (millis() - last_time > 5000) {
      exit();
    }
    
  } else {
    cat1Button.Draw();
    fill(0);
    textSize(16);
    text("1. Katapult", 60, 555);
    for (int i=0; i<player1Worms; i++) {
      Worm w = new Worm();
      w.position = new PVector(55+(i*20), 585);
      w.Draw();
    }
    cat2Button.Draw();
    fill(0);
    text("2. Katapult", 660, 555);
    for (int i=0; i<player2Worms; i++) {
      Worm w = new Worm();
      w.position = new PVector(655+(i*20), 585);
      w.Draw();
    }
    zone1.Draw();
    catapult1.Draw();
    zone2.Draw();
    catapult2.Draw();
  
    //rubbers
    fill(255, 0, 0);
    stroke(255, 0, 0);
    strokeWeight(4);
    line(cat1Pos.x-27, cat1Pos.y-76, rubber.x, rubber.y);
    line(cat1Pos.x+27, cat1Pos.y-76, rubber.x, rubber.y);
    line(cat2Pos.x-27, cat2Pos.y-76, rubber2.x, rubber2.y);
    line(cat2Pos.x+27, cat2Pos.y-76, rubber2.x, rubber2.y);
    strokeWeight(1);
  
    if (catapult1.shot) {
      pushMatrix();
      translate(wormPosition.x, wormPosition.y);
      rotate(millis()/100.0f);
      scale(1, 1);
      worm.Draw();
      popMatrix();
    } else if (catapult2.shot) {
      pushMatrix();
      translate(wormPosition2.x, wormPosition2.y);
      rotate(millis()/100.0f);
      scale(1, 1);
      worm2.Draw();
      popMatrix();
    }
  
    if (zone1.active) {
      worm.Draw();
      fill(255);
      stroke(255, 255, 0);
      line(mouseX, mouseY, arrow.x, arrow.y);
      pushMatrix();
      translate(arrow.x, arrow.y);
      rotate(atan2(arrow.y-mouseY, arrow.x-mouseX));
      triangle(0, 0, -20, +10, -20, -10);
      popMatrix();
    } else if (zone2.active) {
      worm2.Draw();
      fill(255);
      stroke(255, 255, 0);
      line(mouseX, mouseY, arrow.x, arrow.y);
      pushMatrix();
      translate(arrow.x, arrow.y);
      rotate(atan2(arrow.y-mouseY, arrow.x-mouseX));
      triangle(0, 0, -20, +10, -20, -10);
      popMatrix();
    }
    
    for (PVector impact : impacts) {
      fill(0);
      noStroke();
      arc(impact.x, impact.y, 80, 80, 0, PI, OPEN);
    }
  }
}

void update() {
  if (cat1Button.Contains(mouseX, mouseY)) {
    cat1Button.selected = true;
  } else {
    cat1Button.selected = false;
  }
  if (cat2Button.Contains(mouseX, mouseY)) {
    cat2Button.selected = true;
  } else {
    cat2Button.selected = false;
  }
  if (catapult1.shot) {
    velocity.y -= gravity;
    if (wormPosition.x < 400 || hillsLoc.x <= -1200) {
      wormPosition.x += velocity.x;
    } else {
      moveCameraRight(velocity.x);
    }
    wormPosition.y -= velocity.y;
    if (wormPosition.x > 200 && wormPosition.y > 400 || wormPosition.x < 0 || wormPosition.x > 800 || wormPosition.y > 600) {
      if (wormPosition.x > cat2Pos.x-100 && wormPosition.x < cat2Pos.x+100 && endGame == false) {
        endGame = true;
        winner = 1;
        last_time = millis();
      } else if (player1Worms == 0 && player2Worms == 0 && endGame == false) {
        endGame = true;
        winner = 0;
        last_time = millis();
      } else {
        catapult1.shot = false;
        player1 = false;
        if (wormPosition.y >= 400) {
          impacts.add(new PVector(wormPosition.x, wormPosition.y));
        }
      }
    }
  } else if (catapult2.shot) {
    velocity.y -= gravity;
    if (wormPosition2.x > 400 || hillsLoc.x >= 0) {
      wormPosition2.x -= velocity.x;
    } else {
      moveCameraLeft(velocity.x);
    }
    wormPosition2.y -= velocity.y;
    if (wormPosition2.x < 600 && wormPosition2.y > 400 || wormPosition2.x > 800 || wormPosition2.x < 0 || wormPosition2.y > 600) {
      if (wormPosition2.x > cat1Pos.x-100 && wormPosition2.x < cat1Pos.x+100 && endGame == false) {
        endGame = true;
        winner = 2;
        last_time = millis();
      } else if (player1Worms == 0 && player2Worms == 0 && endGame == false) {
        endGame = true;
        winner = 0;
        last_time = millis();
      }else {
        catapult2.shot = false;
        player1 = true;
        if (wormPosition2.y >= 400) {
          impacts.add(new PVector(wormPosition2.x, wormPosition2.y));
        }
      }
    }
  }else if (zone1.active) {
    wormPosition.x = mouseX;
    wormPosition.y = mouseY;
    rubber.x = mouseX;
    rubber.y = mouseY;
    worm.position.x = mouseX;
    worm.position.y = mouseY;
    arrow.x = mouseX + (cat1Pos.x - mouseX)*1.5;
    arrow.y = mouseY - (mouseY - (cat1Pos.y-80))*1.5;
  } else if (zone2.active) {
    wormPosition2.x = mouseX;
    wormPosition2.y = mouseY;
    rubber2.x = mouseX;
    rubber2.y = mouseY;
    worm2.position.x = mouseX;
    worm2.position.y = mouseY;
    arrow.x = mouseX + (cat2Pos.x - mouseX)*1.5;
    arrow.y = mouseY - (mouseY - (cat2Pos.y-80))*1.5;
  }
  if (!zone1.active) {
    rubber = new PVector(cat1Pos.x, cat1Pos.y-60);
    worm.position.x = 0;
    worm.position.y = 0;
  }
  if (!zone2.active) {
    rubber2 = new PVector(cat2Pos.x, cat2Pos.y-60);
    worm2.position.x = 0;
    worm2.position.y = 0;
  }
  
  if (toLeft) {
    moveCameraLeft(20);
    if (hillsLoc.x == 0) {toLeft = false;}
  } else if (toRight) {
    moveCameraRight(20);
    if (hillsLoc.x == -1200) {toRight = false;}
  }
}

void mousePressed() {
  if (mouseButton == LEFT) {
    if (zone1.Contains(mouseX, mouseY) && catapult1.shot == false && player1 == true) {
      zone1.active = true;
      player1Worms -= 1;
    } else if (zone2.Contains(mouseX, mouseY) && catapult2.shot == false && player1 == false) {
      zone2.active = true;
      player2Worms -= 1;
    }
    if (cat1Button.Contains(mouseX, mouseY)) {
      toLeft = true;
    }
    if (cat2Button.Contains(mouseX, mouseY)) {
      toRight = true;
    }
  }
}

void mouseReleased() {
  if (zone1.active) {
    velocity.x = (int) ((cat1Pos.x - mouseX)/10);
    velocity.y = (int) ((mouseY - (cat1Pos.y-80))/10);
    catapult1.shot = true;
    zone1.active = false;
  } else if (zone2.active) {
    velocity.x = (int) ((mouseX - cat2Pos.x)/10);
    velocity.y = (int) ((mouseY - (cat2Pos.y-80))/10);
    catapult2.shot = true;
    zone2.active = false;
  }
}

void keyPressed() {
  float speed = 12;
  if (keyCode == LEFT && hillsLoc.x < 0) {
    moveCameraLeft(speed);
  }
  else if (keyCode == RIGHT && hillsLoc.x > -1200) {
    moveCameraRight(speed);
  }
}

void moveCameraRight(float speed) {
  if (hillsLoc.x > -1200) {
    hillsLoc.x -= speed;
    groundLoc.x -= (int) speed+(speed/4);
    cat1Pos.x -= (int) speed+(speed/4);
    cat2Pos.x -= (int) speed+(speed/4);
    zone1.position.x -= (int)speed+(speed/4);
    zone2.position.x -= (int)speed+(speed/4);
    for (PVector impact : impacts) {
      impact.x -= (int)speed+(speed/4);
    }
    if (hillsLoc.x < -1200) {
      hillsLoc.x = -1200;
      groundLoc.x = -1700;
      cat2Pos.x = 600;
      zone2.position.x = 600;
    }
  }
}

void moveCameraLeft(float speed) {
  if (hillsLoc.x < 0) {
    hillsLoc.x += speed;
    groundLoc.x += (int)speed+(speed/4);
    cat1Pos.x += (int)speed+(speed/4);
    cat2Pos.x += (int)speed+(speed/4);
    zone1.position.x += (int)speed+(speed/4);
    zone2.position.x += (int)speed+(speed/4);
    for (PVector impact : impacts) {
      impact.x += (int)speed+(speed/4);
    }
    if (hillsLoc.x > 0) {
      hillsLoc.x = 0;
      groundLoc.x = 0;
      cat1Pos.x = 200;
      zone1.position.x = 200;
    }
  }
}

void jumpLeftSide() {
  hillsLoc.x = 0;
  groundLoc.x = 0;
  cat1Pos.x = 200;
  zone1.position.x = 200;
  cat2Pos.x = 2100;
  zone2.position.x = 2100;
}

void jumpRightSide() {
  hillsLoc.x = -1200;
  groundLoc.x = -1700;
  cat2Pos.x = 600;
  zone2.position.x = 600;
  cat1Pos.x = -1300;
  zone1.position.x = -1300;
}
