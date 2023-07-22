package net.kickball.main.organize;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Random;

import net.kickball.main.players.Player;
import net.kickball.main.players.Team;

public class TeamManager {

	private OrganizeType orgT = OrganizeType.RANDOM;
	
	private final ArrayList<Player> players;
	
	private ArrayList<Team> teams = new ArrayList<Team>();
	
	public TeamManager(ArrayList<Player> players) {
		this.players = players;
	}
	
	public void createRandomTeams() {
		teams = new ArrayList<Team>();
		int maxSize = getBestTeamSize();
		ArrayList<Player> newList = new ArrayList<Player>(players);
		
		int numTeam = newList.size()/maxSize;
		
		char teamName = 'A';
		for(int i = 0; i < numTeam; i++) {
			
			ArrayList<Player> teamPlayers = new ArrayList<Player>();
			
			for(int i2 = 0; i2 < maxSize; i2++) {
				Random rand = new Random();
				int index = rand.nextInt(newList.size());
				teamPlayers.add(newList.remove(index));
			}
		
			teams.add(new Team("Team " + teamName, teamPlayers));
			int charint = (int)teamName+1;
			teamName = (char)(charint);		
		}
		
		System.out.println("Max Size: " + maxSize + '\n' + "Number of Teams: " + teams.size() + '\n' + "Players without teams: " + newList.size());
		
		int currentTeam = 0;
		int playersWithout = newList.size();
		for(int i = playersWithout-1; i >= 0; i--) {
			teams.get(currentTeam).addPlayer(newList.remove(i));
			if(currentTeam < maxSize-1) currentTeam++;
			else currentTeam = 0;
		}
		
		System.out.println("Players without a team: " + newList.size() + '\n');
	}
	
	public void organizeBySections() {
		teams = new ArrayList<Team>();
		final HashMap<String, ArrayList<Player>> sections = SectionOrganizer.organizeBySection(players);
		int maxSize = getBestTeamSize();
				
		HashMap<String, Character> currentList = new HashMap<String, Character>();
		for(int i = 0; i < sections.size(); i++) {
			currentList.put(sections.get(sections.keySet().toArray()[i]).get(0).getInsturment(), 'A');
		}
		
		for(int i = 0; i < sections.size(); i++) {
			if(sections.get(sections.keySet().toArray()[i]).size() > maxSize) {
				String currentSection = (String) sections.keySet().toArray()[i];
				ArrayList<Player> sectionP = sections.get(currentSection);
				
				String currentInsturment = sectionP.get(0).getInsturment();
				
				ArrayList<Player> halfSection = new ArrayList<Player>();
				ArrayList<Player> otherHalf = new ArrayList<Player>();
				
				for(int i2 = 0; i2 < sectionP.size()/2; i2++) {
					halfSection.add(sectionP.get(i2));
				}
				
				for(int i2 = 0; i2 < sectionP.size()-sectionP.size()/2; i2++) {
					otherHalf.add(sectionP.get(i2 + sectionP.size()/2));
				}
								
				String chartoAdd;
				if(currentList.get(currentInsturment).equals('A')) {
					chartoAdd = "A";
				}else{
					chartoAdd = sections.keySet().toArray()[i].toString().replace(currentInsturment, " ").trim();
				}
				int charint = (int)currentList.get(currentInsturment) + 1;
				
				sections.remove(sections.keySet().toArray()[i]);

				currentList.put(currentInsturment, (char)charint);
				
				sections.put(currentInsturment + " " + chartoAdd, halfSection);
				
				sections.put(currentInsturment + " " + currentList.get(currentInsturment), otherHalf);
			}
		}
		//System.out.println("Contents:");
		for(int i = 0; i < sections.size(); i++) {
			//System.out.println(sections.keySet().toArray()[i] + ":" + sections.get(sections.keySet().toArray()[i]).size());
		}
		
		String smallestSection = this.getSmallestSection(sections);
		
		//System.out.println("Smallest Section: " + smallestSection);
		
		ArrayList<Team> teams = new ArrayList<Team>();
		char teamChar = 'A';
		Team team = new Team("Team " + teamChar);
		
		int maxTeam = players.size()/maxSize;
		//System.out.println("Creating " + maxTeam + " Team" + (maxTeam != 1 ? "s" : ""));
		
		HashMap<String, ArrayList<Player>> mutableSections = new HashMap<String, ArrayList<Player>>(sections);
		while(teams.size() < maxTeam) {
			ArrayList<Player> newPlayers = new ArrayList<Player>();
			
			ArrayList<Player> section = mutableSections.remove(smallestSection);
			for(int i = 0; i < section.size(); i++) {
				newPlayers.add(section.get(i));
			}

			ArrayList<String> teamSections = new ArrayList<String>();
			teamSections.add(smallestSection);
			ArrayList<String> test = this.getNextTeam(mutableSections, newPlayers, teamSections, 0);
			//System.out.println("Contents: \n" + Arrays.toString(test.toArray()));
			team.addPlayers(newPlayers);
			teams.add(team);
			int charint = (int)teamChar + 1;
			teamChar = (char)charint;
			team = new Team("Team " + teamChar);
			
			smallestSection = this.getSmallestSection(mutableSections);
		}
		
		for(int i = 0; i < teams.size(); i++) {
			Team cteam = teams.get(i);
			System.out.println(cteam.getName() + ":");
			for(int i2 = 0; i2 < cteam.getPlayers().size(); i2++) {
				System.out.println(cteam.getPlayers().get(i2).getName());
			}
		}
	}
	
	public ArrayList<String> getNextTeam(HashMap<String, ArrayList<Player>> sections, ArrayList<Player> currentTeam, ArrayList<String> arr, int index){
		if(currentTeam.size() == 8 || index >= sections.size()) {
			return arr;
		}else if(currentTeam.size() + sections.get(sections.keySet().toArray()[index]).size() <= 8) {
			ArrayList<Player> section = sections.get(sections.keySet().toArray()[index]);
			System.out.println("Adding " + sections.keySet().toArray()[index] + " to " + Arrays.toString(arr.toArray()));
			arr.add((String) sections.keySet().toArray()[index]);
			for(int i = 0; i < section.size(); i++) {
				currentTeam.add(section.get(i));
			}
			
			return this.getNextTeam(sections, currentTeam, arr, index+1);
		}else {
			return this.getNextTeam(sections, currentTeam, arr, index+1);
		}
		
	}
	
	public String getSmallestSection(HashMap<String, ArrayList<Player>> section) {
		if(section.isEmpty()) return "";
		String small = (String) section.keySet().toArray()[0];
		for(int i = 0; i < section.size(); i++) {
			if(section.get(section.keySet().toArray()[i]).size() < section.get(small).size()) {
				small = (String) section.keySet().toArray()[i];
			}
		}
		
		return small;
	}
	
	public String getLargestSection(HashMap<String, ArrayList<Player>> sections) {
		String large = (String) sections.keySet().toArray()[0];
		for(int i = 0; i < sections.size(); i++) {
			if(sections.get(sections.keySet().toArray()[i]).size() < sections.get(large).size()) {
				large = (String) sections.keySet().toArray()[i];
			}
		}
		
		return large;
	}
	
	public int getBestTeamSize() {
		int best = 8;
		System.out.println(players.size());
		for(int i = 8; i <= 12; i++) {
			if(players.size() % i <= players.size() % best) {
				best = i;
			}
		}
		
		return best;
	}
	
	public ArrayList<Team> getTeams() {
		return teams;
	}
	
	public ArrayList<Player> getPlayers() {
		return players;
	}
}
