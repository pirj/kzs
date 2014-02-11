# coding: utf-8
require 'csv'
require 'faker'

namespace :csv do
  desc "Import permissions"
  task :import_permissions => :environment do
    Permission.destroy_all
    Permission.reset_pk_sequence
    csv_file_path = 'db/csv/permissions.csv'
    CSV.foreach(csv_file_path) do |row|
      row = Permission.create!({
        :id => row[0],
        :title => row[1],
        :description => row[2],        
      })  
    end
    puts "Permissions imported!"
  end
end

namespace :csv do
  desc "Import Organizations"
  task :organizations => :environment do
    Organization.destroy_all
    Organization.reset_pk_sequence
    csv_file_path = 'db/csv/organizations.csv'
    CSV.foreach(csv_file_path) do |row|
      row = Organization.create({
        :id => row[0],
        :title => row[1],   
        :parent_id => row[2], 
        :director_id => row[3],  
        :short_title => row[4],  
        :admin_id => row[5],  
        :type_of_ownership => row[6]          
      })
    end
    puts "Organizations imported"    
  end
end

namespace :csv do
  desc "Import permissions"
  task :users => :environment do
    
    User.destroy_all
    User.reset_pk_sequence
    csv_file_path = 'db/csv/users.csv'
    CSV.foreach(csv_file_path) do |row|
      row = User.create({
        :id => row[0],
        :organization_id => row[1],   
        :position => row[2], 
        :first_name => row[3],  
        :middle_name => row[4],  
        :last_name => row[5],  
        :username => row[6],       
        :password => row[7],    
        :password_confirmation => row[8],    
        :sys_user => row[9]  
      })
      
    end
      puts "Users imported"
    
    permissions = Permission.all
    User.all.each do |user|
      user.permissions << permissions
      user.save!
    end
    puts "Permissions addded"
  
  end
end



namespace :csv do
  desc "Import car brands"
  task :import_car_brands => :environment do
    CarBrandType.destroy_all
    CarBrandType.reset_pk_sequence
    CarBrandType.create(:title => 'Легковые автомобили')
    CarBrandType.create(:title => 'Грузовики')
    CarBrandType.create(:title => 'Спецтехника')

    CarBrand.destroy_all
    CarBrand.reset_pk_sequence
    csv_file_path = 'db/csv/car_brands.csv'
    CSV.foreach(csv_file_path) do |row|
      row = CarBrand.create!({
        :title => row[0],   
        :car_brand_type_id => row[1],
      })
    end
    puts "Car brands imported!"
  end
end

namespace :csv do
  desc "Import user document types"
  task :import_user_document_types => :environment do
    UserDocumentType.destroy_all
    UserDocumentType.reset_pk_sequence
    csv_file_path = 'db/csv/user_document_types.csv'
    CSV.foreach(csv_file_path) do |row|
      row = UserDocumentType.create!({
        :id => row[0],
        :title => row[1]   
      })
      puts "User Document Types created"
    end
  end
end

namespace :documents do
  desc 'Create Mails, Orders and Reports. IMPORTANT: run after creating Users and Organizations.'
  task :create => :environment do
    Document.destroy_all
    Document.reset_pk_sequence

    Documents::Mail.delete_all
    Documents::Mail.reset_pk_sequence

    organizations_count = Organization.count
    users_count         = User.count

    3.times do |i|
      d = Documents::Mail.new
      d.title = Faker::Lorem.words(4)
      d.body = Populator.sentences(30..50)
      d.confidential = false
      d.executor = User.find(rand(1..users_count))
      d.approver = User.find(rand(1..users_count))
      d.recipient_organization = Organization.find(rand(1..organizations_count))
      d.sender_organization    = Organization.find(rand(1..organizations_count))
      d.save!
    end
    puts 'Mail created'

    Documents::Order.delete_all
    Documents::Order.reset_pk_sequence

    5.times do |i|
      d = Documents::Order.new
      d.title = Faker::Lorem.words(3)
      d.body = Populator.sentences(30..50)
      d.confidential = false
      d.executor = User.find(rand(1..users_count))
      d.approver = User.find(rand(1..users_count))
      d.recipient_organization = Organization.find(rand(1..organizations_count))
      d.sender_organization    = Organization.find(rand(1..organizations_count))

      d.deadline = DateTime.now + rand(1..6).months

      d.save!
    end
    puts 'Orders created'


    Documents::Report.delete_all
    Documents::Report.reset_pk_sequence

    2.times do |d|
      d = Documents::Report.new

      d.title = Faker::Lorem.words(2)
      d.body = Populator.sentences(30..50)
      d.confidential = false
      d.executor = User.find(rand(1..users_count))
      d.approver = User.find(rand(1..users_count))
      d.recipient_organization = Organization.find(rand(1..organizations_count))
      d.sender_organization    = Organization.find(rand(1..organizations_count))

      d.order = Documents::Order.find(rand(1..Documents::Order.count))

      d.save!
    end
    puts 'Reports created'
  end
end

# namespace :users do
#   task :create => :environment do
#     User.destroy_all
#     User.populate 15 do |user|
#       user.username = Faker::Internet.user_name
#       user.first_name = Faker::Name.first_name
#       user.last_name = Faker::Name.last_name
#       user.middle_name = Faker::Name.last_name
#       user.phone = '88123361' + rand(100..999).to_s
#       user.position = Faker::Lorem.words(1)
#       user.division = Faker::Lorem.words(1)
#       user.info = Populator.sentences(1..3)
#       user.dob = rand(20.years).ago
#       user.permit = rand(768..999)
#       user.work_status = ['at_work', 'ooo'].sample
#       user.organization_id = Organization.all.sample
#       user.email = Faker::Internet.free_email
#       user.encrypted_password = User.new(:password => "password").encrypted_password
#     end
#     User.all.each { |user| user.avatar = File.open(Dir.glob(File.join(Rails.root, 'avatars', '*')).sample); user.save! }
#     puts "Users create!"
#   end
# end


# namespace :users do
#   task :create_admin => :environment do
#     if User.exists?(:username => 'admin')
#       puts "Admin user already exists"
#     else
#       User.create!(:username => 'admin', :first_name => 'admin', :last_name => 'admin', :middle_name => 'admin', :password => 'admin', :password_confirmation => 'admin')
#       user = User.find_by_username('admin')
#       user.sys_user = true
#       permissions = Permission.all
#       user.permissions << permissions
#       user.save!
#       puts "Admin user created"
#     end
#   end
# end

