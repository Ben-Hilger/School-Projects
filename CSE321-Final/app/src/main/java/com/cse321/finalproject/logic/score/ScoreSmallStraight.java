package com.cse321.finalproject.logic.score;

public class ScoreSmallStraight extends ScoreRule {
    /**
     * Contains the points that are possible to add in case that a small straight is rolled.
     *
     * @param dice, int[] of dice rolls
     * @return 30, int value of points to add
     */
    @Override
    public int getPointsToAdd(int[] dice) {
        return 30;
    }

    /**
     * Determines if dice roll is a smallStraight for the driver
     *
     * @param dice, int[] of dice roll
     * @return boolean, true if dice roll contains a small straight, false otherwise
     */
    @Override
    public boolean isSatisfied(int[] dice) {
        // Check if the length of the dice is at least four
        if (dice.length < 4) {
            return false;
        }
        // Iterate through the dice array until there is less
        // than 4 dice left
        for (int i = 0; i+3 < dice.length; i++) {
            // Check if there's a small straight
            if (isSmallStraight(dice, i)) {
                // Return true to indicate the small straight
                return true;
            }
        }
        return false;
    }

    /**
     * Checks if the current sequence of 4 dice (starting from the
     * start position) is a small straight
     *
     * In order to be a small straight, it must be a sequence of
     * 4 consecutive numbers
     *
     * @param dice The dice to examine if it contains a small straight
     * @param start The starting position to examine the presence of a small straight
     * @return True if there is a small straight, false otherwise
     */
    private boolean isSmallStraight(int[] dice, int start) {
        // Check to ensure there are 4 values to check
        if (start+4 >= dice.length) {
            return false;
        }
        // 1, 2, 3, 4
        // 2, 3, 4, 5
        // 3, 4, 5, 6
        // Get the starting value
        int startingVal = dice[start];
        // Iterate through the next three
        for (int i = 1 ; i <= 3; i++) {
            // Check if the current dice isn't within the sequence
            if (dice[start+i] != startingVal+i) {
                return false;
            }
        }
        return timesUsed == 0;
    }
}
