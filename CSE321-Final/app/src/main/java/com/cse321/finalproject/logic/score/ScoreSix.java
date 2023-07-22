package com.cse321.finalproject.logic.score;

public class ScoreSix extends ScoreRule {

    /**
     * Calculates the points to award for score six. This
     * should be equal to the sum of all of the 6s in the given
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
            // Check if dice = 6
            if (d == 6) {
                // Add to total points
                points += 6;
            }
        }
        // Return total points
        return points;
    }

    /**
     * Checks to ensure that this rule is satisfied. For this rule
     * to be satisfied the dice set must contain at least 1 six.
     *
     * @param dice The dice to examine if it contains a 6
     * @return True if the dice set contains a 6, false otherwise
     */
    @Override
    public boolean isSatisfied(int[] dice) {
        // Iterate through dice
        for (int d : dice) {
            // Check if dice = 6
            if (d == 6) {
                // Return true if it hasn't been used yet
                return timesUsed == 0;
            }
        }
        // Default false
        return false;
    }
}
