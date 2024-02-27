public class maxOps {

  maxOps() {
  }

  //---------------------------------------------------
  // OUTPUT FUNCTIONS
  //Log matrix to console;
  void logMatrix(float[][] a) {
    for (int i=0; i<a.length; i++) {
      for (int j=0; j<a[i].length; j++) {
        print("["+a[i][j]+"]");
      }
      println();
    }
    println();
  }
  //Log structure to console;
  void logStructure(float[][] a) {
    for (int i=0; i<a.length; i++) {
      for (int j=0; j<a[i].length; j++) {
        print("["+i+","+j+"]");
      }
      println();
    }
    println();
  }
  //Write matrix to CSV file;
  void writeMatrix(float[][] a, String fileName) {
    PrintWriter out = createWriter(fileName+".csv");
    for (int i=0; i<a.length; i++) {
      for (int j=0; j<a[i].length; j++) {
        if (j==a[i].length-1)out.print(str(a[i][j]));
        else out.print(str(a[i][j])+",");
      }
      out.println();
    }
    out.flush();
    out.close();
  }
  // "a concrete example of some quality or condition"
  PImage pictureMatrix(float[][] a) {
    PImage pic = createImage(getM(a), getN(a), RGB);
    pic.loadPixels();
    for (int i=0; i<a.length; i++) {
      for (int j=0; j<a[i].length; j++) {
        pic.pixels[j+(i*getM(a))] = color(a[i][j]);
      }
    }
    pic.updatePixels();
    return pic;
  }

  //---------------------------------------------------
  // CREATE NULL-MATRICES
  // Create null-matrix of m x n type;
  float[][] createNullMatrix(int m, int n) {
    float[][] a = new float[n][m];
    return a;
  }
  // Create null-matrix of n order;
  float[][] createNullMatrix(int n) {
    float[][] a = new float[n][n];
    return a;
  }
  //Create null-matrix from image file;
  float[][] createNullMatrix(PImage img) {
    float[][] a = new float[img.height][img.width];
    return a;
  }
  //---------------------------------------------------
  // CREATE AND PACK MATRICES
  // Create matrix of the m x n type and pack it with b;
  float[][] createPackMatrix(int m, int n, int b) {
    float[][] a = createNullMatrix(m, n);
    a = packMatrixValue(a, b);
    return a;
  }
  // Create matrix of the n order and pack it with b;
  float[][] createPackMatrix(int n, int b) {
    float[][] a = createNullMatrix(n);
    a = packMatrixValue(a, b);
    return a;
  }
  // Create a matrix from image file and pack it with color-values from file; // not cool! single type / byte to float
  float[][] createPackMatrix(PImage img, int c) {
    if (c>=0 && c<=5) {
      float[][] a = createNullMatrix(img);
      for (int i=0; i<a.length; i++) {
        for (int j=0; j<a[i].length; j++) {
          if (c==0)a[i][j] = red(img.get(j, i));
          if (c==1)a[i][j] = green(img.get(j, i));
          if (c==2)a[i][j] = blue(img.get(j, i));
          if (c==3)a[i][j] = hue(img.get(j, i));
          if (c==4)a[i][j] = saturation(img.get(j, i));
          if (c==5)a[i][j] = brightness(img.get(j, i));
        }
      }
      return a;
    } else return null;
  }
  //Create matrix from array;
  float[][] createPackMatrix(float[] v, int m, int n) {
    if (m*n==v.length) {
      float[][] a = createNullMatrix(m, n);
      for (int i=0; i<a.length; i++) {
        for (int j=0; j<a[i].length; j++) {
          a[i][j] = v[j+(i*getM(a))];
        }
      }
      return a;
    } else return null;
  }
  //---------------------------------------------------
  // PACK MATRICES
  // Pack matrix with single value;
  float[][] packMatrixValue(float[][] a, float b) {
    for (int i=0; i<a.length; i++) {
      for (int j=0; j<a[i].length; j++) {
        a[i][j] = b;
      }
    }
    return a;
  }
  //Pack matrix with element index;
  float[][] packMatrixIndex(float[][] a) {
    for (int i=0; i<a.length; i++) {
      for (int j=0; j<a[i].length; j++) {
        a[i][j] = j+(i*getM(a));
      }
    }
    return a;
  }

  //Pack matrix with random values (max)
  float[][] packRandom(float a[][], float max) {
    for (int i=0; i<a.length; i++) {
      for (int j=0; j<a[i].length; j++) {
        a[i][j] = random(max);
      }
    }
    return a;
  }

  //Pack matrix with random values (min, max)
  float[][] packRandom(float a[][], float min, float max) {
    for (int i=0; i<a.length; i++) {
      for (int j=0; j<a[i].length; j++) {
        a[i][j] = random(min, max);
      }
    }
    return a;
  }

  //Pack matrix with noise values
  float[][] packNoise(float a[][], float off) {
    int index = 0;
    for (int i=0; i<a.length; i++) {
      for (int j=0; j<a[i].length; j++) {
        a[i][j] = noise(index*off);
        index++;
      }
    }
    return a;
  }

  float[][] packNoise(float a[][], float xoff, float yoff) {
    for (int i=0; i<a.length; i++) {
      for (int j=0; j<a[i].length; j++) {
        a[i][j] = noise(i*xoff, j*yoff);
      }
    }
    return a;
  }




  //---------------------------------------------------
  // GET MATRIX INFO
  // Get matrix m (width)
  int getM(float[][] a) {
    return a[0].length;
  }
  // Get matrix n (height)
  int getN(float[][] a) {
    return a.length;
  }
  // Get matrix "resolution" (m x n)
  int getR(float[][] a) {
    return (getM(a)*getN(a));
  }
  //Verify if matrix is square;
  boolean isSquare(float[][] a) {
    boolean b = false;
    if (getM(a)==getN(a))b= true;
    return b;
  }
  //Verify if the dimensions of two matrices match
  boolean sameType(float[][] a, float[][] b) {
    if (getM(a)==getM(b) && getN(a)==getN(b))return true;
    else return false;
  }
  //Get column;
  //Get row;
  //Get diagonal elements;
  float[] getMainElements(float[][] a) {
    if (isSquare(a)) {
      float[] d = new float[getM(a)];
      for (int i=0; i<getM(a); i++) {
        d[i] = a[i][i];
      }
      return d;
    } else return null;
  }
  //---------------------------------------------------
  //UTILITIES
  // Help
  void getHelp() {
  }
  //Change element
  float[][] changeElement(float[][] a, int i, int j, float b) {
    a[i][j] = b;
    return a;
  }
  //Change row with single val or new array
  float[][] changeRow(float[][]a) {
    return a;
  }
  //Change column with single val or new array
  float[][] changeColumn(float[][]a) {
    return a;
  }
  //Add element
  //Remove element

  //---------------------------------------------------
  //OPERATIONS

  //scalar

  float[][] scalar(float[][] a, float b) {
    for (int i=0; i<a.length; i++) {
      for (int j=0; j<a[i].length; j++) {
        a[i][j] = a[i][j]*b;
      }
    }
    return a;
  }


  // Hadamard Multiplication
  float[][] hadamard(float[][] a, float[][] b) {
    if (sameType(a, b)) {
      float[][] ab = new float[getN(a)][getM(a)];
      for (int i=0; i<a.length; i++) {
        for (int j=0; j<a[i].length; j++) {
          ab[i][j] = a[i][j] * b[i][j];
        }
      }
      return ab;
    } else {
      return null;
    }
  }

  // average
  float[][] average(float[][] a, float[][] b) {
    if (sameType(a, b)) {
      float[][] ab = new float[getN(a)][getM(a)];
      for (int i=0; i<a.length; i++) {
        for (int j=0; j<a[i].length; j++) {
          ab[i][j] = (a[i][j] + b[i][j])/2;
        }
      }
      return ab;
    } else {
      return null;
    }
  }


  //Transpose matrix
  float[][] transposeMatrix(float[][] a) {
    float[][] t = createNullMatrix(getN(a), getM(a));
    for (int i=0; i<t.length; i++) {
      for (int j=0; j<t[i].length; j++) {
        t[i][j] = a[j][i];
      }
    }
    return t;
  }
  //Rotate Matrix (90 ccw)
  float[][] rotateMatrix(float[][] a) {
    a = transposeMatrix(a);
    float[][] r = createNullMatrix(getM(a), getN(a));
    for (int j=0; j<a[0].length; j++) {
      for (int i=a.length-1; i>=0; i--) {
        r[(a.length-1-i)][j] = a[i][j];
      }
    }
    return r;
  }
  //Turn square matrix into an upper triangular matrix;
  float[][] makeU (float[][] a) {
    if (isSquare(a)) {
      for (int i=0; i<a.length; i++) {
        for (int j=0; j<a[i].length; j++) {
          if (j<i)a[i][j] = 0;
        }
      }
      return a;
    } else return null;
  }
  //Turn square matrix into a lower triangular matrix;
  float[][] makeL(float[][] a) {
    if (isSquare(a)) {
      for (int i=0; i<a.length; i++) {
        for (int j=0; j<a[i].length; j++) {
          if (j>i)a[i][j] = 0;
        }
      }
      return a;
    } else return null;
  }




  //Map Functions
  //Map sine
  float[][] mapSine(float[][] a) {
    for (int i=0; i<a.length; i++) {
      for (int j=0; j<a[i].length; j++) {
        a[i][j] = sin(radians(a[i][j]));
      }
    }
    return a;
  }

  //Map sine
  float[][] mapSine(float[][] a, float f) {
    for (int i=0; i<a.length; i++) {
      for (int j=0; j<a[i].length; j++) {
        a[i][j] = sin(radians(a[i][j]*f));
      }
    }
    return a;
  }

  //Map sine
  float[][] mapSine(float[][] a, float f, float t) {
    for (int i=0; i<a.length; i++) {
      for (int j=0; j<a[i].length; j++) {
        a[i][j] = sin(radians(a[i][j]*f+t));
      }
    }
    return a;
  }
}
