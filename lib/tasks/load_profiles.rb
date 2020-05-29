namespace :db do
  desc "Loads profiles in database"
  task :load_profiles => :environment do |t|
    profiles_list = YAML.load("#{Rails.root}/config/initializers/profiles.yml")['profiles']
    profiles.each do |profile|
      Profile.find_or_create_by_name(profile)
    end
  end
end
