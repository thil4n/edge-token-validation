import java.util.Random;
import groovy.json.JsonOutput;

// Function to generate a random matrix
def generateRandomMatrix(int rows, int cols) {
    Random random = new Random();
    def matrix = [];
    
    for (int i = 0; i < rows; i++) {
        def row = [];
        for (int j = 0; j < cols; j++) {
            row.add(random.nextInt(10));  // Generates random integers from 0 to 9
        }
        matrix.add(row);
    }
    
    return matrix;
}

// Function to multiply two matrices
def multiplyMatrices(matrixA, matrixB) {
    int rowsA = matrixA.size();
    int colsA = matrixA[0].size();
    int rowsB = matrixB.size();
    int colsB = matrixB[0].size();

    if (colsA != rowsB) {
        throw new IllegalArgumentException("Matrix dimensions do not match for multiplication");
    }

    def result = new int[rowsA][colsB];

    for (int i = 0; i < rowsA; i++) {
        for (int j = 0; j < colsB; j++) {
            int sum = 0;
            for (int k = 0; k < colsA; k++) {
                sum += matrixA[i][k] * matrixB[k][j];
            }
            result[i][j] = sum;
        }
    }
    return result;
}

// Define matrix size
int rows = 2;
int cols = 2;

// Generate two random matrices
def matrixA = generateRandomMatrix(rows, cols);
def matrixB = generateRandomMatrix(rows, cols);

// Compute the matrix multiplication
def resultMatrix = multiplyMatrices(matrixA, matrixB);

// Create a JSON object containing matrices and their product
def matricesJson = JsonOutput.toJson([
    "matrixA": matrixA,
    "matrixB": matrixB,
]);

// Store the JSON string in JMeter variables
vars.put("matricesJson", matricesJson);
vars.put("resultMatrix", JsonOutput.toJson(resultMatrix));
