class UserUnitTest {
    
    constructor() {
        this.runTests();
    }
  
    userGetNameTest(U1) {
        if (U1.getName().localeCompare("") == 0) return true;//if a newly created user has the right name returns true
        else return false;//otherwise return false
      }
    userSetNameTest(U1) {
        var name = "That guy";
        U1.setName(name);//changing the name of the user
        if (U1.getName().localeCompare(name) == 0) return true;//if the name was changed successfully return true
        else return false;//otherwise return false
      }
    userAddAndGetFavoriteMovieTest(U1){
        var testMovie = new Movie();
        var testName = "this movie is a test";
        testMovie.setTitle(testName);//changes the title of the movie to add to the list
        U1.addFavoriteMovie(testMovie);//adds the movie to the list of favorites for the user
        if(U1.getFavoriteMovies()[0].getTitle().localeCompare(testName) == 0) return true;//if the name of the movie in favorites matches the name of the test movie created returns true
        else return false;//otherwise returns false
    }
    userRemoveFavoriteMovieTest(U1){
        var testMovie = new Movie();
        var testName = "this movie is a test";
        testMovie.setTitle(testName);//adds a title to the movie to be added
        U1.addFavoriteMovie(testMovie);//adds the movie to the array of favorites
        U1.removeFavoriteMovieTest(testMovie);//removes the movie from the array of favorites
        if(U1.getFavoriteMovies()[0] == null) return true;//if the array of favorites is empty returns true because the moviie has been removed
        else return false;//otherwise returns false
    }
    userSetAndGetUsernameTest(U1){
        var Username = "That guy";
        U1.setUserName(Username);//changes the username of the created user
        if (U1.getUsername().localeCompare(Username) == 0) return true;//returns true if the name was changed successfully
        else return false;//otherwise returns false
    }
    userSetAndGetEmailTest(U1){
        var Email = "testemail@test.com";
        U1.setEmail(Email);//changes the email
        if (U1.getEmail().localeCompare(Email) == 0) return true;//returns true if the email was changed successfully
        else return false;//otherwise returns false
    }
    userIsAdminAndChangeStatusTest(U1){
        var firstTest;
        if(!U1.isAdmin()) firstTest = true;//if teh user is not an admin to start it sets the firsttest to true
        else firstTest = false;
        U1.changeStatus();
        if(U1.isAdmin() && firstTest) return true;//after being changed if the user is an admin and was not an admin before the function returns true
        else return false;//otherwise it returns false
    }
    userRequestToAddMovieTest(U1){}
    userAddMovieTest(U1){}

    
    
    runTests() {
        var userTest1 = new User();
        try{
        if (this.userGetNameTest(userTest1))//tests if the get name function is working
          console.log("User: getName() : Passed");//prints that it passes
        else console.log("user: getName() : Failed");
        }
        catch{console.log("user: getName() : Failed : Likely Type Mismatch")}
        try{
        if (this.userSetNameTest(userTest1))//if the user setname test returns true
          console.log("User: setName() : Passed");//prints that it passed
        else console.log("User: setName() : Failed");
        }
        catch{console.log("user: setName() : Failed : Likely Type Mismatch")}
        try{
        if (this.userAddAndGetFavoriteMovieTest(userTest1))//if the add and get favorite movies test returns true
          console.log("User: addFavoriteMovie() and getFavoriteMovies() : Passed");//print that the test passes
        else console.log("User: addFavoriteMovie() and getFavoriteMovies() : Failed");
        }
        catch{console.log("user: addFavoriteMovie() and getFavoriteMovies() : Failed : Likely Type Mismatch")}
        try{
        if (this.userRemoveFavoriteMovieTest(userTest1))//if the user remove favorite movies returns true
          console.log("User: removeFavoriteMovie() : Passed");//print that the test passes
        else console.log("user: removeFavoriteMovie() : Failed");
        }
        catch{console.log("user: removeFavoriteMovie() : Failed : Likely Type Mismatch")}
        try{
        if (this.userSetAndGetUsernameTest(userTest1))//if the user set and get username returns true
          console.log("User: setUsername() and getUsername() : Passed");//prints that the test passed
        else console.log("User: setUsername() and getUsername() : Failed");
        }
        catch{console.log("user: setUsername() and getUsername() : Failed : Likely Type Mismatch")}
        try{
        if (this.userSetAndGetEmailTest(userTest1))//if the set and get email test returns true
          console.log("User: setEmail() and getEmail() : Passed");//print that it passes
        else console.log("User: setEmail() and getEmail() : Failed");
        }
        catch{console.log("user: setEmail() and getEmail() : Failed : Likely Type Mismatch")}
        try{
        if (this.userIsAdminAndChangeStatusTest(userTest1))//if the isAdmin and changestatus tests return true
          console.log("User: isAdmin() and changeStatus() : Passed");//print that it passes
        else console.log("user: isAdmin() and changeStatus() : Failed");
        }
        catch{console.log("user: isAdmin() and changeStatus() : Failed : Likely Type Mismatch")}
      }
  }