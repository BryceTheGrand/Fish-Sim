int startWealth = 200;
ArrayList<Food> food = new ArrayList<Food>();
ArrayList<Creature> population = new ArrayList<Creature>();
PShape creatureImg = new PShape();
int popSize = 50;
float foodRespawn = 0.1;
float poisonRespawn = 0.03;
float fertility = 0.003;
float mutationRate = 0.1;
boolean debug = false;
String stats = new String();
String info = new String();
boolean showHelp = false;
boolean hideStats = false;


void setup() {

      fullScreen(P3D); 
      background(0);

      creatureImg = createShape();
      creatureImg.beginShape();
      creatureImg.fill(255, 200);
      creatureImg.noStroke();
      creatureImg.vertex(-3, -5);
      creatureImg.vertex(3, -5);
      creatureImg.vertex(0, 5);
      creatureImg.endShape(CLOSE);

      for (int i = 0; i < startWealth; i++) {
            food.add(new Food(random(10, width - 10), random(10, height - 10), boolean(floor(random(0, 2)))));
            food.get(i).update();
      }

      for (int i = 0; i < popSize; i++) {

            population.add(new Creature());
      }

      frameRate(60);
}


void draw() {

      background(10);

      int rotCount = 0; 
      for (int i = 0; i < food.size(); i++) {
            food.get(i).update();
            if (!food.get(i).fresh) rotCount++;
      }

      if (random(1) <= foodRespawn) {

            food.add(new Food(random(10, width - 10), random(10, height - 10), true));
      }
      if (random(1) <= poisonRespawn && rotCount < 150) {

            food.add(new Food(random(10, width - 10), random(10, height - 10), false));
      }

      for (int i = population.size() - 1; i >= 0; i--) {

            population.get(i).update();
            if (population.get(i).dead) {
                  //if (random(1) < 0.75)
                  food.add(new Food(population.get(i).pos.x, population.get(i).pos.y, true));
                  population.remove(i);
            }
      }

      fill(255, 150);
      stats = "";
      stats += "Population: " + population.size() + "\nFood: " + (food.size() - rotCount) + "\nPoison: " + rotCount + "\nFood Respawn Rate: " + nf(foodRespawn, 1, 2) + "\nPoison Respawn Rate: " + nf(poisonRespawn, 1, 2) + "\nFertility: " + nf(fertility, 1, 3) + "\nMutation rate: " + mutationRate;
      info = "";
      info += "Press \"d\" to enable debug\nPress \"n\" to spawn 50 new random population\nPress \"i\"/\"o\" to increase/decrease food respawn rate\nPress \"j\"/\"k\" to increase/decrease poison respawn rate\nPress \"f\"/\"g\" to increase/decrease fertility\nPress \"r\"/\"t\" to increase/decrease mutation rate";

      if (!hideStats) {
            text(stats, 10, 10, 250, 250);
            if (showHelp)
                  text(info, 10, 120);
            else {
                  text("Press \"u\" for help", 10, 120);
            }
      }
}


void keyPressed() {

      if (key == 'd') {
            if (debug)
                  debug = false;
            else
                  debug = true;
      }

      if (key == 'n') {

            for (int i = 0; i < popSize; i++) {

                  population.add(new Creature());
            }
      }

      if (key == 'i')
            foodRespawn += 0.02;
      if (key == 'o')
            foodRespawn -= 0.02;

      if (key == 'j')
            poisonRespawn += 0.02;
      if (key == 'k')
            poisonRespawn -= 0.02;

      if (key == 'f')
            fertility += 0.001;
      if (key == 'g')
            fertility -= 0.001;

      if (key == 'r')
            mutationRate += 0.1;
      if (key == 't')
            mutationRate -= 0.1;

      if (key == 'u')
            if (showHelp)
                  showHelp = false;
            else showHelp = true;

      if (key == 'h')
            if (!hideStats)
                  hideStats = true;
            else hideStats = false;

      if (key == 'p') {
      }
}
