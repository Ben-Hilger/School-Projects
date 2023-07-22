package com.cse321.finalproject.logic.score;

public class ScoreFullHouse extends ScoreRule {

    /**
     * Contains the points that are possible to add in case that a full house is rolled.
     *
     * @param dice, int[] of dice rolls
     * @return 25, int value of points to add
     */
    @Override
    public int getPointsToAdd(int[] dice) {
        return 25;
    }

    /**
     * Determines if the dice roll is a full house.
     *
     * @param dice, int[] of dice roll
     * @return boolean, true if array is a full house, false otherwise
     */
    @Override
    public boolean isSatisfied(int[] dice) {
        // initialize the value of which is the 3ofAKind
        int three = findThreeOfAKind(dice);
        // ensure that there is a three of a kind within the roll
        if (three == -1) {
            return false;
        }
        // initialize the condition that the remaining two rolls are the same
        boolean hasTwo = hasTwo(dice, three);

        // return boolean that conditions of scoring the 3ofAKind is available & satisfied
        return hasTwo && timesUsed == 0;
    }

    /**
     * Analyzes dice roll array to determine the threeOfAKind number
     *
     * @param dice, int[] of the dice rolls
     * @return last, int number of the 3OfAKind, -1 if not found
     */
    private int findThreeOfAKind(int[] dice) {
        // initialize tracing variables to track how many of a roll value are present
        int count = 1, last = 0;

        // loop through the roll array checking the values to see if there is three of one common
        // variable using and updating tracing variables
        for(int i = 0;i < dice.length;i++){
            // checks if current dice array element is same as previous element
            if(dice[i] == last){
                count++;
            }else{
                // resets count to one
                count = 1;
                // sets last to the value before incrementing
                last = dice[i];
            }
            if(count == 3){
                // three of a kind is reached
                return last;
            }
        }
        return -1;
    }

    /**
     * Determines if the dice array has the remaining numbers to complete full house
     *
     * @param dice, int[] of the dice rolls
     * @param three, int number of the 3ofAKind
     * @return boolean, true if method has two matching thus is a full house, false otherwise
     */
    private boolean hasTwo(int[] dice, int three) {
        // initialize tracing variables to track how many of a roll value are present
        int count = 1, last = 0;

        // loop array to verify the last two rolls are the same, thus creating full house
        for(int i = 0;i < dice.length;i++){
            // checks that values are same and that it is not reading from the 3 common values
            if(dice[i] == last && dice[i] != three){
                count++;
            } else {
                // resets count to one
                count = 1;
                // sets last to the value before incrementing
                last = dice[i];
            }
            if(count == 2){
                // remaining values are the same, full house is true
                return true;
            }
        }
        return false;
    }
}
