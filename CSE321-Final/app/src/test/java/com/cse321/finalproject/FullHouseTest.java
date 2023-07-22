package com.cse321.finalproject;

import static org.junit.Assert.assertEquals;

import com.cse321.finalproject.logic.Yahtzee;
import com.cse321.finalproject.logic.score.ScoreFullHouse;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

public class FullHouseTest{

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
     * Tests that points are calculated correctly when any combination of 3
     * equal numbers are present and the remaining 2 are equal and different.
     */
    @Test
    public void testGetPointsToAdd(){
        dice = new int[] {1,1,1,6,6};
        ScoreFullHouse score = new ScoreFullHouse();
        assertEquals(score.getPointsToAdd(dice), 25);

        dice = new int[] {2,2,3,3,3};
        assertEquals(score.getPointsToAdd(dice), 25);
    }

    /**
     * Tests that points are calculated correctly when no combination of 3 &2
     * equal numbers are present.
     */
    @Test
    public void testGetPointsToAddNone(){
        ScoreFullHouse score = new ScoreFullHouse();
        assertEquals(score.getPointsToAdd(dice), 25);

        dice = new int[] {1,2,2,4,4};
        assertEquals(score.getPointsToAdd(dice), 25);
    }

    /**
     * Tests that isSatisfied correctly identifies that 3 equal numbers are present and
     * that the remaining to are equal to each other and different.
     */
    @Test
    public void testIsSatisfied(){
        dice = new int[] {2,2,2,3,3};
        ScoreFullHouse score = new ScoreFullHouse();
        assertEquals(score.isSatisfied(dice), true);
    }
}