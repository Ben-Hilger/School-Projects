class ActorUnitTest {
    
  constructor() {
      this.runTests();
  }

  actorGetNameTest(A1) {
      if (A1.getName().localeCompare("") == 0) return true;//return true if the name of a newly created actor is ""
      else return false;
    }
  actorSetNameTest(A1) {
      var name = "That guy";
      A1.setName(name);//change the name of the actor
      if (A1.getName().localeCompare(name) == 0) return true;//if the name did change return true
      else return false;//otherwise return false
    }
  actorGetDOBTest(A1) {
      if (A1.getDOB() == null) return true;//return true if the DOB of a new actor is null
      else return false;//otherwise return false
    }
  actorSetDOBTest(A1) {
      var testDate = new Date(2020, 3, 30);
      A1.setDOB(testDate);//change the DOB of the actor to something random
      if (
        A1.getDOB().getDate() == testDate.getDate() &&//if the date changed
        A1.getDOB().getMonth() == testDate.getMonth() &&//and the month changed
        A1.getDOB().getYear() == testDate.getYear()//and the year changed
      )
        return true;//reutrn true
      else return false;//otherwise return false
    }
  runTests() {
      var actorTest1 = new Actor();
      try{
      if (this.actorGetNameTest(actorTest1))//if the actor get name test returns true
        console.log("Actor: getName() : Passed");//print that the test passed
      else console.log("Actor: getName() : Failed");//otherwise it fails
      }
      catch{console.log("Actor: getName() : Failed : Likely Type Mismatch")}
      try{
      if (this.actorSetNameTest(actorTest1))//if the set name test returns true
        console.log("Actor: setName() : Passed");//print that it passed
      else console.log("Actor: setName() : Failed");//otherwise it fails
      }
      catch{console.log("Actor: setName() : Failed : Likely Type Mismatch")}
      try{
      if (this.actorGetDOBTest(actorTest1))
        console.log("Actor: getDOB() : Passed");
      else console.log("Actor: getDOB() : Failed");
      }
      catch{console.log("Actor: getDOB() : Failed : Likely Type Mismatch")}
      try{
      if (this.actorSetDOBTest(actorTest1))
        console.log("Actor: setDOB() : Passed");
      else console.log("Actor: setDOB() : Failed");
      }
      catch{console.log("Actor: setDOB() : Failed : Likely Type Mismatch")}
    }
}