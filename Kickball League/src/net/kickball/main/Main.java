package net.kickball.main;

import java.awt.Dimension;
import java.awt.Toolkit;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ArrayList;

import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;

import net.kickball.main.organize.TeamManager;
import net.kickball.main.players.Player;
import net.kickball.main.players.Team;

public class Main extends JFrame implements ActionListener{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Dimension screenSize = Toolkit.getDefaultToolkit().getScreenSize();
	private JComboBox<String> box;
	
	private TeamManager manager;
	
	private JPanel currentPanel;
	
	public Main(TeamManager man) {
		super("Olentangy Kickball");
		manager = man;
		this.setVisible(true);
		this.setSize(screenSize.width, screenSize.height);
		this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		this.setLocation(0, 0);
		this.setLayout(null);
		
		JPanel panel = new JPanel();
		panel.setSize(screenSize.width, screenSize.height);
		
		JLabel lbl = new JLabel("Organization Choices");
		lbl.setVisible(true);
		String[] choices = {"Random","By Section"};
			
		JComboBox<String> cb = new JComboBox<String>(choices);
		cb.setVisible(true);
		box = cb;
		
		JButton btn = new JButton("Create Teams");
		btn.addActionListener(this);
		btn.setActionCommand("Create");
		
		displayFile(panel, btn.getHeight());
		
		panel.add(lbl);
		panel.add(cb);
		panel.add(btn);
		currentPanel = panel;
		
		this.add(panel);
		this.validate();
	}
	
	public void displayFile(JPanel panel, int startingHeight) {
		JTextArea textArea = new JTextArea();
		JScrollPane scrollPane = new JScrollPane();
		textArea.setPreferredSize(new Dimension(panel.getWidth()/2, panel.getHeight()));
		scrollPane.setPreferredSize(new Dimension(450, 110));
		textArea.setLocation(0, 0);

		ArrayList<Player> players = manager.getPlayers();
		
		String text = "";
		for(int i = 0; i < players.size(); i++) {
			text += players.get(i).getName() + "[" + players.get(i).getInsturment() + "]" + "[Class of " + players.get(i).getYear() + "]\n";
		}
		
		textArea.add(scrollPane);
		scrollPane.setVisible(true);
		textArea.setVisible(true);
		textArea.setText(text);
		textArea.setEditable(false);
		panel.add(textArea);
		panel.validate();
		
	}
	
	public void createRandomTeams() {
		this.remove(currentPanel);
		
		manager.createRandomTeams();
		ArrayList<Team> teams = manager.getTeams();
		
		JPanel panel = new JPanel();
		panel.setSize(screenSize.width, screenSize.height);

		JLabel lbl = new JLabel("Amount of Teams: " + teams.size());
		lbl.setVisible(true);
		panel.add(lbl);
		
		JButton btn = new JButton("Return");
		btn.addActionListener(this);
		btn.setActionCommand("Return");
		panel.add(btn);
		
		int teamsThrough = 0;
		
		while(teamsThrough < teams.size()) {
			int amtTeamsToAdd = Math.min(teams.size()-teamsThrough, 3);
			for(int i = 0; i < amtTeamsToAdd; i++) {
				JPanel teamPanel = new JPanel();
				JTextArea textArea = new JTextArea();
				textArea.setPreferredSize(new Dimension(panel.getWidth()/3, panel.getHeight()/3));
				teamPanel.setSize(screenSize.width/3, screenSize.height);

				Team teamToAdd = teams.get(i+teamsThrough);
				System.out.println(i);

				String text = "";
				for(int i2 = 0; i2 < teamToAdd.getPlayers().size(); i2++) {
					ArrayList<Player> players = teamToAdd.getPlayers();
					text += players.get(i2).getName() + "[" + players.get(i2).getInsturment() + "]" + "[Class of " + players.get(i2).getYear() + "]\n";
				}
				
				textArea.setText(text);
				teamPanel.add(textArea);
				panel.add(teamPanel);
				
			}
			teamsThrough += 3;
		}
		
		this.setContentPane(panel);
		currentPanel = panel;
		this.validate();
		
	}
	
	public void returnToMainScreen() {
		this.remove(currentPanel);
		
		JPanel panel = new JPanel();
		panel.setSize(screenSize.width, screenSize.height);
		
		JLabel lbl = new JLabel("Organization Choices");
		lbl.setVisible(true);
		String[] choices = {"Random","By Section"};
			
		JComboBox<String> cb = new JComboBox<String>(choices);
		cb.setVisible(true);
		box = cb;
		
		JButton btn = new JButton("Create Teams");
		btn.addActionListener(this);
		btn.setActionCommand("Create");
		
		displayFile(panel, btn.getHeight());
		
		panel.add(lbl);
		panel.add(cb);
		panel.add(btn);
		currentPanel = panel;
		
		this.setContentPane(panel);
		this.validate();
	}
	
	@Override
	public void actionPerformed(ActionEvent e) {
		if(e.getActionCommand().equals("Create")) {
			String selected = String.valueOf(box.getSelectedItem());
			if(selected.equals("Random")) {
				System.out.println(selected);
				this.createRandomTeams();
			}
		}else if(e.getActionCommand().equals("Return")) {
			this.returnToMainScreen();
		}
		
		
		
	}
	
	public static void main(String[] args) {
		FileReader reader = new FileReader("Players.txt");
		TeamManager manager = new TeamManager(reader.getPlayersFromFile());
		new Main(manager);
	}

}
