float contrastParameter = 2f;

PImage grayscale;
PImage image;
PImage threshold;
PImage contrast;

void setup(){
   size(208, 278); 
  
  image = loadImage("PCMLab8.png");
  grayscale = arrayToImage(grayscale(image));
  threshold = threshold(image);
  contrast = contrast(image);
}

void draw(){
  //image(grayscale,0,0);
  //image(threshold,0,0);
  //image(image,0,0);
  image(contrast,0,0);
}

int[] grayscale(PImage image){
  
  PImage result = createImage(width, height, RGB);
  result.copy(image,0,0,width,height,0,0,width,height);
  int[] resultArray = new int[height*width];

  
  //grayscale
  for(int x=0; x<width; x++)
  {
   for(int y=0; y<height; y++)
   {
     int loc = x + y*width;
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
  
  for(int i = 0; i < width*height-1; i++){
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
  PImage result = createImage(width, height, RGB);
  result.copy(image,0,0,width,height,0,0,width,height);

  result.loadPixels();
  
  for(int x = 0; x < width; x++){
   for(int y = 0; y < height; y++){
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