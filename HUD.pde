class HUD {

  HUD() {
  }

  void draw(boolean paused) {    
    //splitting the exercise screen on the left into 4 quadrants,
    //giving each one a label from 1 to 4 and
    //color coding the background
    strokeWeight(1);
    stroke(0);
    fill(255, 240, 240);
    rect(0, 30, 500, 500);
    textSize(25);
    fill(0, 75);
    text("1", 15, 65);
    fill(240, 255, 240);
    rect(500, 30, 500, 500);
    textSize(25);
    fill(0, 75);
    text("2", 515, 65);
    fill(240, 240, 255);
    rect(0, 530, 500, 500);
    textSize(25);
    fill(0, 75);
    text("3", 15, 565);
    fill(255, 255, 240);
    rect(500, 530, 500, 500);
    textSize(25);
    fill(0, 75);
    text("4", 515, 565);
    
    //lines seperating each area on the screen
    fill(0);
    line(1000, 0, 1000, 1030);
    line(500, 30, 500, 1030);
    line(0, 530, 1000, 530);
    line(0, 30, 1300, 30);
    
    //header texts
    fill(0);
    textSize(16);
    text("quadrant exercise", 500, 25);
    text("Network diagram", 1150, 25);
      
    //point that follows the users cursor to (hopefully) test the
    //algorithm in the future
    fill(255);
    stroke(0);
    strokeWeight(1);
    ellipse(mouseX, mouseY, 5, 5);
    
    if(paused) {
      unpause();
    } else {
      pause();
    }
    
  }
  
  void pause() {
    //Pause Button
    fill(255);
    strokeWeight(1);
    stroke(0);
    rect(1260,990,8,25);
    rect(1270,990,8,25);
  }
  
  void unpause() {
    fill(255);
    strokeWeight(1);
    stroke(0);
    triangle(1260,990, 1278, 1002.5, 1260, 1015);
  }
}
