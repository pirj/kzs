# coding: utf-8
require 'csv'
require 'faker'
require 'spreadsheet'

# Получает данные листа xls-файла
# Возвращает объект Spreadsheet::Worksheet
def get_xls_spreadsheet file_path, sheet_name
  # Файл не существует?
  raise "Can't find #{file_path}" unless File.exists? file_path

  book = Spreadsheet.open file_path
  sheet = book.worksheet sheet_name

  # Лист не существует?
  raise "Sheet #{sheet} doesn't exists" unless sheet

  return sheet
end

namespace :excel do
  desc "Import organizations"
  task organizations: :environment do
    # Получаем данные
    org_sheet = get_xls_spreadsheet 'db/excel/organizations_users.xls', 'Организации'

    # Удаляем старое    
    Organization.delete_all
    Organization.reset_pk_sequence

    # Создаем объекты
    org_sheet.each_with_index do |row, index|
      next if index == 0
      
      Organization.create({
        id: row[0],
        title: row[1],
        parent_id: row[2],
        director_id: row[3],
        short_title: row[4],
        admin_id: row[5],
        type_of_ownership: row[6]
      })
    end
    puts 'Organizations imported'
  end
end

namespace :excel do
  desc "Import users"
  task users: :environment do
    # Получаем данные
    users_sheet = get_xls_spreadsheet 'db/excel/organizations_users.xls', 'Пользователи'

    # Удаляем старое
    User.destroy_all
    User.reset_pk_sequence

    # Добавляем пользователей
    users_sheet.each_with_index do |row, index|
      next if index == 0

      User.create({
        id: row[0],
        organization_id: row[1],
        position: row[2],
        first_name: row[3],
        middle_name: row[4],
        last_name: row[5],
        username: row[6],
        password: row[7],
        password_confirmation: row[8],
        sys_user: row[9]
      })
    end
    puts "Users imported"

    # Добавляем полномочия
    permissions = Permission.all
    User.all.each do |user|
      user.permissions << permissions
      user.save!
    end
    puts "Permissions addded"
  end
end

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
    Organization.delete_all
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
  desc "Import users"
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
    CarBrandType.create(:title => 'Автобус')

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
  desc "Import car regions"
  task :import_car_regions => :environment do
    CarRegion.destroy_all
    CarRegion.reset_pk_sequence
    csv_file_path = 'db/csv/car_regions.csv'
    CSV.foreach(csv_file_path) do |row|
      CarRegion.create!({
        :number => row[0],
        :name => row[1],
      })
    end
    puts "Car regions imported!"
  end
end


# not uses
# because of drop it table
# namespace :csv do
#   desc "Import user document types"
#   task :import_user_document_types => :environment do
#     UserDocumentType.destroy_all
#     UserDocumentType.reset_pk_sequence
#     csv_file_path = 'db/csv/user_document_types.csv'
#     CSV.foreach(csv_file_path) do |row|
#       row = UserDocumentType.create!({
#         :id => row[0],
#         :title => row[1]
#       })
#       puts "User Document Types created"
#     end
#   end
# end

namespace :documents do
  desc 'Create Mails, Orders and Reports. IMPORTANT: run after creating Users and Organizations.'
  task :create => :environment do
    Document.delete_all
    Document.reset_pk_sequence

    Documents::OfficialMail.delete_all
    Documents::OfficialMail.reset_pk_sequence

    organizations_count = Organization.count
    users_count         = User.count
    
    

    20.times do |i|
      sender_organization = Organization.find(rand(1..organizations_count))
      d = Documents::OfficialMail.new
      d.title = Populator.words(4)
      d.body = Populator.sentences(30..50)
      d.confidential = false
      d.executor = User.find(rand(1..users_count))
      d.approver = User.find(rand(1..users_count))
      d.recipients << Organization.where('id != ?', sender_organization.id).last
      d.recipient_organization = Organization.where('id != ?', sender_organization.id).last #to be deprecated
      d.conformers << sender_organization.users.last
      d.sender_organization    = Organization.find(rand(1..organizations_count))
      d.save!
    end
    puts 'Mail created'

    Documents::Order.delete_all
    Documents::Order.reset_pk_sequence
    TaskList.destroy_all
    TaskList.reset_pk_sequence
    Task.destroy_all
    Task.reset_pk_sequence

    20.times do |i|
      d = Documents::Order.new
      d.title = Populator.words(4)
      d.body = Populator.sentences(30..50)
      d.confidential = false
      d.executor = User.find(rand(1..users_count))
      d.approver = User.find(rand(1..users_count))
      d.recipient_organization = Organization.find(rand(1..organizations_count))
      d.sender_organization    = Organization.find(rand(1..organizations_count))
      task_list = d.build_task_list
      4.times do |t|
        t = Task.new
        t.task_list_id = task_list.id
        t.title = Populator.words(2)
        t.body = Populator.words(10)
        completed = true
        document_id = d.id
        executor_organization_id = d.recipient_organization
        sender_organization_id = d.sender_organization
        deadline = DateTime.now + rand(1..6).months
        t.save!
        task_list.tasks << t
      end
      task_list.save!
      
      d.deadline = DateTime.now + rand(1..6).months

      d.save!
    end
    puts 'Orders created'


    Documents::Report.delete_all
    Documents::Report.reset_pk_sequence

    10.times do |d|
      d = Documents::Report.new
      d.title = Populator.words(4)
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

