class FestivalUnitTest {
    
    constructor() {
        this.runTests();
    }
  
    festivalGetNameTest(G1) {
        if (G1.getName().localeCompare("") == 0) return true;
        else return false;
      }
    festivalSetNameTest(G1) {
        var name = "a test festival";
        G1.setName(name);
        if (G1.getName().localeCompare(name) == 0) return true;
        else return false;
      }

    runTests() {
        var festivalTest = new Festival();
        try{
        if (this.festivalGetNameTest(festivalTest))
          //Testing the getName()
          console.log("Festival: getName() : Passed");
        else console.log("Festival: getName() : Failed");
        }
        catch{console.log("Festival: getName() : Failed : Likely Type Mismatch")}
        try{
        if (this.festivalSetNameTest(festivalTest))
          //Testing the setName()
          console.log("Festival: setName() : Passed");
        else console.log("Festival: setName() : Failed");
        }
        catch{console.log("Festival: setName() : Failed : Likely Type Mismatch")}

        try{
        var testMovie = new Movie();
        var firstTest = festivalTest.addMovie(testMovie);
        if(firstTest && festivalTest.removeMovie(testMovie))
            console.log("Festival: addMovie() and removeMovie() : Passed");
        else console.log("Festival: addMovie() and removeMovie() : Failed")
        }
        catch{console.log("Festival: addMovie() and removeMovie() : Failed : Likely Type Mismatch")}
      }
  }