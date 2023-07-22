package com.cse321.finalproject.logic.score;

public class ScoreYahtzee extends ScoreRule {

    /**
     * Calculates the points to award for yahtzee. (currently only 50 until bonuses accounted for)
     *
     * @param dice, dice object array set with the rolls
     * @return int, points possible
     */
    @Override
    public int getPointsToAdd(int[] dice) {
        if (timesUsed == 0) {
            return 50;
        } else {
            return 100;
        }
    }

    /**
     * Checks to ensure that every dice roll in the dice object array are the same
     *
     * @param dice, dice object array set with the rolls
     * @return Boolean, true if all sides are the same, false otherwise
     */
    @Override
    public boolean isSatisfied(int[] dice) {
        return dice[0] == dice[1] &&
                dice[0] == dice[2] &&
                dice[0] == dice[3] &&
                dice[0] == dice[4];
    }
}
