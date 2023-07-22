package com.cse321.finalproject.logic.score;

public abstract class ScoreRule {

    public int timesUsed = 0;

    abstract public int getPointsToAdd(int[] dice);

    abstract public boolean isSatisfied(int[] dice);

    public void use() {
        timesUsed++;
    }

}
