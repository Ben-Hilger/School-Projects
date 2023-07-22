package com.cse321.finalproject;

import androidx.appcompat.app.AppCompatActivity;

import android.graphics.Color;
import android.graphics.Typeface;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import com.cse321.finalproject.logic.Yahtzee;
import com.cse321.finalproject.logic.score.ScoreRule;
import com.cse321.finalproject.logic.score.ScoreYahtzee;

import org.w3c.dom.Text;

import java.util.ArrayList;
import java.util.Arrays;

public class YahActivity extends AppCompatActivity {

    Button diceOne;
    Button diceTwo;
    Button diceThree;
    Button diceFour;
    Button diceFive;
    Button roll;

    TextView totalScore;
    TextView round;

    int[] textIds = new int[] {
            R.id.aces_score,
            R.id.twos_score,
            R.id.threes_score,
            R.id.fours_score,
            R.id.fives_score,
            R.id.sixes_score,
            R.id.three_kind_score,
            R.id.four_kind_score,
            R.id.full_house_score,
            R.id.sm_straight_score,
            R.id.lg_straight_score,
            R.id.yahtzee_score,
            R.id.chance_score
    };

    int[] addIds = new int[] {
            R.id.aces_score_button,
            R.id.twos_score_button,
            R.id.threes_score_button,
            R.id.fours_score_button,
            R.id.fives_score_button,
            R.id.sixes_score_button,
            R.id.three_kind_score_button,
            R.id.four_kind_score_button,
            R.id.full_house_score_button,
            R.id.sm_straight_score_button,
            R.id.lg_straight_score_button,
            R.id.yahtzee_score_button,
            R.id.chance_score_button
    };

    private Yahtzee game = new Yahtzee();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_yah);
        setupYahtzee();
    }

    private void setupYahtzee() {
        game = new Yahtzee();

        diceOne = findViewById(R.id.diceOne);
        diceTwo = findViewById(R.id.diceTwo);
        diceThree = findViewById(R.id.diceThree);
        diceFour = findViewById(R.id.diceFour);
        diceFive = findViewById(R.id.diceFive);
        roll = findViewById(R.id.rollButton);

        totalScore = findViewById(R.id.total_score_id);
        round = findViewById(R.id.round);

        setupUI();
    }

    private void setupUI() {
        // Get the dice
        diceOne.setBackgroundColor(Color.GREEN);
        diceOne.setTextColor(Color.BLACK);
        diceOne.setOnClickListener(view -> {
            game.lockedDice[0] = !game.lockedDice[0];
            if (game.lockedDice[0]) {
                diceOne.setBackgroundColor(Color.RED);
            } else {
                diceOne.setBackgroundColor(Color.GREEN);
            }
        });

        diceTwo.setBackgroundColor(Color.GREEN);
        diceTwo.setTextColor(Color.BLACK);
        diceTwo.setOnClickListener(view -> {
            game.lockedDice[1] = !game.lockedDice[1];
            if (game.lockedDice[1]) {
                diceTwo.setBackgroundColor(Color.RED);
            } else {
                diceTwo.setBackgroundColor(Color.GREEN);
            }
        });

        diceThree.setBackgroundColor(Color.GREEN);
        diceThree.setTextColor(Color.BLACK);
        diceThree.setOnClickListener(view -> {
            game.lockedDice[2] = !game.lockedDice[2];
            if (game.lockedDice[2]) {
                diceThree.setBackgroundColor(Color.RED);
            } else {
                diceThree.setBackgroundColor(Color.GREEN);
            }
        });

        diceFour.setBackgroundColor(Color.GREEN);
        diceFour.setTextColor(Color.BLACK);
        diceFour.setOnClickListener(view -> {
            game.lockedDice[3] = !game.lockedDice[3];
            if (game.lockedDice[3]) {
                diceFour.setBackgroundColor(Color.RED);
            } else {
                diceFour.setBackgroundColor(Color.GREEN);
            }
        });

        diceFive.setBackgroundColor(Color.GREEN);
        diceFive.setTextColor(Color.BLACK);
        diceFive.setOnClickListener(view -> {
            game.lockedDice[4] = !game.lockedDice[4];
            if (game.lockedDice[4]) {
                diceFive.setBackgroundColor(Color.RED);
            } else {
                diceFive.setBackgroundColor(Color.GREEN);
            }
        });

        roll.setText("Roll");
        roll.setOnClickListener(view -> {
            // Roll when clicked
            roll();
        });

        for(int i = 0; i < textIds.length; i++) {
            TextView txt = (findViewById(textIds[i]));
            txt.setText("0");
            txt.setTypeface(Typeface.DEFAULT);

        }

        for(int i = 0; i < addIds.length; i++) {
            int finalI = i;
            Button btn = (findViewById(addIds[i]));
            btn.setOnClickListener(view -> {
                add(finalI);
            });
            btn.setVisibility(View.INVISIBLE);
        }
    }

    private void restart() {
        game = new Yahtzee();
        roll.setText("Roll");
        roll.setOnClickListener(view -> {
            roll();
        });
        round.setText("Round: 1");
        totalScore.setText("Total Score: 0");
        ((TextView) findViewById(R.id.upper_bonus)).setText("0");
        ((TextView) findViewById(R.id.upper_bonus)).setTypeface(Typeface.DEFAULT);
        setupUI();
    }

    public void add(int pos) {
        // Check if the end of game
        // This will stop a bug that
        // allows someone to click twice
        if (game.isEndOfGame()) {
            endOfGame();
            return;
        }
        // Get the points to add, and set used
        int add = game.getRules()[pos].getPointsToAdd(game.getDice());
        ((TextView) findViewById(textIds[pos])).setTypeface(Typeface.DEFAULT_BOLD);
        game.getRules()[pos].use();
        // Add to score
        game.addToScore(add);
        // Check if the bonus was applied
        if (game.hasBonus()) {
            ((TextView) findViewById(R.id.upper_bonus)).setText("35");
            ((TextView) findViewById(R.id.upper_bonus)).setTypeface(Typeface.DEFAULT_BOLD);
        }
        ((TextView) findViewById(R.id.total_score_id)).setText("Total Score: " + game.getScore());
        game.resetDiceRound();
        game.goToNextGameRound();
        round.setText("Round: " + game.getGameRound());
        // Check if the end of game
        if (game.isEndOfGame()) {
            endOfGame();
            return;
        }
        // Unlock all of the dice
        game.lockedDice[0] = false;
        game.lockedDice[1] = false;
        game.lockedDice[2] = false;
        game.lockedDice[3] = false;
        game.lockedDice[4] = false;
        // Roll next round
        roll();
    }

    public void endOfGame() {
        roll.setText("End of game. Click to restart");
        roll.setOnClickListener(view -> {
            restart();
        });
    }

    public void roll() {
        if (game.isEndOfDiceRound()) {
            // Go to the next round
            game.goToNextGameRound();
            // Check if the send of game
            if (game.isEndOfGame()) {
                endOfGame();
                return;
            }
            round.setText("Round: " + game.getGameRound());
            game.resetDiceRound();
        }
        game.goToNextDiceRound();
        if (game.isEndOfDiceRound()) {
            roll.setText("End of Round. Click for next round");
        } else {
            roll.setText("Roll");
        }
        game.getRandomDice();
        int[] dice = game.getDice();
        // Update dice text
        diceOne.setText("" + dice[0]);
        diceTwo.setText("" + dice[1]);
        diceThree.setText("" + dice[2]);
        diceFour.setText("" + dice[3]);
        diceFive.setText("" + dice[4]);

        diceOne.setBackgroundColor(Color.RED);
        diceTwo.setBackgroundColor(Color.RED);
        diceThree.setBackgroundColor(Color.RED);
        diceFour.setBackgroundColor(Color.RED);
        diceFive.setBackgroundColor(Color.RED);

        showPotentialScores();
    }

    public void showPotentialScores() {
        ScoreRule[] rules = game.getRules();
        int[] dice = game.getDice();
        // Iterate through all of the rules
        for(int i = 0; i < rules.length; i++) {
            ScoreRule rule = rules[i];
            // Check if the rule is satisfied
            if(rule.isSatisfied(dice)) {
                ((Button) findViewById(addIds[i])).setVisibility(View.VISIBLE);
                ((TextView) findViewById(textIds[i])).setText("" + rule.getPointsToAdd(dice));
            } else {
                ((Button) findViewById(addIds[i])).setVisibility(View.INVISIBLE);
                if (rule instanceof ScoreYahtzee) {
                    ((TextView) findViewById(textIds[i])).setText("" +
                            ((rule.timesUsed == 1 ? 50 : 0) +
                                Math.max((rule.timesUsed-1 * 100), 0)));
                } else if (rule.timesUsed == 0) {
                    ((TextView) findViewById(textIds[i])).setText("0");
                }
            }
        }
    }
}