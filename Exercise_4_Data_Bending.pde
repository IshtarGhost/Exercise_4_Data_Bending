
PImage img; // Store image
PImage originalImg; // Store the original image


float slideRate = 0.1; // Initial slideRate
CustomSlider bendingSlider; // Declare the slider as a global variable
float tDel;



void setup() {
  size(900, 600); //add the actual dimensions of your image
  originalImg = loadImage("Buddha.jpg"); // Replace with the image's file path
  img = createImage(originalImg.width, originalImg.height, RGB); // Create a copy of the original image
  img.copy(originalImg, 0, 0, originalImg.width, originalImg.height, 0, 0, img.width, img.height);
  img.loadPixels();

  // ********  Create a slider to control the bending rate
  bendingSlider = new CustomSlider(width / 2 - 100, height - 50, 200, 20, 1, 30);
  bendingSlider.setValue(slideRate);
}  // End of Setup



void draw() {
  background(255);

  // Display the image using: image(img, 0, 0, width, height);

  dataBending(img, 1); // New Image Manipulation
  image(img, 0, 0, width, height); // old command = randomPixelManipulation(img);
  frameRate(8 + slideRate); // Rate of Image Display


  // *****  Upper Left Corner TEXT OVERLAY
  fill(0, 150); // Dark background for text
  rect(10, 10, 150, 60, 5); // Rectangle for background for text below (x, y, height, width)

  fill(255); // White text

  // use nf() if you need to output numbers instead of strings
  text("Use Slider to Bend Faster!", 20, 40); // text overlays data on top of image ("display this", x, y)

  text("Slider Value: " + nf(slideRate, 1, 3), 20, 60);
  //   text("NEXT LINE OF TEXT", 20, 80);

  // }


  // Update the slider's position based on the mouse
  bendingSlider.update();

  // ******* SLIDER DISPLAY ******

  bendingSlider.display();
  float newBendingRate = bendingSlider.getValue();

  // *** White rectangle above slider to show slider value
  // fill (255);
  // rect(width / 2 - 105, height - 76, 205, 23);

  // *** Display Slider value
  //  fill(0);
  //  text("Slider Value: ", width / 2 - 80, height - 60);
  //  *** To display Bending Rate: text(newBendingRate, width / 2 - 1, height - 60);

  //  *** Check if the Bending Rate has changed
  if (newBendingRate != slideRate) {

    // *** Apply data bending based on the slider value
    dataBending(img, newBendingRate);
    slideRate = newBendingRate; // Update the bending rate
  }
}



void mousePressed() {
  // Call the mousePressed method of the slider
  bendingSlider.mousePressed();
}

void mouseReleased() {
  // Call the mouseReleased method of the slider
  bendingSlider.mouseReleased();
}


// ************************

// CHOICE of Data Bending follows

// RGB Bending
void dataBending(PImage img, float rate) {

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
