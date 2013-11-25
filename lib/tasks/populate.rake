# coding: utf-8

require 'csv'
require 'faker'

namespace :csv do
  desc "Import permissions"
  task :import_permissions => :environment do
    Permission.destroy_all
    Permission.reset_pk_sequence
    csv_file_path = 'db/permissions.csv'
    CSV.foreach(csv_file_path) do |row|
      row = Permission.create!({
        :id => row[0],
        :title => row[1],
        :description => row[2],        
      })
      puts "Permission imported!"
    end
  end
end

namespace :csv do
  desc "Import car brans"
  task :import_car_brands => :environment do
    CarBrand.destroy_all
    CarBrand.reset_pk_sequence
    csv_file_path = 'db/car_brands.csv'
    CSV.foreach(csv_file_path) do |row|
      row = CarBrand.create!({
        :title => row[0]      
      })
      puts "Car brands imported!"
    end
  end
end

namespace :csv do
  desc "Import user document types"
  task :import_user_document_types => :environment do
    UserDocumentType.destroy_all
    UserDocumentType.reset_pk_sequence
    csv_file_path = 'db/user_document_types.csv'
    CSV.foreach(csv_file_path) do |row|
      row = UserDocumentType.create!({
        :id => row[0],
        :title => row[1]   
      })
      puts "User Document Type!"
    end
  end
end

namespace :users do
  task :create => :environment do
    User.destroy_all
    User.populate 15 do |user|
      user.username = Faker::Internet.user_name
      user.first_name = Faker::Name.first_name
      user.last_name = Faker::Name.last_name
      user.middle_name = Faker::Name.last_name
      user.phone = '88123361' + rand(100..999).to_s
      user.position = Faker::Lorem.words(1)
      user.division = Faker::Lorem.words(1)
      user.info = Populator.sentences(1..3)
      user.dob = rand(20.years).ago
      user.permit = rand(768..999)
      user.work_status = ['at_work', 'ooo'].sample
      user.organization_id = Organization.all.sample
      user.email = Faker::Internet.free_email
      user.encrypted_password = User.new(:password => "password").encrypted_password
    end
    User.all.each { |user| user.avatar = File.open(Dir.glob(File.join(Rails.root, 'avatars', '*')).sample); user.save! }
    puts "Users create!"
  end
end

namespace :users do
  task :add_permission => :environment do
    User.create!(:username => 'admin', :first_name => 'admin', :last_name => 'admin', :middle_name => 'admin', :position => 'admin', :organization_id => '3', :email => 'admin@example.com', :password => 'admin', :password_confirmation => 'admin', :id_type => 'Паспорт', :id_sn => '400812342', :id_issue_date => Date.today, :id_issuer => 'ОТП 29')
    user = User.find_by_username('admin')
    user.sys_user = true
    permissions = Permission.all
    user.permissions << permissions
    user.save!
    puts "Access Granted"
  end
end

namespace :organizations do
  task :add_organizations => :environment do
    Organization.destroy_all
    Organization.populate 4 do |organization|
      organization.title = Faker::Lorem.words(1)
      organization.address = Faker::Lorem.words(4)
      organization.phone = '88123361' + rand(100..999).to_s
      organization.mail = Faker::Internet.free_email
      organization.director_id = User.all.sample
    end
     Organization.all.each { |o| o.logo = File.open(Dir.glob(File.join(Rails.root, 'avatars', '*')).sample); o.save! }
  end
end

namespace :documents do
  task :create => :environment do
    Document.destroy_all
    Document.populate 40 do |d|
      organization = Organization.all.sample
      sender_organization = Organization.all.sample
      d.organization_id = organization.id
      d.sender_organization_id = sender_organization.id
      d.text = Populator.sentences(30..50)
      d.title = Faker::Lorem.words(3)
      d.user_id = User.find_by_organization_id(sender_organization.id)
      d.approver_id = User.all.sample
    end
  end
end





