namespace :db do
  task drop_create_seed: [:drop, :migrate, :seed] do
    puts "DB dropped"
    puts "DB created and migrated"
    puts "DB seeded"
  end
end
