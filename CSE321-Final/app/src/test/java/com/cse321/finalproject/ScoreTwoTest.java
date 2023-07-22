package com.cse321.finalproject;

import static org.junit.Assert.assertEquals;

import com.cse321.finalproject.logic.Yahtzee;
import com.cse321.finalproject.logic.score.ScoreTwo;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

public class ScoreTwoTest {

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
        ScoreTwo score = new ScoreTwo();
        assertEquals(score.getPointsToAdd(dice), 2);
    }

    /**
     * Tests if class correctly scores for multiple instances of the desired number
     */
    @Test
    public void testGetPointsToAddMany(){
        dice = new int[] {1,2,2,3,5};
        ScoreTwo score = new ScoreTwo();
        assertEquals(score.getPointsToAdd(dice), 4);

        dice = new int[] {2,2,2,3,5};
        assertEquals(score.getPointsToAdd(dice), 6);
    }

    /**
     * Tests if class correctly scores when no instances of the desired number is present
     */
    @Test
    public void testGetPointsToAddNone(){
        dice = new int[] {1,1,3,4,5};
        ScoreTwo score = new ScoreTwo();
        assertEquals(score.getPointsToAdd(dice), 0);
    }

    /**
     * Tests that isSatisfied correctly determines when the condtions to score are met
     */
    @Test
    public void testIsSatisfied(){
        ScoreTwo score = new ScoreTwo();
        assertEquals(score.isSatisfied(dice), true);
    }
}