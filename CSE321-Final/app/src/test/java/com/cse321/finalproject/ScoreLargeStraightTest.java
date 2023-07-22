package com.cse321.finalproject;

import static org.junit.Assert.assertEquals;

import com.cse321.finalproject.logic.Yahtzee;
import com.cse321.finalproject.logic.score.ScoreLargeStraight;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

public class ScoreLargeStraightTest{

    Yahtzee game;
    int[] dice;

    /**
     * Setup the JUnit tests
     */
    @Before
    public void setup() {
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
     * that only 40 is returned
     */
    @Test
    public void testGetPointsToAdd(){
        dice = new int[] {1,2,3,4,5};
        ScoreLargeStraight score = new ScoreLargeStraight();
        assertEquals(score.getPointsToAdd(dice), 40);

        dice = new int[] {2,3,4,5,6};
        assertEquals(score.getPointsToAdd(dice), 40);
    }

    /**
     * Tests the getPointsToAdd() function
     * for small straight function. Ensures
     * that only 40 is returned
     */
    @Test
    public void testGetPointsToAddNone(){
        ScoreLargeStraight score = new ScoreLargeStraight();
        dice = new int[] {1,3,4,5,6};
        assertEquals(score.getPointsToAdd(dice), 40);

        dice = new int[] {1,2,3,5,6};
        assertEquals(score.getPointsToAdd(dice), 40);
    }

    /**
     * Tests to ensure that the dice satisfies the rule.
     * This is presumed in all of the other tests.
     */
    @Test
    public void testIsSatisfied(){
        ScoreLargeStraight score = new ScoreLargeStraight();
        assertEquals(score.isSatisfied(dice), true);
    }
}
