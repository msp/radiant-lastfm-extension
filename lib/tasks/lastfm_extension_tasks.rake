namespace :radiant do
  namespace :extensions do
    namespace :lastfm do
      
      desc "Runs the migration of the Lastfm extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          LastfmExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          LastfmExtension.migrator.migrate
        end
      end
      
      desc "Copies public assets of the Lastfm to the instance public/ directory."
      task :update => :environment do
        puts "This extension has no public assets.  Nothing done."
      end
    end
  end
end
