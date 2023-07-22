class DirectorUnitTest {
    
    constructor() {
        this.runTests();
    }
  
    directorGetNameTest(A1) {
        if (A1.getName().localeCompare("") == 0) return true;//checks if the name of a new director created is correct
        else return false;
      }
    directorSetNameTest(A1) {
        var name = "That guy";
        A1.setName(name);//attempt to change the name of the director
        if (A1.getName().localeCompare(name) == 0) return true;//if the name was changed successfully return true
        else return false;//otherwise return false
      }
    directorGetDOBTest(A1) {
        if (A1.getDOB() == null) return true;//if the DOB is null with a new director return true
        else return false;//otherwise false
      }
    directorSetDOBTest(A1) {
        var testDate = new Date(2020, 3, 30);
        A1.setDOB(testDate);//change the DOB to something else
        if (
          A1.getDOB().getDate() == testDate.getDate() && //if the date had been changed
          A1.getDOB().getMonth() == testDate.getMonth() && //and the month has been changed
          A1.getDOB().getYear() == testDate.getYear() //and the year has been changed
        )
          return true;//return true
        else return false;
      }
    runTests() {
        var directorTest1 = new Director();
        try{
        if (this.directorGetNameTest(directorTest1))//if the get name test returns true
          console.log("Director: getName() : Passed"); //print that it passed
        else console.log("Director: getName() : Failed");//otherwise it fails
        }
        catch{console.log("Director: getName() : Failed : Likely Type Mismatch")}
        try{
        if (this.directorSetNameTest(directorTest1))//if the set name test returns true
          console.log("Director: setName() : Passed");//print that the test passed
        else console.log("Director: setName() : Failed");//otherwise it fails
        }
        catch{console.log("Director: setName() : Failed : Likely Type Mismatch")}
        try{
        if (this.directorGetDOBTest(directorTest1))//if the get DOB test returns true
          console.log("Director: getDOB() : Passed");//print that the test passed
        else console.log("Director: getDOB() : Failed");//otherwise it fails
        }
        catch{console.log("Director: getDOB() : Failed : Likely Type Mismatch")}
        try{
        if (this.directorSetDOBTest(directorTest1))//if the get name test returns true
          console.log("Director: setDOB() : Passed");//print that the test passed
        else console.log("Director: setDOB() : Failed");//otherwise it fails
        }
        catch{console.log("Director: setDOB() : Failed : Likely Type Mismatch")}
      }
  }