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

const multiplyMatrices = (matrixA, matrixB) => {
    const rowsA = matrixA.length;
    const colsA = matrixA[0].length;
    const rowsB = matrixB.length;
    const colsB = matrixB[0].length;

    if (colsA !== rowsB) {
        throw new Error("Matrix dimensions do not match for multiplication");
    }

    const result = Array(rowsA).fill(null).map(() => Array(colsB).fill(0));

    for (let i = 0; i < rowsA; i++) {
        for (let j = 0; j < colsB; j++) {
            for (let k = 0; k < colsA; k++) {
                result[i][j] += matrixA[i][k] * matrixB[k][j];
            }
        }
    }

    return result;
};

const computation = async () => {
    // Start the timer
    const startTime = Date.now();

    // Generate two random matrices of size 100x100
    const size = 1000;
    const matrixA = generateRandomMatrix(size, size);
    const matrixB = generateRandomMatrix(size, size);

    // Perform matrix multiplication
    const result = multiplyMatrices(matrixA, matrixB);

    // End the timer
    const endTime = Date.now();
    const elapsedTime = endTime - startTime;

    // Return the result (only the elapsed time to avoid huge payloads)
    return {
        statusCode: 200,
        body: JSON.stringify({
            message: "Matrix multiplication complete",
            matrixSize: `${size}x${size}`,
            elapsedTime: `${elapsedTime} ms`,
        }),
    };
};

module.exports = {
	computation
}