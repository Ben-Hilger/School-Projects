package com.cse321.finalproject;

import static org.junit.Assert.assertEquals;

import com.cse321.finalproject.logic.Yahtzee;
import com.cse321.finalproject.logic.score.ScoreChance;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

public class ScoreChanceTest{

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
     * Tests that addition is performed correctly when any dice are given to ScoreChance
     */
    @Test
    public void testGetPointsToAdd(){
        ScoreChance score = new ScoreChance();
        assertEquals(score.getPointsToAdd(dice), 25);

        dice = new int[] {1,1,1,1,1};
        assertEquals(score.getPointsToAdd(dice), 5);
    }

    /**
     * Tests that isSatisified correctly identifies that conditions to score are met for chance
     * (not used yet is the only relevant condition for ScoreChance)
     */
    @Test
    public void testIsSatisfied(){
        ScoreChance score = new ScoreChance();
        assertEquals(score.isSatisfied(dice), true);
    }
}
