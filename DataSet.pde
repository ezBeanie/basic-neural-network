class DataSet {

  int num = 0;
  Matrix data;
  Matrix labels;

  DataSet(int num) {

    this.num = num;
    data = new Matrix(num, 2);
    labels = new Matrix(4, num);

    for (int i = 0; i < num; i++) {
      int x = (int) random(1, 999);
      int y = (int )random(1, 999);
      Matrix label = label(x, y);
      data.data[i][0] = x;
      data.data[i][1] = y;
      labels.data[0][i] = label.data[0][0];
      labels.data[1][i] = label.data[1][0];
      labels.data[2][i] = label.data[2][0];
      labels.data[3][i] = label.data[3][0];
    }
  }

  Matrix label(int x, int y) {
    Matrix label = new Matrix(4, 1);
    if (x <= 500) {
      if (y <= 500) {
        label.data[0][0] = 1;
        label.data[1][0] = 0;
        label.data[2][0] = 0;
        label.data[3][0] = 0;
      } else if (y > 500 && y <= 1000) {
        label.data[0][0] = 0;
        label.data[1][0] = 0;
        label.data[2][0] = 1;
        label.data[3][0] = 0;
      }
    } else if (x > 500 && x <= 1000) {
      if (y <= 500) {
        label.data[0][0] = 0;
        label.data[1][0] = 1;
        label.data[2][0] = 0;
        label.data[3][0] = 0;
      } else if (y > 500 && y <= 1000) {
        label.data[0][0] = 0;
        label.data[1][0] = 0;
        label.data[2][0] = 0;
        label.data[3][0] = 1;
      }
    }
    return label;
  }
}
