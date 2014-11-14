namespace :db do
  # TODO lock down to only doing in development. Cause, you know, wiping out a production database is, like, bad.
  task drop_create_seed: [:drop, :migrate, :seed] do
    puts "DB dropped"
    puts "DB created and migrated"
    puts "DB seeded"
  end
end
