HUD hud = new HUD();
Network neuralNetwork = new Network(2, 2, 4);
DataSet dataSet = new DataSet(5000000);
boolean paused = true;
int frames = 0;

void setup() {
  size(1300, 1030);
  frameRate(144);

  neuralNetwork.randomize();
}

void draw() {
  background(255);
  if (!paused) {
    for(int i = 0; i < 11; i++) {
    Matrix input = new Matrix(neuralNetwork.inputCount, 1);
    Matrix target = new Matrix(neuralNetwork.outputCount, 1);

    input.data[0][0] = dataSet.data.data[frames % dataSet.num][0];
    input.data[1][0] = dataSet.data.data[frames % dataSet.num][1];

    target.data[0][0] = dataSet.labels.data[0][frames % dataSet.num];
    target.data[1][0] = dataSet.labels.data[1][frames % dataSet.num];
    target.data[2][0] = dataSet.labels.data[2][frames % dataSet.num];
    target.data[3][0] = dataSet.labels.data[3][frames % dataSet.num];
    //println(frames % dataSet.num);
    neuralNetwork.train(input, target);
    frames++;
    }
  }
  /*println(mouseX + " | " + mouseY + " | " + dataSet.label(mouseX, mouseY - 30));
   println(dataSet.label(mouseX, mouseY - 30).rows, dataSet.label(mouseX, mouseY - 30).cols);*/

  //println(dataSet.data.toString() + " | " + dataSet.labels.toString());

  neuralNetwork.draw();
  hud.draw(paused);
  fill(0);
  textAlign(LEFT);
  text(frames + " iterations of training", 1010, 1010);
}

void mouseMoved() {
  if(paused) neuralNetwork.feedForward(min(1000, mouseX), min(1000, mouseY - 30));
}

void mouseClicked() {
  if (mouseX >= 1260 && mouseX <= 1280) {
    if (mouseY >= 990 && mouseY <= 1015) {
      paused = !paused;
    }
  }
}
