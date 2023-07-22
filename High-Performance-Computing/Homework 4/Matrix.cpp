// Copyright 2021 Ben Hilger
#ifndef MATRIX_CPP
#define MATRIX_CPP

#include <cassert>
#include <vector>
#include <string>
#include "Matrix.h"

Matrix::Matrix(const size_t row, const size_t col, const Val initVal) :
    std::vector<std::vector<Val>>(row, std::vector<Val>(col, initVal)) {
}

// Operator to write the matrix to a given output stream
std::ostream& operator<<(std::ostream& os, const Matrix& matrix) {
    // Print the number of rows and columns to ease reading
    os << matrix.height() << " " << matrix.width() << '\n';
    // Print each entry to the output stream.
    for (auto& row : matrix) {
        for (auto& val : row) {
            os << val << " ";
        }
        // Print a new line at the end of each row just to format the
        // output a bit nicely.
        os << '\n';
    }
    return os;
}

// Operator to read the matrix from the given input stream
std::istream& operator>>(std::istream& is, Matrix& matrix) {
    // Read in the rows and columns
    ulong row, col;
    is >> row >> col;
    // Create a new matrix with the row and col grabbed from the input
    matrix = Matrix(row, col, 0);
    // Iterate through the matrix
    for (int r = 0; r < matrix.height(); r++) {
        for (int c = 0; c < matrix.width(); c++) {
            // Add the next value in the file to the current row and column
            is >> matrix[r][c];
        }
    }
    // Return the input stream
    return is;
}

// Operator to add matricies together
Matrix Matrix::operator+(const Matrix& rhs) const {
    // Create a matrix with the same height and width as the matrix given
    Matrix matrix = Matrix(rhs.height(), rhs.width(), 0);
    // Iterate through the height and width of the matricies 
    for (int r = 0; r < rhs.height(); r++) {
        for (int c = 0; c < rhs.width(); c++) {
            // Add the current value from the current and given matrix 
            // and store the result in the new matrix
            matrix[r][c] = rhs.at(r).at(c) + this->at(r).at(c);
        }
    }
    // Return the new matrix
    return matrix;
}

// Operator to multiply two matricies together
Matrix Matrix::operator*(const Matrix& rhs) const {
    // Create a matrix with the same height and width as the given matrix
    Matrix matrix = Matrix(rhs.height(), rhs.width(), 0);
    // Iterate through the given and current matrix
    for (int r = 0; r < rhs.height(); r++) {
        for (int c = 0; c < rhs.width(); c++) {
            // Multiply the current value of the current and given matricies
            // and store the result in the new matrix
            matrix[r][c] = this->at(r).at(c) * rhs.at(r).at(c);
        }
    }
    // Return the new matrix
    return matrix;
}

// Operator to subtract two matricies
Matrix Matrix::operator-(const Matrix& rhs) const {
    // Create a matrix with the same height and width as the given matrix
    Matrix matrix = Matrix(rhs.height(), rhs.width(), 0);
    // Iterate through the given and current matrix
    for (int r = 0; r < rhs.height(); r++) {
        for (int c = 0; c < rhs.width(); c++) {
            // Subtract the value of the  current and given matricies and 
            // store the result in the new matrix
            matrix[r][c] = this->at(r).at(c) - rhs.at(r).at(c);
        }
    }
    // Return the new matrix
    return matrix;
}

// Operater to multiply the matrix by a given scalar value
Matrix Matrix::operator*(const Val val) const {
    // Create a matrix with the same height and width as the current matrix
    Matrix matrix = Matrix(this->height(), this->width(), 0);
    // Iterate through the current matrix
    for (int r = 0; r < this->height(); r++) {
        for (int c = 0; c < this->height(); c++) {
            // Multiply the current value by the scalar and store the result
            // in the new matrix
            matrix[r][c] = this->at(r).at(c) * val;
        }
    }
    // Return the new matrix
    return matrix;
}

// Performs the dot product on the two given matricies
Matrix Matrix::dot(const Matrix& rhs) const {
    // Create a matrix with the same height as the current matrix, 
    // and the same width and the given matrix
    Matrix matrix = Matrix(this->height(), rhs.width(), 0);
    // Iterate through the height of the current matrix
    for (int i = 0; i < this->height(); i++) {
        // Iterate through the width of the given matrix
        for (int j = 0; j < rhs.width(); j++) {
            // Iterate through the height of the given matrix
            for (int k = 0; k < rhs.height(); k++) {
                // Calculate the dot product on the current values of the given
                // and current matrix, and store the result in the new matrix
                matrix[i][j] = matrix.at(i).at(j) + 
                    (this->at(i).at(k) * rhs.at(k).at(j));
            }
        }
    }
    // Return the new matrix
    return matrix;
}

// Transposes the current matrix
Matrix Matrix::transpose() const {
    // Create a matrix with the height being the width of the current matrix,
    // and the width being the height of the current matrix
    Matrix matrix = Matrix(this->width(), this->height(), 0);
    // Iterate through the current matrix
    for (int r = 0; r < this->width(); r++) {
        for (int c = 0; c < this->height(); c++) {
            // Use the column value as the row, and the row as the column,
            // and store the returned value in the new matrix
            matrix[r][c] = this->at(c).at(r);
        }
    }
    // Return the new matrix
    return matrix;
}

#endif
