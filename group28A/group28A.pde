PImage image = loadImage("PCMLab8.png");
size(208,278);
image(image,0,0,width,height); // fills the screen with the picture

//grayscale
for(int x=0; x<width; x++)
{
 for(int y=0; y<height; y++)
 {
     color c = get(x,y);
     float red = red(c);
     float green = green(c);
     float blue = blue(c);
     int grey = (int)(0.3*red+0.59*green+0.11*blue);
     color Color =color(grey,grey,grey);
     set(x,y,Color);
 }
}

//threshold
PImage threshold;
threshold = createImage(image.width, image.height, RGB);
float thresholdvalue = 170;
for(int x=0; x < image.width; x++)
{
 for(int y=0; y < image.height; y++)
 {   
     color black = color(0);
     color white = color(255);
     
     loadPixels();
     int value = y*image.width+x; //get(x,y);
     if (brightness(image.pixels[value]) > thresholdvalue){
       threshold.pixels[value] = color(255); 
       //set(x,y, white);
      } else {
       threshold.pixels[value] = color(0);
        //set(x,y, black);
      }
      
      
      threshold.updatePixels();
      //to see grayscale disable following command
      image(threshold,0,0);
      
     
 }
}