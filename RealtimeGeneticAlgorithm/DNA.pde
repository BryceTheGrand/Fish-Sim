class DNA {

      float genes[] = new float[4];
      
      DNA() {
            
            //food affinity
            genes[0] = random(-3, 3);
            //rotten food affinity
            genes[1] = random(-3, 3);
            
            //food sight
            genes[2] = random(1, 100);
            //rot sight
            genes[3] = random(1, 100);
            
      }
}
