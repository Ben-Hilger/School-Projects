package com.cse321.finalproject;

import static org.junit.Assert.assertEquals;

import com.cse321.finalproject.logic.Yahtzee;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

public class RandomDiceUnitTest {

    private Yahtzee game = null;

    @Before
    public void setup() {
        game = new Yahtzee();
    }

    @After
    public void breakdown() {
        game = null;
    }

    @Test
    public void testDiceRequest() {
        game.getRandomDice();
        assertEquals(game.getDice().length, 5);
    }
}
