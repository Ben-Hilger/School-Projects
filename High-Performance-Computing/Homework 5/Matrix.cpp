// Copyright (C) 2021 Ben Hilger

#ifndef MATRIX_CPP
#define MATRIX_CPP

#include <cassert>
#include <vector>
#include "Matrix.h"

Matrix::Matrix(const size_t row, const size_t col, const Val initVal) :
    std::vector<Val>(row * col, initVal) {
    // Set the rows and columns
    this->rows = row;
    this->cols = col;
}

// Operator to write the matrix to a given output stream
std::ostream& operator<<(std::ostream& os, const Matrix& matrix) {
    // Print the number of rows and columns to ease reading
    os << matrix.height() << " " << matrix.width() << '\n';
    // Print each entry to the output stream.
    for (size_t row = 0; row < matrix.height(); row++) {
        for (size_t col = 0; col < matrix.width(); col++) {
            os << matrix.get(row, col) << " ";
        }
        // Print a new line at the end of each row just to format the
        // output a bit nicely.
        os << '\n';
    }
    return os;
}

// Operator to read the matrix to a given input stream.
std::istream& operator>>(std::istream& is, Matrix& matrix) {
    // Temporary variables to load matrix sizes
    int height, width;
    is >> height >> width;
    // Now initialize the destination matrix to ensure it is of the
    // correct dimension.
    matrix = Matrix(height, width);
    // Read each entry from the input stream.
    for (size_t row = 0; row < matrix.height(); row++) {
        for (size_t col = 0; col < matrix.width(); col++) {
            Val val;
            is >> val;
            matrix.set(row, col, val);
        }
    }
    return is;
}

Matrix Matrix::dot(const Matrix& rhs, Matrix& result) {
    // Ensure the dimensions are similar.
    assert(width() == rhs.height());
    // Setup the result matrix
    const auto mWidth = rhs.width(), w = width();
    // Resize the matrix
    result.resizeMatrix(height(), mWidth);
    for (size_t row = 0; (row < height()); row++) {
        for (size_t col = 0; (col < mWidth); col++) {
            Val sum = 0;
            for (size_t i = 0; (i < w); i++) {
                sum += get(row, i) * rhs.get(i, col);
            }
            // Store the result in an appropriate entry
            result.set(row, col, sum);
        }
    }
    // Return the computed result
    return result;
}

Matrix Matrix::transpose(Matrix& result) {
    // If the matrix is empty, then there is nothing much to do.
    if (empty()) {
        return *this;
    }
    // Resize the result matrix
    result.resizeMatrix(width(), height());
    // Now copy the values creating the transpose
    for (size_t row = 0; (row < height()); row++) {
        for (size_t col = 0; (col < width()); col++) {
            result.set(col, row, get(row, col));
        }
    }
    // Return the resulting transpose.
    return result;
}

#endif
