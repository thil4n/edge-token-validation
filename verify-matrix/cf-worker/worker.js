export default {
  async fetch(request) {
    if (request.method !== "POST") {
      return new Response(
        JSON.stringify({ error: "Only POST requests are allowed" }),
        { status: 405, headers: { "Content-Type": "application/json" } }
      );
    }

    try {
      // Read request body
      const requestBody = await request.json();

      const { matrixA, matrixB } = requestBody;

      if (!Array.isArray(matrixA) || !Array.isArray(matrixB)) {
        throw new Error("Invalid matrices. Expecting two 2D arrays.");
      }

      // Start the timer
      const startTime = Date.now();

      // Perform matrix multiplication
      const result = multiplyMatrices(matrixA, matrixB);

      // End the timer
      const endTime = Date.now();
      const elapsedTime = endTime - startTime;

      // Return the result and elapsed time
      return new Response(
        JSON.stringify({
          message: "Matrix multiplication complete",
          elapsedTime: `${elapsedTime} ms`,
          result,
        }),
        { headers: { "Content-Type": "application/json" } }
      );
    } catch (error) {
      return new Response(
        JSON.stringify({ error: error.message }),
        { status: 400, headers: { "Content-Type": "application/json" } }
      );
    }
  },
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

  return result;
};
