package com.cse321.finalproject.logic;

import com.cse321.finalproject.logic.score.FourOfAKind;
import com.cse321.finalproject.logic.score.ScoreChance;
import com.cse321.finalproject.logic.score.ScoreFullHouse;
import com.cse321.finalproject.logic.score.ScoreLargeStraight;
import com.cse321.finalproject.logic.score.ScoreRule;
import com.cse321.finalproject.logic.score.ScoreOne;
import com.cse321.finalproject.logic.score.ScoreSmallStraight;
import com.cse321.finalproject.logic.score.ScoreTwo;
import com.cse321.finalproject.logic.score.ScoreThree;
import com.cse321.finalproject.logic.score.ScoreFour;
import com.cse321.finalproject.logic.score.ScoreFive;
import com.cse321.finalproject.logic.score.ScoreSix;
import com.cse321.finalproject.logic.score.ScoreYahtzee;
import com.cse321.finalproject.logic.score.ThreeOfAKind;

import java.util.ArrayList;
import java.util.Arrays;

public class Yahtzee {

    private int[] dice;

    ScoreRule[] rules;

    private int score;

    public boolean[] lockedDice;

    private int gameRound = 0;

    private int diceRound = 3;

    private boolean hasBonus = false;

    public Yahtzee() {
        setup();
    }

    public void setup() {
        // Set score
        score = 0;
        // Setup dice
        dice = new int[5];
        // Setup locked dice
        lockedDice = new boolean[5];

        getRandomDice();
        // Set default rules
        rules = new ScoreRule[] {
                new ScoreOne(),
                new ScoreTwo(),
                new ScoreThree(),
                new ScoreFour(),
                new ScoreFive(),
                new ScoreSix(),
                new ThreeOfAKind(),
                new FourOfAKind(),
                new ScoreFullHouse(),
                new ScoreSmallStraight(),
                new ScoreLargeStraight(),
                new ScoreYahtzee(),
                new ScoreChance()
        };

    }

    public void getRandomDice() {
        // Iterate through all of the dice to roll
        for (int i = 0; i < dice.length; i++) {
            // Check if the dice is locked
            if(!lockedDice[i]) {
                dice[i] = ((int)(Math.random()*6)) + 1;
            }
        }
        // Sort the dice in ascending order
        Arrays.sort(dice);
        // Lock all of the dice
        lockedDice = new boolean[] {
                true, true, true, true, true
        };
    }

    public boolean isEndOfGame() {
        return gameRound >= 14;
    }

    public void goToNextGameRound() {
        gameRound++;
        // Reset to false
        lockedDice = new boolean[5];
    }

    public boolean isEndOfDiceRound() {
        return diceRound >= 3;
    }

    public void goToNextDiceRound() {
        diceRound++;
    }

    public void resetDiceRound() {
        diceRound = 0;
    }

    public int getGameRound() {
        return gameRound;
    }

    public int[] getDice() {
        return dice;
    }

    public ScoreRule[] getRules() { return rules; }

    public int getScore() {
        return score;
    }

    public void addToScore(int amt) {
        this.score += amt;
        if (score >= 63 && !hasBonus) {
            hasBonus = true;
            this.score += 35;
        }
    }

    public boolean hasBonus() {
        return hasBonus;
    }

}
