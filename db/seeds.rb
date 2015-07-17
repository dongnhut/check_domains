# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#encoding: utf-8 
namespace :db do
  desc "Prints Country.all in a seeds.rb way."
  task :seed => :environment do
    ActiveRecord::Base.transaction do
      create_record
    end
  end
end

def self.create_record
  puts "Create user ....."
  User.delete_all
  10.times.each do |i|
    user = User.create!(
      email: "demo#{i}@gmail.com",
      username: "demo#{i}",
      password: "12345678"
    )
    # SyncFile.create_user_folder(user.username) if user.present? 
  end

end