package com.cse321.finalproject;

import static org.junit.Assert.assertEquals;

import com.cse321.finalproject.logic.Yahtzee;
import com.cse321.finalproject.logic.score.ScoreSix;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

public class ScoreSixTest {

    Yahtzee game;
    int[] dice;

    @Before
    public void setup() {
        game = new Yahtzee();
        dice = new int[] {1, 2, 3, 4, 6};
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
        ScoreSix score = new ScoreSix();
        assertEquals(score.getPointsToAdd(dice), 6);
    }

    /**
     * Tests if class correctly scores for multiple instances of the desired number
     */
    @Test
    public void testGetPointsToAddMany(){
        ScoreSix score = new ScoreSix();
        dice = new int[] {1,2,3,6,6};
        assertEquals(score.getPointsToAdd(dice), 12);

        dice = new int[] {1,4,6,6,6};
        assertEquals(score.getPointsToAdd(dice), 18);
    }

    /**
     * Tests if class correctly scores when no instances of the desired number is present
     */
    @Test
    public void testGetPointsToAddNone(){
        dice = new int[] {1,2,3,4,5};
        ScoreSix score = new ScoreSix();
        assertEquals(score.getPointsToAdd(dice), 0);
    }

    /**
     * Tests that isSatisfied correctly determines when the condtions to score are met
     */
    @Test
    public void testIsSatisfied(){
        ScoreSix score = new ScoreSix();
        assertEquals(score.isSatisfied(dice), true);
    }
}