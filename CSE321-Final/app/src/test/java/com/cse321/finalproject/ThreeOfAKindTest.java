package com.cse321.finalproject;

import static org.junit.Assert.assertEquals;

import com.cse321.finalproject.logic.Yahtzee;
import com.cse321.finalproject.logic.score.ThreeOfAKind;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

public class ThreeOfAKindTest{

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
     * Tests that points are calculated correctly when at least 3 equal numbers are correct
     */
    @Test
    public void testGetPointsToAdd(){
        dice = new int[] {2,2,2,3,4};
        ThreeOfAKind score = new ThreeOfAKind();
        assertEquals(score.getPointsToAdd(dice), 13);

        dice = new int[] {2,2,2,2,2};
        assertEquals(score.getPointsToAdd(dice), 10);
    }

    /**
     * Tests that score is calculated correctly when there no 3 equal numbers present
     */
    @Test
    public void testGetPointsToAddNone(){
        ThreeOfAKind score = new ThreeOfAKind();
        assertEquals(score.getPointsToAdd(dice), 15);

        dice = new int[] {2,2,3,4,5};
        assertEquals(score.getPointsToAdd(dice), 16);
    }

    /**
     * Tests that isSatisfied correctly determines when at least 3 equal numbers are present
     */
    @Test
    public void testIsSatisfied(){
        dice = new int[] {2,2,2,4,5};
        ThreeOfAKind score = new ThreeOfAKind();
        assertEquals(score.isSatisfied(dice), true);
    }
}