package com.cse321.finalproject;

import static org.junit.Assert.assertEquals;

import com.cse321.finalproject.logic.Yahtzee;
import com.cse321.finalproject.logic.score.ScoreFive;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

public class ScoreFiveTest{

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
        ScoreFive score = new ScoreFive();
        assertEquals(score.getPointsToAdd(dice), 5);
    }

    /**
     * Tests if class correctly scores for multiple instances of the desired number
     */
    @Test
    public void testGetPointsToAddMany(){
        dice = new int[] {2,3,4,5,5};
        ScoreFive score = new ScoreFive();
        assertEquals(score.getPointsToAdd(dice), 10);

        dice = new int[] {3,4,5,5,5};
        assertEquals(score.getPointsToAdd(dice), 15);
    }

    /**
     * Tests if class correctly scores when no instances of the desired number is present
     */
    @Test
    public void testGetPointsToAddNone(){
        dice = new int[] {1,2,3,3,4};
        ScoreFive score = new ScoreFive();
        assertEquals(score.getPointsToAdd(dice), 0);
    }

    /**
     * Tests that isSatisfied correctly determines when the condtions to score are met
     */
    @Test
    public void testIsSatisfied(){
        ScoreFive score = new ScoreFive();
        assertEquals(score.isSatisfied(dice), true);
    }
}