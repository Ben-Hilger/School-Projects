package com.cse321.finalproject.logic.score;

public class ScoreChance extends ScoreRule {

    /**
     * Calculates the summation of all 5 dice to score for Chance score possibility.
     *
     * @param dice, Dice array object that will contain sides of roll.
     * @return points, int summation of all 5 dice sides.
     */
    @Override
    public int getPointsToAdd(int[] dice) {
        int points = 0;
        // add all dice sides to find Chance points
        for (int d : dice) {
            points += d;
        }
        return points;
    }

    /**
     * Method to determine if the conditions for the score possibility are met.
     * Chance is always possible for scoring.
     *
     * @param dice, Dice array object containing sides of roll
     * @return Boolean, true always
     */
    @Override
    public boolean isSatisfied(int[] dice) {
        // always satisfied as Chance can be scored at any time by player choice
        return timesUsed == 0;
    }
}
