package com.cse321.finalproject;

import static org.junit.Assert.assertEquals;

import com.cse321.finalproject.logic.Yahtzee;
import com.cse321.finalproject.logic.score.ScoreSmallStraight;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

public class ScoreSmallStraightTest{

    // Store the game and dice
    Yahtzee game;
    int[] dice;

    /**
     * Setup the JUnit tests
     */
    @Before
    public void setup() {
        // Setup the game and dice
        game = new Yahtzee();
        dice = new int[] {1, 2, 3, 4, 5};
    }

    /**
     * Breakdown the JUnit tests
     */
    @After
    public void breakdown() {
        dice = null;
        game = null;
    }

    /**
     * Tests the getPointsToAdd() function
     * for small straight function. Ensures
     * that only 30 is returned
     */
    @Test
    public void testGetPointsToAdd(){
        dice = new int[] {1,2,3,4,4};
        ScoreSmallStraight score = new ScoreSmallStraight();
        assertEquals(score.getPointsToAdd(dice), 30);

        dice = new int[] {2,3,4,5,5};
        assertEquals(score.getPointsToAdd(dice), 30);
    }

    /**
     * Tests the getPointsToAdd() function
     * for small straight function. Ensures
     * that only 30 is returned
     */
    @Test
    public void testGetPointsToAddNone(){
        ScoreSmallStraight score = new ScoreSmallStraight();
        dice = new int[] {1,3,4,5,6};
        assertEquals(score.getPointsToAdd(dice), 30);

        dice = new int[] {1,2,3,5,6};
        assertEquals(score.getPointsToAdd(dice), 30);
    }

    /**
     * Tests to ensure that the dice satisfies the rule.
     * This is presumed in all of the other tests.
     */
    @Test
    public void testIsSatisfied(){
        ScoreSmallStraight score = new ScoreSmallStraight();
        assertEquals(score.isSatisfied(dice), true);
    }
}