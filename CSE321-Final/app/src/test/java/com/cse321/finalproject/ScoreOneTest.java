package com.cse321.finalproject;

import static org.junit.Assert.assertEquals;

import com.cse321.finalproject.logic.Yahtzee;
import com.cse321.finalproject.logic.score.ScoreOne;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

public class ScoreOneTest{

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
        ScoreOne score = new ScoreOne();
        assertEquals(score.getPointsToAdd(dice), 1);
    }

    /**
     * Tests if class correctly scores for multiple instances of the desired number
     */
    @Test
    public void testGetPointsToAddMany(){
        ScoreOne score = new ScoreOne();
        dice = new int[] {1,1,2,3,5};
        assertEquals(score.getPointsToAdd(dice), 2);

        dice = new int[] {1,1,1,2,4};
        assertEquals(score.getPointsToAdd(dice), 3);
    }

    /**
     * Tests if class correctly scores when no instances of the desired number is present
     */
    @Test
    public void testGetPointsToAddNone(){
        dice = new int[] {2,2,3,4,5};
        ScoreOne score = new ScoreOne();
        assertEquals(score.getPointsToAdd(dice), 0);
    }

    /**
     * Tests that isSatisfied correctly determines when the condtions to score are met
     */
    @Test
    public void testIsSatisfied(){
        ScoreOne score = new ScoreOne();
        assertEquals(score.isSatisfied(dice), true);
    }
}