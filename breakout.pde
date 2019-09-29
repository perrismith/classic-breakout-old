float xStart, yStart; //Starting position of ball
float xSpeed = 8; // Set ball speed
float ySpeed = 8; // Set ball speed
int rows=8, col=9; // Set number of rows and columns
boolean[][] bricks = new boolean[rows][col];// Create bricks 2D array
int lives = 5;
int points = 0;
boolean mainmenu = true;


void setup() {
  size(800, 600); //Size of window
  noStroke();
  resetBall();
  for (int i = 0; i < rows; i++) { // Set all bricks in array to 'true' Source: processing.com/reference/Array.html
    for (int j = 0; j < col; j++) {
      bricks[i][j] = true;
    }
  }
}
void resetBall() {
  xStart = random (0, width);
  yStart = height/2; // Reset ball to random x position at center of screen
}

void resetBricks() {
  for (int i = 0; i < rows; i++) { // Set all bricks in array to 'true'
    for (int j = 0; j < col; j++) {
      bricks[i][j] = true;
    }
  }
}
void keyPressed() { //Reset Game
  if (key == 'r') {
    background(0);
    resetBricks();    
    lives = 5;
    points = 0;
    mainmenu = true;
  }
}

void startGame() { // Start ball
  float ballsize=10;
  ellipse(xStart + xSpeed, yStart + ySpeed, ballsize, ballsize); // Ball    
  xStart = xStart + xSpeed; // Changes the position of the ball
  yStart = yStart + ySpeed; // Changes the position of the ball
}




void draw() {
  background (100);

  float paddlewidth=150;// Set width of paddle
  float paddleheight=15;// Set height of paddle
  float paddlex=constrain(mouseX, 0, width-paddlewidth); //Constrains paddle to screen  
  float paddley=height-50; // Paddle located at bottom of screen


  fill(255);// Color of paddle
  rect(paddlex, paddley, paddlewidth, paddleheight); // Paddle

  if (mainmenu == true) {
    fill(255, 204, 0 );
    textSize(100);
    text("BREAKOUT", 150, 400);
    textSize(30);
    fill(255);
    text("Click mouse to begin", 245, 450);

    if (mouseButton == LEFT) {      
      mainmenu = false;
    }
  } else {
    if (lives != 0) {  
      startGame();
    }
  }

  if (lives == 0) { // End game when lives run out
    textSize(90);
    fill(255, 204, 0 );
    text("GAME OVER :(", 100, 400); 
    fill(255);
    textSize(30);
    text("Press R to reset game.", 245, 450);
  }

  if (xStart > width) {
    xSpeed = xSpeed  * -1; // Constrain ball to boundaries of screen
  } 

  if (xStart < 0) { 
    xSpeed = xSpeed * -1; // Constrain ball to boundaries of screen
  }

  if (yStart < 0) {
    ySpeed = ySpeed * -1; // Constrain ball to boundaries of the screen
  }

  if (yStart > height) { // Reset game when ball falls off of the screen
    resetBall();
    lives = lives - 1;
  }

  if (paddlex <= xStart && xStart <= paddlex + paddlewidth) {
    if (paddley <= yStart && yStart <= paddley + paddleheight) {
      ySpeed = ySpeed * -1; //'Bounces' ball off of paddle
    }
  }

  if (xStart <= (paddlex + paddlewidth) + 5 && xStart >= (paddlex + paddlewidth) -5) {
    if (paddley <= yStart && yStart <= paddley + paddleheight) {
      xSpeed = xSpeed * -1; //'Bounces' ball off of right side of paddle
    }
  }

  if (xStart <= paddlex + 5 && xStart >= paddlex - 5) {
    if (paddley <= yStart && yStart <= paddley + paddleheight) {
      xSpeed = xSpeed * -1;//'Bounces' ball of of left side of paddle
    }
  }

  //Draw Bricks
  int rectWidth=100, rectHeight=30, a = 0, b=0; //Set width and height of bricks. Set array variables to 0.  
  while (a < rows) { // When the 'row number' is less than total number of rows
    b = 0; // Set/reset columns to 0
    while (b < col) {    //When the 'column number' is less than number of columns               
      if ( bricks[a][b] == true) { //When array locations is true
        fill(b * 25, 100, 150); 
        stroke(255);
        strokeWeight(1);
        rect( a * rectWidth, b * rectHeight, rectWidth, rectHeight);   //Create a brick 

        if (a * rectWidth <= xStart && xStart <= (a * rectWidth + rectWidth)) { // Bounces ball off of top and bottom of brick
          if (b * rectHeight <= yStart && yStart <= b * rectHeight + rectHeight) {
            fill(255); 
            rect(a * rectWidth, b * rectHeight, rectWidth, rectHeight); // Light up Brick
            ySpeed = ySpeed * -1; //'Bounce' ball off of brick   
            xSpeed = xSpeed * -1;
            bricks[a][b] = false; // Remove brick at row and column number a,b
            points = points + 1;
          }
        }

        if (b * rectHeight <= yStart && yStart <= b * rectHeight + rectHeight) { // Bounces ball off of left side of brick
          if (a * rectWidth - 5 <=xStart && xStart <= a * rectWidth +5) {
            fill(255); 
            rect(a * rectWidth, b * rectHeight, rectWidth, rectHeight); // Light up Brick
            xSpeed = xSpeed * -1; //'Bounce' ball off of brick              
            bricks[a][b] = false; 
            points = points + 1; // Add one point per brick removed
          }
        }

        if (b * rectHeight <= yStart && yStart <= b * rectHeight + rectHeight) { // Bounces ball off of right side of brick
          if ( a * rectWidth - 5 <= xStart && xStart <= a * rectWidth + rectWidth + 5) {
            fill(255); //Color that brick will light up as
            rect(a * rectWidth, b * rectHeight, rectWidth, rectHeight); // Light up Brick
            xSpeed = xSpeed * -1; //'Bounce' ball off of brick              
            bricks[a][b] = false; // Remove brick at row and column number a,b
            points = points + 1; // Add one point per brick removed
          }
        }
      }        
      b = b + 1;
    }     
    a = a + 1;
  }

  textSize(32);
  fill(255);
  text("Lives=" + lives, 15, 525); //Display lives left
  text("Points=" + points, 610, 525); //Display number of points
}

//Sources: processing.org/reference, processing.org/examples, simplemovingball.pde, drawbricks.pde