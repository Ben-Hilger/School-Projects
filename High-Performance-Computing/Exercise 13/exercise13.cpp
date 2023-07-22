/* 
 * File:   exercise13.cpp
 * Author: hilgerbj
 *
 * Copyright (C) 2021 Ben Hilger
 */

#include <omp.h>
#include <iostream>
#include <algorithm>
#include <numeric>
#include <vector>

// Alias to streamline code below.
using IntVec = std::vector<unsigned int>;

// Forward declaration for popcount method defined further below
int popcount(unsigned int);

/** This is a data parallel implementation of countBitsEx12 method which is
 * the solution from Ex #12. This method improves performance in the
 * following manner:
 * 
 *     1. Critical section has been removed from the inner-most for-loop
 *        allowing multiple threads to effectively run in parallel.
 * 
 *     2. Consistent with a data parallel strategy, each thread counts 
 *        number of '1' bits on a sub-set of numbers in numList into a
 *        per-thread entry in bitcount[thrID] entry.
 * 
 *     3. In order to create necessary entries in bitcount vector, a
 *        critical section and a barrier solution has been used.
 *  
 */
long countBits(const IntVec& numList) {
    long sum = 0;
#pragma omp parallel for shared(numList) default(none) reduction(+: sum)
    for (size_t idx = 0; (idx < numList.size()); idx++) {
        sum += popcount(numList[idx]);
    }
    // Now return the sum of the values in bitcount as final answer
    return sum;
}

//-------------------------------------------------------------
//  DO  NOT  MODIFY  CODE  BELOW  THIS  LINE
//-------------------------------------------------------------

/** This is the solution for exercise #12. This method has a 
 * critical section 
 */
long countBitsEx12(const IntVec& numList) {
    long bitcount = 0;
#pragma omp parallel
    {  // fork
        const int iterPerThr = numList.size() / omp_get_num_threads();
        const int startIndex = omp_get_thread_num() * iterPerThr;
        int endIndex = startIndex + iterPerThr;
        if (omp_get_num_threads() == omp_get_thread_num() + 1) {
            // Handle case where numList.size() is not evenly divisible
            // by number of threads
            endIndex = numList.size();
        }
        for (int idx = startIndex; (idx < endIndex); idx++) {
#pragma omp critical
            bitcount += popcount(numList[idx]);
        }
    }  // join
    return bitcount;
}

/**
 * Helper method to count number of '1' bits in a given
 * unsigned integer.
 * 
 * @param value The value in which number of '1' bits should be
 * counted.
 * 
 * @return The number of '1' bits.
 */
int popcount(unsigned int value) {
    // Use a custom hardware instruction to enable microbenchmark to focus
    // on the false sharing aspect
    return __builtin_popcount(value);
    /*
    int bitcount = 0;  // number of '1' bits
    while (value > 0) {
        if (value % 2 == 1) {
            bitcount++;  // track 1 bits
        }
        value /= 2;  // remove last bit.
    }
    return bitcount;
    */
}

/*
 * The main method that is primarily used for testing the 
 * countBits method in this program. 
 */
int main() {
    IntVec numList(50000000);
    std::iota(numList.begin(), numList.end(), 0);
    int sum = 0;
    for (int i = 0; (i < 500); i++) {
        sum += countBits(numList);
    }
    std::cout << "Bit count: " << countBits(numList) << std::endl;
    return 0;
}

