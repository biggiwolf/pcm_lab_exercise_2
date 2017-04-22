float contrastParameter = 2f;

int imageWidth = 208;
int imageHeight = 278;

PImage grayscale;
PImage image;
PImage threshold;
PImage contrast;

void setup(){
  //this size if histogram
  //size(768,200);
  
  //this size block if not histogram
  size(208, 278); 

  image = loadImage("PCMLab8.png");
  grayscale = arrayToImage(grayscale(image));
  threshold = threshold(image);
  contrast = contrast(image);
  //comment that out if not histogram
  //drawHistogram(image);
}

void draw(){
  //image(grayscale,0,0);
  //image(threshold,0,0);
  //image(image,0,0);
  image(contrast,0,0);
  
}

int[] grayscale(PImage image){
  
  PImage result = createImage(imageWidth, imageHeight, RGB);
  result.copy(image,0,0,imageWidth,imageHeight,0,0,imageWidth,imageHeight);
  int[] resultArray = new int[imageHeight*imageWidth];

  
  //grayscale
  for(int x=0; x<imageWidth; x++)
  {
   for(int y=0; y<imageHeight; y++)
   {
     int loc = x + y*imageWidth;
       color c = result.get(x,y);
       float red = red(c);
       float green = green(c);
       float blue = blue(c);
       int grey = (int)(0.3*red+0.59*green+0.11*blue);
       //color Color =color(grey,grey,grey);
       //grayscale.set(x,y,Color);
       //result.pixels[loc] = color(grey);
       //result.pixels[loc] = grey;
       resultArray[loc] = grey;
   }
  }

  return resultArray;
}

PImage arrayToImage(int[] grayscaleArray){
  PImage result = createImage(image.width, image.height, RGB);
  
  result.loadPixels();
  
  for(int i = 0; i < image.width*image.height; i++){
     result.pixels[i] = color(grayscaleArray[i]); 
  }
  result.updatePixels();
  
  return result;
}

PImage threshold(PImage image){
  //threshold
  PImage result = createImage(image.width, image.height, RGB);
  float thresholdvalue = 170;
  for(int x=0; x < image.width; x++)
  {
   for(int y=0; y < image.height; y++)
   {   
       color black = color(0);
       color white = color(255);
       
       image.loadPixels();
       int value = y*image.width+x; //get(x,y);
       if (brightness(image.pixels[value]) > thresholdvalue){
         result.pixels[value] = color(255); 
         //set(x,y, white);
        } else {
         result.pixels[value] = color(0);
          //set(x,y, black);
        }
        
        result.updatePixels();
        //to see grayscale disable following command
        //image(threshold,0,0);  
   }
  }
  return result;
}

/*
increases/decreases color differences
y = c * ( x - 127 ) + 127
increase: 
*if it is light, it becomes lighter
*if it is dark, it becomes darker
decrease:
*move all colors towards a neutral grey
*/
PImage contrast(PImage image){
  PImage result = createImage(imageWidth, imageHeight, RGB);
  result.copy(image,0,0,imageWidth,imageHeight,0,0,imageWidth,imageHeight);

  result.loadPixels();
  
  for(int x = 0; x < image.width; x++){
   for(int y = 0; y < image.height; y++){
       color c = result.get(x,y);
       float red = red(c);
       float green = green(c);
       float blue = blue(c);
       color newColor = color(contrastParameter*(red - 127) + 127, contrastParameter*(green - 127)+127, contrastParameter*(blue-127)+127);
       result.set(x,y,newColor);
   }
  }
  result.updatePixels();
  
  return result;
}

void drawHistogram(PImage image){
 
  int[] grayscale = grayscale(image);
  int[] histogram = new int[256];
  
  //fill every bin for the grayscale value with 0 to increase it later
  for(int i = 0; i < histogram.length; i++){
    histogram[i] = 0;
  }
  
  //increase the amount in the bin at the position of the corresponding grayvalue
  //for example one grayvalue = 50, then the bin at the position 50 will be increased by 0
  for(int i = 0; i < grayscale.length; i++){
    histogram[grayscale[i]]++;
  }
  
  // Find the largest value in the histogram
  int histMax = max(histogram);
  background(0);
  stroke(255);
  
  int linePositionX = 0;
  int controlSum = 0;
  
  for (int i = 0; i < 256; i++) {
    //depending on the window height and the maximum count of the histogram
    //histMax = 100% of the window height
    float lineHeight = (float)histogram[i]/(float)histMax*height;
    line(linePositionX, height, linePositionX, height-lineHeight);
    linePositionX += 3;
    controlSum += histogram[i];
  
  }

  //println("control sum = " + controlSum);
}