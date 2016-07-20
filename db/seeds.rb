@bench_press = Exercise.create
@bench_press.name = "Bench Press"
@bench_press.save

@leg_press = Exercise.create(name: "Leg Press")