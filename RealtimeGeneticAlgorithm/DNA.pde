class DNA {

      float genes[] = new float[8];

      DNA() {

            //food affinity
            genes[0] = random(-3, 3);
            //rotten food affinity
            genes[1] = random(-3, 3);

            //food sight
            genes[2] = random(1, 100);
            //rot sight
            genes[3] = random(1, 100);

            //size
            genes[4] = random(5, 15);
            //speed
            genes[5] = 1 / genes[4];

            //fish affinity
            genes[6] = random(-0.5, 0.5);
            //fish sight
            genes[7] = random(1, 100);
      }
}
