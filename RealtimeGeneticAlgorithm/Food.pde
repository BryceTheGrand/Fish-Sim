class Food {

      PVector pos = new PVector();
      boolean fresh = true;

      Food(float x, float y, boolean fresh) {

            pos.set(x, y);
            this.fresh = fresh;
      }

      void update() {

            noStroke();
            if (fresh) fill(0, 200, 0, 50);
            else fill(200, 0, 0, 50);
            circle(pos.x, pos.y, 4);
      }
}
