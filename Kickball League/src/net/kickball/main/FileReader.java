package net.kickball.main;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Scanner;

import net.kickball.main.players.Player;

public class FileReader {

	private Scanner scan;

	public FileReader(String fileName) {
		try {
			scan = new Scanner(new File(fileName));
		} catch(FileNotFoundException e) {
			e.printStackTrace();
		}
	}

	public FileReader(File file) {
		try {
			scan = new Scanner(file);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
	}

	public ArrayList<Player> getPlayersFromFile(){
		ArrayList<Player> players = new ArrayList<Player>();
		
		boolean continueRet = true;
		while(continueRet) {
			try {
				String name = scan.next().trim() + " " + scan.next().trim();
				String year = scan.next().trim();
				String in = scan.next().trim();

				players.add(new Player(name, year, in));
			}catch(Exception e) {
				System.out.println("Retrieved all players");
				continueRet = false;
			}
		}
		
		return players;
	}

}

