package net.kickball.main.organize;

import java.util.ArrayList;
import java.util.HashMap;

import net.kickball.main.players.Player;

public class SectionOrganizer {

	public static HashMap<String, ArrayList<Player>> organizeBySection(ArrayList<Player> players){
		HashMap<String, ArrayList<Player>> sections = new HashMap<String, ArrayList<Player>>();
		
		ArrayList<Player> playersCopy = new ArrayList<Player>(players);
		
		if(playersCopy.size() > 0) {
			while(playersCopy.size() > 0) {
				Player next = playersCopy.get(0);
				sections.put(next.getInsturment(), new ArrayList<Player>());
				
				sections.get(next.getInsturment()).add(playersCopy.remove(0));
				for(int i = playersCopy.size()-1; i >= 0; i--) {
					Player current = playersCopy.get(i);
					if(current.getInsturment().equals(next.getInsturment())) {
						sections.get(next.getInsturment()).add(playersCopy.remove(i));
					}
				}
				
			}
		}
		System.out.println(sections);
		return sections;
	}
	
}
