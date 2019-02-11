static class Matrix extends PApplet {

  int rows, cols;
  float[][] data;

  Matrix(int rows, int cols) {
    this.rows = rows;
    this.cols = cols;
    this.data = new float[rows][cols];

    for (int i = 0; i < this.rows; i++) {
      for (int j = 0; j < this.cols; j++) {
        data[i][j] = 0;
      }
    }
  }

  Matrix(float[][] m) {
    this.rows = m.length;
    this.cols = m[0].length;
    this.data = m;
  }

  static Matrix scale(Matrix a, float s) {
    Matrix m = new Matrix(a.rows, a.cols);;
    for (int i = 0; i < m.rows; i++) {
      for (int j = 0; j < m.cols; j++) {
        m.data[i][j] = a.data[i][j] * s;
      }
    }    
    return m;
  }
  
  static Matrix product(Matrix a, Matrix b) {
    Matrix m = new Matrix(a.rows, a.cols);
    if (a.rows == b.rows && a.cols == b.cols) {
      for (int i = 0; i < a.rows; i++) {
        for (int j = 0; j < a.cols; j++) {
          m.data[i][j] = a.data[i][j] * b.data[i][j];
        }
      }
      return m;
    } else {
      throw new IllegalArgumentException("Number of rows and columns of each matrix must be equivalent.");
    }
  }

  static Matrix add(Matrix a, int s) {
    Matrix m = new Matrix(a.rows, a.cols);
    for (int i = 0; i < a.rows; i++) {
      for (int j = 0; j < a.cols; j++) {
        m.data[i][j] = a.data[i][j] + s;
      }
    }    
    return m;
  }

  Matrix add(int s) {
    Matrix a = this;
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        a.data[i][j] = a.data[i][j] + s;
      }
    }    
    return a;
  }

  static Matrix add(Matrix a, Matrix b) {
    Matrix m = new Matrix(a.rows, a.cols);
    if (a.rows == b.rows && a.cols == b.cols) {
      for (int i = 0; i < a.rows; i++) {
        for (int j = 0; j < a.cols; j++) {
          m.data[i][j] = a.data[i][j] + b.data[i][j];
        }
      }
      return m;
    } else {
      throw new IllegalArgumentException("Number of rows and columns of each matrix must be equivalent.");
    }
  }

  Matrix add(Matrix b) {
    Matrix a = this;
    if (a.rows == b.rows && a.cols == b.cols) {
      for (int i = 0; i < a.rows; i++) {
        for (int j = 0; j < a.cols; j++) {
          a.data[i][j] = a.data[i][j] + b.data[i][j];
        }
      }
      return this;
    } else {
      throw new IllegalArgumentException("Number of rows and columns of each matrix must be equivalent.");
    }
  }

  static Matrix subtract(Matrix a, Matrix b) {
    Matrix m = new Matrix(a.rows, a.cols);
    if (a.rows == b.rows && a.cols == b.cols) {
      for (int i = 0; i < a.rows; i++) {
        for (int j = 0; j < a.cols; j++) {
          m.data[i][j] = a.data[i][j] - b.data[i][j];
        }
      }
      return m;
    } else {
      throw new IllegalArgumentException("Number of rows and columns of each matrix must be equivalent.");
    }
  }

  Matrix subtract(Matrix b) {
    Matrix a = this;
    if (a.rows == b.rows && a.cols == b.cols) {
      for (int i = 0; i < a.rows; i++) {
        for (int j = 0; j < a.cols; j++) {
          a.data[i][j] = a.data[i][j] - b.data[i][j];
        }
      }
      return this;
    } else {
      throw new IllegalArgumentException("Number of rows and columns of each matrix must be equivalent.");
    }
  }

  static Matrix multiply(Matrix a, Matrix b) {
    Matrix m;
    if (a.cols == b.rows) {
      if (b.cols == 1) {
        m = new Matrix(a.rows, 1);
      } else { 
        m = new Matrix(a.rows, b.cols);
      }
      for (int i = 0; i < m.rows; i++) {
        for (int j = 0; j < m.cols; j++) {
          for (int k = 0; k < a.cols; k++) {
            m.data[i][j] += (a.data[i][k] * b.data[k][j]);
          }
        }
      }
      return m;
    } else {
      throw new IllegalArgumentException("Number of rows for left matrix and columns for right matrix must be equivalent.");
    }
  }

  static Matrix sigmoidF(Matrix a) {
    Matrix m = new Matrix(a.rows, a.cols);
    for (int i = 0; i < a.rows; i++) {
      for (int j = 0; j < a.cols; j++) {
        m.data[i][j] = sigmoidF(a.data[i][j]);
      }
    }
    return m;
  }

  Matrix sigmoidF() {
    Matrix a = this;
    for (int i = 0; i < a.rows; i++) {
      for (int j = 0; j < a.cols; j++) {
        a.data[i][j] = sigmoidF(a.data[i][j]);
      }
    }
    return this;
  }
  
  static Matrix dSigmoidF(Matrix a) {
    Matrix m = new Matrix(a.rows, a.cols);
    for (int i = 0; i < a.rows; i++) {
      for (int j = 0; j < a.cols; j++) {
        m.data[i][j] = a.data[i][j] * (1 - a.data[i][j]);;
      }
    }
    return m;
  }
  
  Matrix dSigmoidF() {
    Matrix a = this;
    for (int i = 0; i < a.rows; i++) {
      for (int j = 0; j < a.cols; j++) {
        a.data[i][j] = a.data[i][j] * (1 - a.data[i][j]);;
      }
    }
    return a;
  }

  static Matrix transpose(Matrix a) {
    Matrix m = new Matrix(a.cols, a.rows);
    for (int i = 0; i < a.cols; i++) {
      for (int j = 0; j < a.rows; j++) {
        m.data[i][j] = a.data[j][i];
      }
    }
    return m;
  }

  Matrix transpose() {
    Matrix a = this;
    for (int i = 0; i < a.cols; i++) {
      for (int j = 0; j < a.rows; j++) {
        a.data[i][j] = a.data[j][i];
      }
    }
    return this;
  }

  void randomize(float s) {
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        data[i][j] = random(0, s);
      }
    }
  }

  void randomize(int s) {
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        data[i][j] = (float) Math.floor(random(0, s));
      }
    }
  }

  void randomize() {
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        data[i][j] = random(0, 1);
      }
    }
  }

  static float sigmoidF(float input) {
    return 1/(1+exp(-input));
  }

  String toString() {
    String s = new String();
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        s += data[i][j] + " ";
      }
      s += "\n";
    }
    return s;
  }
}
