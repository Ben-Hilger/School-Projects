package net.kickball.main.players;

public class Player {

	private String name;
	private String year;
	private String instrument;

	public Player(String n, String y, String in) {
		name = n;
		year = y;
		instrument = in;
	}

	public String getName() {
		return name;
	}

	public String getYear() {
		return year;
	}

	public String getInsturment() {
		return instrument;
	}
	
	public String toString() {
		return name + "[" + instrument + "][Class of " + year + "]";
	}
}
