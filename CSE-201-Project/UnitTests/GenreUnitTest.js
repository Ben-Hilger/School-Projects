class GenreUnitTest {
    
    constructor() {
        this.runTests();
    }
    
    genreGetNameTest(G1) {//Checks if the name of a new created genre is what it's supposed to be
        if (G1.getName().localeCompare("") == 0) return true;
        else return false;
      }
    genreSetNameTest(G1) {//Changes the name of the genre to make sure that it can be changed
        var name = "a test genre";
        G1.setName(name);
        if (G1.getName().localeCompare(name) == 0) return true;
        else return false;
      }

    runTests() {
        var genreTest = new Genre();
        try{//try in case variables don't match
        if (this.genreGetNameTest(genreTest))//if the get name test passes
          console.log("Genre: getName() : Passed");//report that the function works
        else console.log("Genre: getName() : Failed");//otherwise report that it failed
        }
        catch{console.log("Genre: getName() : Failed : Likely Type Mismatch")}
        try{//try in case variables don't match
        if (this.genreSetNameTest(genreTest))//if the set name test passes
          console.log("Genre: setName() : Passed");//report that the set name function works
        else console.log("Genre: setName() : Failed");//otherwise it fails
        }
        catch{console.log("Genre: setName() : Failed : Likely Type Mismatch")}

        //testing the addMovie and removeMovie functions
        try{
        var testMovie = new Movie();
        var firstTest = genreTest.addMovie(testMovie);//tests to see if the addMovie method returns true
        if(firstTest && genreTest.removeMovie(testMovie))//if both addMovie and removeMovie return true
            console.log("Genre: addMovie() and removeMovie() : Passed");//log that the test passed
        else console.log("Genre: addMovie() and removeMovie() : Failed")//otherwise it fails
        }
        catch{console.log("Genre: addMovie() and removeMovie() : Failed : Likely Type Mismatch")}
      }
  }