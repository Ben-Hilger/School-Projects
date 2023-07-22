class MovieUnitTest {
    
    constructor() {
        this.runTests();
    }
    
    movieGetTitleTest(M1) {
        if (M1.getTitle().localeCompare("") == 0) return true;//If the title of the created movie is "" returns true
        else return false;//otherwise return false
      }
    movieSetTitleTest(M1) {
        var Title = "A test Movie";
        M1.setTitle(Title);//set the title to something else
        if (M1.getTitle().localeCompare(Title) == 0) return true;//return true if the title was successfully changed
        else return false;//otherwise return false
      }
    movieSetAndGetDirectorTest(M1){
        var testDirector = "test Director name";
        M1.setDirector(testDirector);//change the name of the director of the movie
        if(M1.getDirector().localeCompare(testDirector) == 0) return true;// if the director was changed successfully return true
        else return false;//otherwise return false
    }
    movieThumbUpAndDownGetRatingTest(M1){
        M1.thumbUp();//give the movie a thumbs up
        var Test1;
        if(M1.getRating() == 1.00) Test1 = true;//if the movie's rating is 1 test1 becomes true
        else Test1 = false;
        M1.thumbDown();//give the movie a thumbs down rating
        if(M1.getRating() == 0.5 && Test1) return true;//if the rating changes correctly and if test1 was correct return true
        else return false;//otherwise return false
    }
    movieSetAndGetActorTest(M1){
        var testActor = "A test Actor";
        M1.setActor(testActor);//change the main actor of the movie
        if (M1.getActor().localeCompare(testActor) == 0) return true;//if the actor changed successfully return true
        else return false;//otherwise return false
    }
    movieSetAndGetReleaseTest(M1){
        var testDate = new Date(2020, 3, 30);
      M1.setRelease(testDate);//set the movie's release date
      if (
        M1.getRelease().getDate() == testDate.getDate() &&//if the date changed successfully
        M1.getRelease().getMonth() == testDate.getMonth() &&//and the month changed successfully
        M1.getRelease().getYear() == testDate.getYear()//and the year changed successfully
      )
        return true;//return true
      else return false;//otherwise return false
    }
    movieHasSetGetPosterTest(M1){}
    
    
    runTests() {
        var MovieTest = new Movie();
        try{
        if (this.movieGetTitleTest(MovieTest))//if the movie get title tester returns true
          console.log("Movie: getTitle() : Passed");//print that the function test passed
        else console.log("Movie: getTitle() : Failed");
        }
        catch{console.log("Movie: getTitle() : Failed : Likely Type Mismatch")}
        try{
        if (this.movieSetTitleTest(MovieTest))//if the movie set title tester returns true
          console.log("Movie: setTitle() : Passed");//print that the function test passed
        else console.log("Movie: setTitle() : Failed");
        }
        catch{console.log("Movie: setTitle() : Failed : Likely Type Mismatch")}
        try{
        if (this.movieSetAndGetDirectorTest(MovieTest))//if the movie set and get director tester returns true
          console.log("Movie: setDirector() and getDirector() : Passed");//print that the function test passed
        else console.log("Movie: setDirector() and getDirector() : Failed");
        }
        catch{console.log("Movie: setDirector() and getDirector() : Failed : Likely Type Mismatch")}
        try{
        if (this.movieThumbUpAndDownGetRatingTest(MovieTest))//if the movie rating tester returns true
          console.log("Movie: thumbUp() and thumbDown() : Passed");//print that the function test passed
        else console.log("Movie: thumbUp() and thumbDown() : Failed");
        }
        catch{console.log("Movie: thumbUp() and thumbDown() : Failed : Likely Type Mismatch")}
        try{
        if (this.movieSetAndGetActorTest(MovieTest))//if the movie set and get actor tester returns true
          console.log("Movie: setActor() and getActor() : Passed");//print that the function test passed
        else console.log("Movie: setActor() and getActor() : Failed");
        }
        catch{console.log("Movie: setActor() and getActor() : Failed : Likely Type Mismatch")}
        try{
        if (this.movieSetAndGetReleaseTest(MovieTest))//if the movie set and get release date tester returns true
          console.log("Movie: setRelease() and getRelease() : Passed");//print that the function test passed
        else console.log("Movie: setRelease() and getRelease() : Failed");
        }
        catch{console.log("Movie: setRelease() and getRelease() : Failed : Likely Type Mismatch")}
        
        
      }
  }