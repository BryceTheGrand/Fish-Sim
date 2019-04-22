class Creature {

      PVector pos = new PVector();
      PVector vel = new PVector();
      DNA dna = new DNA();
      PVector desiredRot = new PVector(0, 0);
      PVector desiredFood = new PVector(0, 0);
      float health = 10;
      boolean dead = false;
      float starvation = 0.075;
      PVector desiredFish = new PVector(0, 0);


      Creature() {

            pos.set(random(10, width - 10), random(10, height - 10));
            vel.set(random(-5, 5), random(-5, 5));
      }

      Creature(float starve) {

            pos.set(random(10, width - 10), random(10, height - 10));
            vel.set(random(-5, 5), random(-5, 5));
            starvation = starve;
      }

      void update() {


            if (random(1) < fertility) {

                  Creature child = new Creature();
                  child.pos.set(random(0, width), random(0, height));

                  for (int i = 0; i < dna.genes.length; i++ ) {
                        child.dna.genes[i] = dna.genes[i];
                  }
                  child.mutate();
                  population.add(child);
            }

            health -= 13 * starvation / dna.genes[4];
            if (health < 0) {

                  dead = true;
            }

            vel.limit(25 * dna.genes[5]);
            pos.add(vel);

            push();
            translate(pos.x, pos.y);
            rotate(vel.heading() - HALF_PI);
            shape(creatureImg, 0, 0, 0.5 * dna.genes[4], 0.75 * dna.genes[4]);
            if (debug) {
                  // sight radii
                  noFill();
                  stroke(0, 255, 0);
                  circle(0, 0, 2*dna.genes[2]);
                  stroke(255, 0, 0);
                  circle(0, 0, 2*dna.genes[3]);

                  // food affinity
                  stroke(0, 255, 0);
                  line(1, 0, 1, 20*dna.genes[0]);
                  stroke(255, 0, 0);
                  line(-1, 0, -1, 20*dna.genes[1]);

                  // fish affinity
                  stroke(150, 0, 255);
                  circle(0, 0, 2 * dna.genes[7]);
                  line(-3, 0, -3, 20 * dna.genes[6]);
            }
            track();
            pop();
      }


      void track() {

            float minDistFood = 99999;
            float minDistRot = 99999;
            float d = 0;


            for (int i = food.size() - 1; i >= 0; i--) {

                  d = dist(food.get(i).pos.x, food.get(i).pos.y, this.pos.x, this.pos.y);

                  if (d < dna.genes[2]) {

                        if (d < minDistFood && food.get(i).fresh == true) {


                              minDistFood = d;
                              desiredFood.set(food.get(i).pos.x - this.pos.x, food.get(i).pos.y - this.pos.y);
                        }
                  }
                  if (d < dna.genes[3]) {
                        if (d < minDistRot && food.get(i).fresh == false) {


                              minDistRot = d;
                              desiredRot.set(food.get(i).pos.x - this.pos.x, food.get(i).pos.y - this.pos.y);
                        }
                  }
                  if (d < dna.genes[4] / 2) {
                        eat(food.get(i));
                        food.remove(i);
                  }
            }

            float minDistFish = 100000;

            for (int i = 0; i < population.size(); i++) {

                  d = dist(population.get(i).pos.x, population.get(i).pos.y, pos.x, pos.y);

                  if (d > 0.1)

                        if (d < dna.genes[7]) {

                              if (d < minDistFish) {

                                    d = minDistFish;
                                    desiredFish.set(population.get(i).pos.x - this.pos.x, population.get(i).pos.y - this.pos.y);
                              }
                        }
            }

            desiredFood.setMag(dna.genes[0]);
            desiredRot.setMag(dna.genes[1]);
            desiredFish.setMag(dna.genes[6] * 5);

            vel.add(desiredFood);
            vel.add(desiredRot);
            vel.add(desiredFish);


            if (pos.x > width) pos.x = 0;
            if (pos.x < 0) pos.x = width;
            if (pos.y > height) pos.y = 0;
            if (pos.y < 0) pos.y = height;
      }


      void eat(Food food) {

            if (food.fresh == false) {

                  health -= 2;
                  starvation += 0.01;
            }
            if (food.fresh == true && health < 10) {

                  health += 10;
            }
      }


      void mutate() {
            if (random(1) < mutationRate) dna.genes[0] += random(-0.35, 0.35);
            if (random(1) < mutationRate) dna.genes[1] += random(-0.35, 0.35);
            //if (dna.genes[2] < 125 && dna.genes[2] > 25)
            if (random(1) < mutationRate) {
                  dna.genes[2] += random(-25, 25);
                  if (dna.genes[2] > 200) dna.genes[2] = 200;
            }
            //if (dna.genes[3] < 125 && dna.genes[2] > 25)
            if (random(1) < mutationRate) {
                  dna.genes[3] += random(-25, 25);
                  if (dna.genes[3] > 200) dna.genes[3] = 200;
            }
            if (random(1) < mutationRate) {
                  dna.genes[4] += random(-1, 1);
                  if (dna.genes[4] < 5) dna.genes[4] = 5;
                  dna.genes[5] = 1 / dna.genes[4];
            }
            if (random(1) < mutationRate) dna.genes[6] += random(-0.35, 0.35);
            if (random(1) < mutationRate) {
                  dna.genes[7] += random(-25, 25);
                  if (dna.genes[7] > 200) dna.genes[7] = 200;
            }
      }
}
