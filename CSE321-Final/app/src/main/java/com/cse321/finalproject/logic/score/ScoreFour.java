package com.cse321.finalproject.logic.score;

public class ScoreFour extends ScoreRule {

    /**
     * Calculates the points to award for score four. This
     * should be equal to the sum of all of the 4s in the given
     * dice array
     *
     * @param dice, dice object array set with the roll
     * @return int, points possible
     */
    @Override
    public int getPointsToAdd(int[] dice) {
        // Store points to add
        int points = 0;
        // Iterate through dice
        for (int d : dice) {
            // Check if dice = 4
            if (d == 4) {
                // Add to total points
                points += 4;
            }
        }
        // Return total points
        return points;
    }

    /**
     * Checks to ensure that this rule is satisfied. For this rule
     * to be satisfied the dice set must contain at least 1 four.
     *
     * @param dice The dice to examine if it contains a 4
     * @return True if the dice set contains a 4, false otherwise
     */
    @Override
    public boolean isSatisfied(int[] dice) {
        // Iterate through dice
        for (int d : dice) {
            // Check if dice = 4
            if (d == 4) {
                // Return true if hasn't been used yet
                return timesUsed == 0;
            }
        }
        // Default to false
        return false;
    }
}
