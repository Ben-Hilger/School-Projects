package com.cse321.finalproject;

import static org.junit.Assert.assertEquals;

import com.cse321.finalproject.logic.Yahtzee;
import com.cse321.finalproject.logic.score.ScoreFour;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

public class ScoreFourTest{

    Yahtzee game;
    int[] dice;

    @Before
    public void setup() {
        game = new Yahtzee();
        dice = new int[] {1, 2, 3, 4, 5};
    }

    @After
    public void breakdown() {
        dice = null;
        game = null;
    }

    /**
     * Tests if class correctly scores for one instance of the desired number
     */
    @Test
    public void testGetPointsToAddSingle(){
        ScoreFour score = new ScoreFour();
        assertEquals(score.getPointsToAdd(dice), 4);
    }

    /**
     * Tests if class correctly scores for multiple instances of the desired number
     */
    @Test
    public void testGetPointsToAddMany(){
        ScoreFour score = new ScoreFour();
        dice = new int[] {2,3,4,4,5};
        assertEquals(score.getPointsToAdd(dice), 8);

        dice = new int[] {1,2,4,4,4};
        assertEquals(score.getPointsToAdd(dice), 12);
    }

    /**
     * Tests if class correctly scores when no instances of the desired number is present
     */
    @Test
    public void testGetPointsToAddNone(){
        ScoreFour score = new ScoreFour();
        dice = new int[] {1,2,3,3,5};
        assertEquals(score.getPointsToAdd(dice), 0);
    }

    /**
     * Tests that isSatisfied correctly determines when the condtions to score are met
     */
    @Test
    public void testIsSatisfied(){
        ScoreFour score = new ScoreFour();
        assertEquals(score.isSatisfied(dice), true);
    }
}