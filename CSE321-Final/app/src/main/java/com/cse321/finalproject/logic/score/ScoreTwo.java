package com.cse321.finalproject.logic.score;

public class ScoreTwo extends ScoreRule {

    /**
     * Calculates the points to award for score two. This
     * should be equal to the sum of all of the 1s in the given
     * dice array
     *
     * @param dice, dice object array set with the roll
     * @return int, points possible
     */
    @Override
    public int getPointsToAdd(int[] dice) {
        // Store the points to add
        int points = 0;
        // Iterate through the dice
        for (int d : dice) {
            // Check if the dice = 2
            if (d == 2) {
                // Add to total points
                points += 2;
            }
        }
        // Return total points
        return points;
    }

    /**
     * Checks to ensure that this rule is satisfied. For this rule
     * to be satisfied the dice set must contain at least 1 two.
     *
     * @param dice The dice to examine if it contains a 2
     * @return True if the dice set contains a 2, false otherwise
     */
    @Override
    public boolean isSatisfied(int[] dice) {
        // Iterate through the dice
        for (int d : dice) {
            // Check if the dice = 2
            if (d == 2) {
                // Return true if it hasn't been used yet
                return timesUsed == 0;
            }
        }
        // Default to false
        return false;
    }
}
