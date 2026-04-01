PImage originalImg; // Store the original image
PImage img;




float corruptionRate = 0.1; // Initial corruption rate *** was set to 0.1 before
CustomSlider corruptionSlider; // Declare the slider as a global variable
float tDel;



void setup() {
  size(900, 600); //add the actual dimensions of your image
  originalImg = loadImage("Buddha.jpg"); // Replace with the image's file path
  img = createImage(originalImg.width, originalImg.height, RGB); // Create a copy of the original image
  img.copy(originalImg, 0, 0, originalImg.width, originalImg.height, 0, 0, img.width, img.height);
  img.loadPixels();

  // Create a slider to control the corruption rate
  corruptionSlider = new CustomSlider(width / 2 - 100, height - 50, 200, 20, 0, 1);
  corruptionSlider.setValue(corruptionRate);
}






void draw() {
  background(255);




  // Display the image
  //  image(img, 0, 0, width, height);

// ********  Problems area
  
// for (i = 0; i < tDel; i++) {

  tDel = abs(1000 * corruptionRate); // Use (int) command to change float to int i.e. without decimals *** WORKS

  
  dataCorruption(img, 1); // New Manip
  image(img, 0, 0, width, height); // old command = randomPixelManipulation(img);
  
frameRate(1 + corruptionRate * 30);
   
  
  // *****  Upper Left Corner TEXT OVERLAY
  fill(0, 150); // Dark background for text
  rect(10, 10, 250, 120, 5); 
  
  fill(255); // White text
  // nf() formats the numbers for output
    text("tDel: " + nf(tDel,1 ,3), 20, 40);  // text overlays data on top of fractal ("display this", x, y)
    text("corruptionRate: " + nf(corruptionRate, 1, 3), 20, 60);
 //   text("NEXT LINE OF TEXT", 20, 80);

  
  
  
//  }
  
  
  
  
  // Update the slider's position based on the mouse
  corruptionSlider.update();

  // ******* SLIDER DISPLAY *******
  corruptionSlider.display();

  // White rectangle above slider to show slider value
  fill (255);
  rect(width / 2 - 105, height - 76, 205, 23);

  // Display Slider value
  fill(0);
  text("Slider Value: ", width / 2 - 80, height - 60);
  float newCorruptionRate = corruptionSlider.getValue();
  
   float tDel = newCorruptionRate;
  text(newCorruptionRate, width / 2 - 1, height - 60);

  // Check if the corruption rate has changed
  if (newCorruptionRate != corruptionRate) {
    
    // Apply data corruption based on the slider value
    dataCorruption(img, newCorruptionRate);
    corruptionRate = newCorruptionRate; // Update the corruption rate
    
    

  }
}








void mousePressed() {
  // Call the mousePressed method of the slider
  corruptionSlider.mousePressed();
}

void mouseReleased() {
  // Call the mouseReleased method of the slider
  corruptionSlider.mouseReleased();
}


// ************************

// TYPE of DATA Corruption follows

// RGB Corruption
void dataCorruption(PImage img, float rate) {

  img.loadPixels();

  for (int i = 0; i < img.pixels.length; i++) {
    // Randomly alter the color values of each pixel
    float r = red(img.pixels[i]);
    float g = green(img.pixels[i]);
    float b = blue(img.pixels[i]);



    // Swap Red and Blue channels
    img.pixels[i] = color(b, g, r);
    
    // Ensure color values stay within the valid range (0-255)
    r = constrain(r, 0, 255);
    g = constrain(g, 0, 255);
    b = constrain(b, 0, 255);

//    img.pixels[i] = color(r, g, b);
  }

  img.updatePixels();
}





// ***** Slider ******


class CustomSlider {
  float x, y, w, h;
  float minValue, maxValue;
  float value;
  boolean dragging = false;

  CustomSlider(float x, float y, float w, float h, float minValue, float maxValue) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.minValue = minValue;
    this.maxValue = maxValue;
    this.value = minValue;
  }

  void display() {
    rectMode(CORNER);
    stroke(0);
    fill(150);
    rect(x, y, w, h);

    float sliderX = map(value, minValue, maxValue, x, x + w);
    fill(0);
    rect(sliderX - 5, y, 10, h);
  }

  boolean isMouseOver() {
    return mouseX >= x && mouseX <= x + w && mouseY >= y && mouseY <= y + h;
  }

  void update() {
    if (dragging) {
      float newValue = map(constrain(mouseX, x, x + w), x, x + w, minValue, maxValue);
      value = newValue;
    }
  }

  void mousePressed() {
    if (isMouseOver()) {
      dragging = true;
    }
  }

  void mouseReleased() {
    dragging = false;
  }

  void setValue(float newValue) {
    value = constrain(newValue, minValue, maxValue);
  }

  float getValue() {
    return value;
  }
}
