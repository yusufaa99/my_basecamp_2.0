namespace :deploy do
    desc "Run database migrations on Render"
    task migrate: :environment do
      begin
        Rake::Task["db:create"].invoke
      rescue ActiveRecord::StatementInvalid => e
        puts "Skipping db:create – Database likely already exists."
      end
  
      Rake::Task["db:migrate"].invoke
      Rake::Task["db:seed"].invoke
    end
  end
  
  