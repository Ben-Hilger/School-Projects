package net.kickball.main.players;

import java.util.ArrayList;

public class Team {

	private ArrayList<Player> players = new ArrayList<Player>();
	
	private String name;
	
	public Team(String n) {
		name = n;
	}
	
	public Team(String n, ArrayList<Player> p) {
		name = n;
		players = p;
	}
	
	public Team(Team team) {
		name = team.getName();
		players = team.getPlayers();
	}
	
	public void addPlayer(Player p) {
		players.add(p);
	}
	
	public void addPlayers(ArrayList<Player> p) {
		for(int i = 0; i < p.size(); i++) {
			players.add(p.get(i));
		}
	}
	
	public String getName() {
		return name;
	}
	
	public ArrayList<Player> getPlayers(){
		return players;
	}
}
