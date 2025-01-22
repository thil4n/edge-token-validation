// Generate a random matrix
const generateRandomMatrix = (rows, cols) => {
  const matrix = [];
  for (let i = 0; i < rows; i++) {
    const row = [];
    for (let j = 0; j < cols; j++) {
      row.push(Math.random());
    }
    matrix.push(row);
  }
  return matrix;
};

// Perform matrix multiplication
const multiplyMatrices = (matrixA, matrixB) => {
  const rowsA = matrixA.length;
  const colsA = matrixA[0].length;
  const rowsB = matrixB.length;
  const colsB = matrixB[0].length;

  if (colsA !== rowsB) {
    throw new Error("Matrix dimensions do not match for multiplication");
  }

  const result = Array(rowsA)
    .fill(null)
    .map(() => Array(colsB).fill(0));

  for (let i = 0; i < rowsA; i++) {
    for (let j = 0; j < colsB; j++) {
      for (let k = 0; k < colsA; k++) {
        result[i][j] += matrixA[i][k] * matrixB[k][j];
      }
    }
  }

  console.log(result);

  return result;
};

// Cloudflare Worker handler
export default {
  async fetch(request) {
    const url = new URL(request.url);
    const size = 100;

    // Start the timer
    const startTime = Date.now();

    // Generate two random matrices
    const matrixA = generateRandomMatrix(size, size);
    const matrixB = generateRandomMatrix(size, size);

    // Perform matrix multiplication
    const result = multiplyMatrices(matrixA, matrixB);

    // End the timer
    const endTime = Date.now();
    const elapsedTime = endTime - startTime;

    // Return elapsed time
    return new Response(
      JSON.stringify({
        message: "Matrix multiplication complete",
        matrixSize: `${size}x${size}`,
        // result: result,
        elapsedTime: `${elapsedTime} ms`,
      }),
      { headers: { "Content-Type": "application/json" } }
    );
  },
};
