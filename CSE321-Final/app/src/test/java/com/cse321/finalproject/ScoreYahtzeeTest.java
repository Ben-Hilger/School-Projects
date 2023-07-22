package com.cse321.finalproject;

import static org.junit.Assert.assertEquals;

import com.cse321.finalproject.logic.Yahtzee;
import com.cse321.finalproject.logic.score.ScoreYahtzee;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

public class ScoreYahtzeeTest{

    Yahtzee game;
    int[] dice;

    @Before
    public void setup() {
        game = new Yahtzee();
        dice = new int[] {5,5,5,5,5};
    }

    @After
    public void breakdown() {
        dice = null;
        game = null;
    }

    /**
     * Tests that correct score is returned when a Yahtzee(5 equal numbers) is present.
     */
    @Test
    public void testGetPointsToAdd(){
        ScoreYahtzee score = new ScoreYahtzee();
        assertEquals(score.getPointsToAdd(dice), 50);

        dice = new int[] {1,1,1,1,1};
        assertEquals(score.getPointsToAdd(dice), 50);
    }

    /**
     * checks that points are returned if satisified, regardless of the presence of a Yahtzee
     */
    @Test
    public void testGetPointsToAddNone(){
        ScoreYahtzee score = new ScoreYahtzee();
        dice = new int[] {2,2,2,2,4};
        assertEquals(score.getPointsToAdd(dice), 50);

        score.use();

        dice = new int[] {1,2,3,5,6};
        assertEquals(score.getPointsToAdd(dice), 100);
    }

    /**
     * Checks that isSatisified correctly identifies that 5 equal numbers are present
     */
    @Test
    public void testIsSatisfied(){
        ScoreYahtzee score = new ScoreYahtzee();
        assertEquals(score.isSatisfied(dice), true);
    }
}
