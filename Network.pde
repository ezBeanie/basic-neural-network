class Network {

  int inputCount, hiddenCount, outputCount, neuronCount;
  float learningRate;
  Matrix   inputNeurons, hiddenNeurons, outputNeurons, inputWeights, outputWeights, hiddenBias, outputBias;

  Network(int numI, int numH, int numO) {

    this.inputCount = numI;
    this.hiddenCount = numH;
    this.outputCount = numO;
    this.neuronCount = numI + numH + numO;

    this.inputNeurons = new Matrix(numI, 1);
    this.hiddenNeurons = new Matrix(numH, 1);
    this.outputNeurons = new Matrix(numO, 1);

    this.inputWeights = new Matrix(numH, numI);
    this.outputWeights = new Matrix(numO, numH);

    this.hiddenBias = new Matrix(numH, 1);
    this.outputBias = new Matrix(numO, 1);

    this.learningRate = 0.1;
  }

  Matrix feedForward(int x, int y) {
    Matrix m, input = new Matrix(inputCount, 1);
    inputNeurons.data[0][0] = x;
    inputNeurons.data[1][0] = y;
    input.data[0][0] = map(x, 0, 1000, 0, 1);
    input.data[1][0] = map(y, 0, 1000, 0, 1);
    m = Matrix.multiply(inputWeights, input);
    m = Matrix.add(m, hiddenBias);
    m = m.sigmoidF();

    hiddenNeurons = m;

    m = Matrix.multiply(outputWeights, hiddenNeurons);
    m = Matrix.add(m, outputBias);
    m = m.sigmoidF();

    //println(m.toString());
    outputNeurons = m;
    return m;
  }

  void train(Matrix input, Matrix target) {
    Matrix output = feedForward((int)input.data[0][0], (int)input.data[1][0]);
    Matrix outputError = Matrix.subtract(target, output); 

    Matrix gradient = Matrix.dSigmoidF(output);
    gradient = Matrix.product(gradient, outputError);
    gradient = Matrix.scale(gradient, learningRate);

    Matrix weightsDelta = Matrix.multiply(gradient, Matrix.transpose(hiddenNeurons));
    outputBias.add(gradient);
    outputWeights.add(weightsDelta);

    Matrix hiddenError = Matrix.multiply(Matrix.transpose(outputWeights), outputError);

    gradient = Matrix.dSigmoidF(hiddenNeurons);
    gradient = Matrix.product(gradient, hiddenError);
    gradient = Matrix.scale(gradient, learningRate);

    Matrix inputScaled = new Matrix(inputCount, 1);

    inputScaled.data[0][0] = map(inputNeurons.data[0][0], 0, 1000, 0, 1);
    inputScaled.data[1][0] = map(inputNeurons.data[1][0], 0, 1000, 0, 1);
    weightsDelta = Matrix.multiply(gradient, Matrix.transpose(inputScaled));
    hiddenBias.add(gradient);
    inputWeights.add(weightsDelta);

    /*println(Matrix.transpose(hiddenNeurons).toString() + "o");
     println(outputWeightsDelta.toString() + "p");*/
  }

  void randomize() {
    //inputNeurons.randomize(1000);
    hiddenNeurons.randomize();
    outputNeurons.randomize();

    //inputWeights.randomize();
    outputWeights.randomize();

    /*hiddenBias.randomize(2);
     outputBias.randomize;(2)*/
    for (int i = 0; i < hiddenCount; i++) {
      if (i%2 == 0) {
        hiddenBias.data[i][0] = 1;
      } else {
        hiddenBias.data[i][0] = 0;
      }
    }
    for (int i = 0; i < outputCount; i++) {
      if (i%2 == 0) {
        outputBias.data[i][0] = 1;
      } else {
        outputBias.data[i][0] = 0;
      }
    }
  }

  void draw() {
    drawLayer(color(255, 0, 0));
    rect(1000, 30, 300, 220);
    drawLayer(color(0, 255, 0));
    rect(1000, 250, 300, 220);
    drawLayer(color(0, 0, 255));
    rect(1000, 470, 300, 220);

    drawText();
    text("input layer", 1150, 60);
    text("hidden layer", 1150, 280);
    text("output layer", 1150, 500);

    //Drawing lines to visualize the network
    //green equals a weight close to 1
    //red equals a weight close to 0
    for (int i = 0; i < inputCount; i++) {
      int x1, y1, x2, y2;

      x1 = 1000 + (300 / inputCount) * (i + 1) - ((300 / inputCount) / 2);
      y1 = 100;
      x2 = x1;
      y2 = 150;

      drawWeight(0);
      line(x1, y1, x2, y2);
    }
    for (int i =  0; i < inputCount; i++) {
      int x1, y1, x2, y2;
      color c;

      x1 = 1000 + (300 / inputCount) * (i + 1) - ((300 / inputCount) / 2);
      y1 = 150;

      for (int j = 0; j < hiddenCount; j++) {
        x2 = 1000 + (300 / hiddenCount) * (j + 1) - ((300 / hiddenCount) / 2);
        y2 = 370;        
        c = color((1-inputWeights.data[j][i])*255, inputWeights.data[j][i]*255, 0);

        drawWeight(c);
        line(x1, y1, x2, y2);
      }
    }
    for (int i = 0; i < hiddenCount; i++) {
      int x1, y1, x2, y2;
      color c;

      x1 = 1000 + (300 / hiddenCount) * (i + 1) - ((300 / hiddenCount) / 2);
      y1 = 370;

      for (int j = 0; j < outputCount; j++) {
        x2 = 1000 + (300 / outputCount) * (j + 1) - ((300 / outputCount) / 2);
        y2 = 590;
        c = color((1-outputWeights.data[j][i])*255, outputWeights.data[j][i]*255, 0);

        drawWeight(c);
        line(x1, y1, x2, y2);
      }
    }
    for (int i = 0; i < outputCount; i++) {
      int x1, y1, x2, y2;

      x1 = 1000 + (300 / outputCount) * (i + 1) - ((300 / outputCount) / 2);
      y1 = 590;
      x2 = x1;
      y2 = 640;

      drawWeight(0);
      line(x1, y1, x2, y2);
    }

    drawNeuron();
    for (int i = 0; i < inputCount; i++) {
      int x = 1000 + (300 / inputCount) * (i + 1) - ((300 / inputCount) / 2);
      drawNeuron();
      ellipse(x, 150, 40, 40);
      drawSum();
      text((int)inputNeurons.data[i][0], x, 155);
    }
    for (int i = 0; i < hiddenCount; i++) {
      color c;
      int x = 1000 + (300 / hiddenCount) * (i + 1) - ((300 / hiddenCount) / 2);
      c = color((1-hiddenBias.data[i][0])*255, hiddenBias.data[i][0]*255, 0, 200);
      drawNeuron(c);
      ellipse(x, 370, 40, 40);
      drawSum();
      text(hiddenNeurons.data[i][0], x, 375);
    }
    for (int i = 0; i < outputCount; i++) {
      color c;
      int x = 1000 + (300 / outputCount) * (i + 1) - ((300 / outputCount) / 2);
      c = color((1-outputBias.data[i][0])*255, outputBias.data[i][0]*255, 0, 200);
      drawNeuron(c);
      ellipse(x, 590, 40, 40);
      drawSum();
      text(outputNeurons.data[i][0], x, 595);
      text((i+1) + "", x-15, 620);
    }
  }

  float sigmoidF(float input) {
    return 1/(1+exp(-input));
  }

  Matrix getInputWeights() {
    return inputWeights;
  }

  void drawText() {
    fill(0, 50);
    textSize(25);
    textAlign(CENTER);
    noStroke();
  }

  void drawLayer(color c) {
    fill(c, 25);
    noStroke();
  }

  void drawNeuron() {
    fill(255);
    textAlign(CENTER);
    strokeWeight(2);
    stroke(0);
  }

  void drawNeuron(color c) {
    fill(c);
    textAlign(CENTER);
    strokeWeight(2);
    stroke(0);
  }

  void drawWeight(color c) {
    fill(0, 200);
    strokeWeight(1);
    stroke(c);
  }

  void drawSum() {
    textSize(12);
    textAlign(CENTER);
    fill(0);
  }
}
