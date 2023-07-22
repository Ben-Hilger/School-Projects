package com.cse321.finalproject.logic.score;

public class ScoreThree extends ScoreRule {

    /**
     * Calculates the points to award for score three. This
     * should be equal to the sum of all of the 3s in the given
     * dice array
     *
     * @param dice, dice object array set with the roll
     * @return int, points possible
     */
    @Override
    public int getPointsToAdd(int[] dice) {
        // Store points to add
        int points = 0;
        // Iterate through the dice
        for (int d : dice) {
            // Check if the dice = 3
            if (d == 3) {
                // Add to total points
                points += 3;
            }
        }
        // Return total points
        return points;
    }

    /**
     * Checks to ensure that this rule is satisfied. For this rule
     * to be satisfied the dice set must contain at least 1 three.
     *
     * @param dice The dice to examine if it contains a 3
     * @return True if the dice set contains a 3, false otherwise
     */
    @Override
    public boolean isSatisfied(int[] dice) {
        // Iterate through the dice
        for (int d : dice) {
            // Check if the dice= 3
            if (d == 3) {
                // Return true if hasn't been used it
                return timesUsed == 0;
            }
        }
        // Default to false
        return false;
    }
}
