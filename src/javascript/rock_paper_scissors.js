/* globals prompt */

/**
 * This is a Class which you can call "new RockPaperScissorsGame()" and
 * it will return an instance of the game which you can run.
 *
 * @return {[type]}
 */
var RockPaperScissorsGame = function() {
  this.run = function() {
    var userChoice = prompt("Do you choose rock, paper or scissors?");
    var computerChoice = Math.random();
    if (computerChoice < 0.34) {
      computerChoice = "rock";
    } else if (computerChoice <= 0.67) {
      computerChoice = "paper";
    } else {
      computerChoice = "scissors";
    }
    console.log("Computer: " + computerChoice);
    this.compare(userChoice, computerChoice);
  };

  this.compare = function(choice1, choice2) {
    if (choice1 === choice2) {
      return "The result is a tie!";

    } else if (choice1 === "rock") {

      if (choice2 === "scissors") {
        return "rock wins";
      } else {
        return "paper wins";
      }

    } else if (choice1 === "paper") {

      if (choice2 === "rock") {
        return "paper wins";
      } else {
        return "scissors wins";
      }

    } else if (choice1 === "scissors") {

      if (choice2 === "rock") {
        return "rock wins";
      } else {
        return "scissors wins";
      }

    }
  };

  return this;
};