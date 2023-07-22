package com.cse321.finalproject.logic.score;

public class ScoreLargeStraight extends ScoreRule {
    /**
     * Contains the points that are possible to add in case that a large straight is rolled.
     *
     * @param dice, int[] of dice rolls
     * @return 40, int value of points to add
     */
    @Override
    public int getPointsToAdd(int[] dice) {
        return 40;
    }

    /**
     * Determines if dice roll is a large straight for the driver where there are 4 consecutive
     * numbers in ascending order
     *
     * @param dice, int[] of dice roll
     * @return boolean, true if contains 2,3,4,5 or 3,4,5,6, false otherwise
     */
    @Override
    public boolean isSatisfied(int[] dice) {
        return (dice[0] == 1 && dice[1] == 2 && dice[2] == 3
                && dice[3] == 4 && dice[4] == 5) ||
                (dice[0] == 2 && dice[1] == 3 && dice[2] == 4
                        && dice[3] == 5 && dice[4] == 6);
    }
}
