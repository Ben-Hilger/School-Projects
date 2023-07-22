package com.cse321.finalproject.logic.score;

public class ThreeOfAKind extends ScoreRule {
    private int sideCount;

    /**
     * Calculates points for 3 of a kind based on the sideCount variable
     * @param dice
     * @return points
     */
    @Override
    public int getPointsToAdd(int[] dice) {
       int points = 0;
        for(int d: dice){
            points+=d;
        }
        return points;
    }

    /**
     * int[] dice is presorted so positions are checked in bunches of 3 to identify an
     * occurence of 3 matching die.
     * Returns true if there are at least 3 of the same number, false otherwise.
     * @param dice
     * @return true
     */
    @Override
    public boolean isSatisfied(int[] dice) {
        int count = 1;
        int last = 0;
        for(int i = 0;i < dice.length;i++){
            if(dice[i] == last){
                count++;
            }else{
                count = 1;
                last = dice[i];
            }
            if(count == 3){
                return timesUsed == 0;
            }
        }
        return false;
    }

}