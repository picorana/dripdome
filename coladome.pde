// use carolina nobre's way of showing details in lineage for sankey?
// sheperd.js

import org.gicentre.handy.*;
 
HandyRenderer h;
ArrayList<Blob> blobs;
int numvertices = 20;
int starttime = millis();
 
void setup(){
  size(600,600);
  frameRate(30);
  h = new HandyRenderer(this);
  h.setSeed(1234);

  blobs = new ArrayList<Blob>();
  blobs.add(new Blob());
}
 
void draw(){
  background(235,215,182);
  
  for (Blob b: blobs){
    b.update();
    b.draw();
  }
  
  if (millis() - starttime > 4000){
    starttime = millis();
    blobs.add(new Blob());
    if (blobs.size() > 8){
      blobs.remove(blobs.get(0));
    }
  }
}

class Blob {
  float[] verticesx, verticesy;
  float strokeweight = random(0.5, 3);
  float roughness = random(3);
  float hachureangle = random(100);
  float fillgap = random(5, 10);
  
  Blob(){
    verticesx = new float[numvertices];
    verticesy = new float[numvertices];
    for (int i=0; i<numvertices; i++){
      verticesx[i] = width/2 + (float) Math.cos(i*TWO_PI/numvertices)*2;
      verticesy[i] = height/2 + (float) Math.sin(i*TWO_PI/numvertices)*2;
    }
  }
  
  void update(){
    for (int i=0; i< numvertices; i++){
      verticesx[i] += (float) Math.cos(i*TWO_PI/numvertices)*noise(i*0.1, blobs.indexOf(this));
      verticesy[i] += (float) Math.sin(i*TWO_PI/numvertices)*noise(i*0.1, blobs.indexOf(this));
      
      if (verticesx[i] > width/2 && blobs.indexOf(this) != 0 && verticesx[i] > blobs.get(blobs.indexOf(this) - 1).verticesx[i] - 10){
        verticesx[i] = blobs.get(blobs.indexOf(this) - 1).verticesx[i] - 10;
      } else if (verticesx[i] < width/2 && blobs.indexOf(this) != 0 && verticesx[i] < blobs.get(blobs.indexOf(this) - 1).verticesx[i] + 10){
        verticesx[i] = blobs.get(blobs.indexOf(this) - 1).verticesx[i] + 10;
      }
      
      if (verticesy[i] > height/2 && blobs.indexOf(this) != 0 && verticesy[i] > blobs.get(blobs.indexOf(this) - 1).verticesy[i] - 10){
        verticesy[i] = blobs.get(blobs.indexOf(this) - 1).verticesy[i] - 10;
      } else if (verticesy[i] < height/2 && blobs.indexOf(this) != 0 && verticesy[i] < blobs.get(blobs.indexOf(this) - 1).verticesy[i] + 10){
        verticesy[i] = blobs.get(blobs.indexOf(this) - 1).verticesy[i] + 10;
      }
    }
  }
  
  void draw(){
    //fill(10,10, 10);
    strokeWeight(strokeweight);
    h.setRoughness(roughness); 
    h.setHachureAngle(hachureangle);
    h.setFillGap(fillgap);
    h.beginShape();
    for (int i=0; i<numvertices; i++){
      h.vertex(verticesx[i], verticesy[i]);
    }
    h.endShape(CLOSE);
  }
}
