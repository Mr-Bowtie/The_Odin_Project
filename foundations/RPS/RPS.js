const player = document.querySelector('.playerTally');
const comp = document.querySelector('.computerTally');
const playerDisplay = document.querySelector("#playerChoice");
const compDisplay = document.querySelector("#computerChoice");
const tie = document.querySelector("#tie");
const endBanner = document.querySelector("#endBanner");


function random(number) {
    return Math.floor(Math.random()*number);
}

function computerPlay() {
    options = ['rock', 'paper', 'scissors'];
    return options[random(3)];
}

function displayRound(player, computer, isTie=false) {
    playerDisplay.style.backgroundImage = `url("RPS_icons/${player}.png")`;
    playerDisplay.style.backgroundRepeat = "no-repeat";
    playerDisplay.style.backgroundPosition = "center";
    playerDisplay.style.backgroundSize = "45px";

    compDisplay.style.backgroundImage = `url("RPS_icons/${computer}.png")`;
    compDisplay.style.backgroundRepeat = "no-repeat";
    compDisplay.style.backgroundPosition = "center";
    compDisplay.style.backgroundSize = "45px";
    (isTie) ? tie.textContent = "Tie!" : tie.textContent = "" ;

    if (playerScore === 5 || computerScore ===5) {
        document.removeEventListener('click', clicker);
        if (playerScore > computerScore) {
           alert("YOU WIN!");
        }
        else {
           alert("The Computer Wins!");
        }
        newRound();
    }
}

function newRound() {
    let choice = prompt("Would you like to play again? (yes/no)")
    if (choice === "yes" ) {
        playerScore = 0;
        computerScore = 0;
        document.addEventListener('click', clicker);
        scorekeeper();
    }
    else {
        alert("Thanks for playing! ")
    }
 
}

function clicker(e) {
    const btn = document.querySelector(`.btn[id="${e.target.id}"]`);
    if (!btn) return;
    let answer = btn.id.toString();
    playRound(answer, computerPlay());
}

function scorekeeper() {
    player.textContent = `${playerScore}`;
    comp.textContent = `${computerScore}`;
}

function playRound(playerSelection, computerSelection) {
    switch (playerSelection) {
        case 'rock':
            if (computerSelection === 'paper') {
                
                computerScore += 1;
                scorekeeper();
                displayRound(playerSelection, computerSelection,);
            }
            else if ( computerSelection === 'scissors') {
                playerScore += 1;
                scorekeeper();
                displayRound(playerSelection, computerSelection);
            }
            else {
                displayRound(playerSelection, computerSelection, true);
            }
            break;
            case 'paper':
                if (computerSelection === 'rock') {
                    playerScore += 1;
                    scorekeeper();
                    displayRound(playerSelection, computerSelection);
                }
                else if (computerSelection === 'scissors') {
                    computerScore += 1;
                    scorekeeper();
                    displayRound(playerSelection, computerSelection);
                }
                else {
                    displayRound(playerSelection, computerSelection, true);
                }
                break;
                case 'scissors':
                    if (computerSelection === 'paper') {
                        playerScore += 1;
                        scorekeeper();
                        displayRound(playerSelection, computerSelection);
                    }
                    else if ( computerSelection === 'rock') {
                        computerScore += 1;
                        scorekeeper();
                        displayRound(playerSelection, computerSelection);
                    }
                    else {
                        displayRound(playerSelection, computerSelection, true);
                    }
                    break;
                    default: {
                        return "Error, only enter rock, paper, or scissors please."
                    }
                    break;
                }
            }
            
            
let playerScore = 0;
let computerScore = 0; 


document.addEventListener('click', clicker);