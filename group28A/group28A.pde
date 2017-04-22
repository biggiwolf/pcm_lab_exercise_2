int imageHeight;
int imageWidth;

PImage grayscale;
PImage image;
PImage threshold;
PImage contrast;

void setup(){
   size(208, 278); 
  
  image = loadImage("PCMLab8.png");
  imageHeight = image.height;
  imageWidth = image.width;
  grayscale = arrayToImage(grayscale(image));
  image(grayscale,0,0);
  //threshold = threshold(image);
  contrast = contrast(image);
}

void draw(){
  //image(grayscale,0,0);
  //image(threshold,0,0);
  //image(image,0,0);
}

int[] grayscale(PImage image){
  
  PImage result = createImage(imageWidth, imageHeight, RGB);
  result.copy(image,0,0,imageWidth,imageHeight,0,0,imageWidth,imageHeight);
  int[] resultArray = new int[height*width];
  
  //image(grayscale,0,0);
  
  //size(imageWidth, imageHeight);
  //image(image,0,0,width,height); // fills the screen with the picture
  
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
  /*
  result.updatePixels();
  println("grayscale, 100,100 = " + result.get(100,100));
  println("results pixsel: " + result.pixels[100 + 100*100]);
  */
  return resultArray;
}

PImage arrayToImage(int[] grayscaleArray){
  PImage result = createImage(image.width, image.height, RGB);
  
  result.loadPixels();
  
  for(int i = 0; i < width*height-1; i++){
     result.pixels[i] = color(grayscaleArray[i]); 
  }
  result.updatePixels();
  //image(result,0,0);
  
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

PImage contrast(PImage image){
  //PImage result = grayscale(image);
  PImage result = createImage(imageWidth, imageHeight, RGB);
  //PImage grayscaleTemp = grayscale(image);
  result.copy(image,0,0,imageWidth,imageHeight,0,0,imageWidth,imageHeight);
  int[] resultArray = grayscale(image);
  
  //grayscale
  /*
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
       println(color(grey));
       resultArray[loc] = grey;
   }
  }
  //result.updatePixels();
  println("bla" + (resultArray[100]));
  //.get(100,100));
  
  //image(result,0,0);
  
  //result = grayscale(result);
  //result.loadPixels();
  
  //int minVal = min(result.pixels);
  //int maxVal = max(result.pixels);
  //result.loadPixels();
  /*
  image(result,0,0);
  int i = 0;
    for(int x=0; x < image.width; x++)
  {
   for(int y=0; y < image.height; y++)
   {   
       color c = result.get(x,y);
       float red = red(c);
       float green = green(c);
       float blue = blue(c);
       println("red = " + red + " , green = " + green + " , blue = " + blue);
    println(result.pixels[i++]);
   }
  }
  */
  /*
  for(int i = 0; i < image.width * image.height - 1; i++){
   println(thresholdTemp.pixels[i]); 
  }
  */
  
  //println(image.width);
  //println(image.height);
  //contrast
  //float minVal = 257;
  //float maxVal = -1;
  
  return result;
}