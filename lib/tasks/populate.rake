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
        sys_user: row[9],
        email: row[10]
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
    puts '______________________________'
    puts 'Beginning of the creation of test documents. Please wait for several minutes.'
    puts ' '
    # запись немного странная, потому что метод destroy является приватным в модели Document.
    Document.all.each{|d| d.send(:destroy)}
    Document.reset_pk_sequence
    puts 'Documents destroyed'

    DocumentTransition.destroy_all
    DocumentTransition.reset_pk_sequence
    puts 'Transition destroyed'

    Documents::OfficialMail.destroy_all
    Documents::OfficialMail.reset_pk_sequence
    puts 'Mails destroyed'

    Documents::Order.destroy_all
    Documents::Order.reset_pk_sequence
    puts 'Orders destroyed'



    [:mail, :order].each do |type|
      puts "Creating #{type}s started"
      20.times do |i|
        sender = Organization.find(Organization.pluck(:id).sample)
        document = FactoryGirl.build(:document,
                                     sender_organization: sender,
                                     recipient_organization: Organization.find(Organization.pluck(:id).sample),
                                     approver: sender.users.shuffle.first || FactoryGirl.create(:user, organization: sender),
                                     executor: sender.users.shuffle.first || FactoryGirl.create(:user, organization: sender),
                                     creator: sender.users.shuffle.first  || FactoryGirl.create(:user, organization: sender)
        )
        accountable = FactoryGirl.create(type.to_sym, document: document)
        accountable.transition_to! :draft
        accountable.transition_to! :prepared
        accountable.transition_to! :approved
        print '.'
      end

      20.times do |i|
        sender = Organization.find(Organization.pluck(:id).sample)
        document = FactoryGirl.build(:document,
                                     sender_organization: sender,
                                     recipient_organization: Organization.find(Organization.pluck(:id).sample),
                                     approver: sender.users.shuffle.first || FactoryGirl.create(:user, organization: sender),
                                     executor: sender.users.shuffle.first || FactoryGirl.create(:user, organization: sender),
                                     creator: sender.users.shuffle.first  || FactoryGirl.create(:user, organization: sender)
        )
        accountable = FactoryGirl.create(type.to_sym, document: document)
        accountable.transition_to! :draft
        accountable.transition_to! :prepared
        print '.'
      end

      5.times do |i|
        sender = Organization.find(Organization.pluck(:id).sample)
        document = FactoryGirl.build(:document,
                                     sender_organization: sender,
                                     recipient_organization: Organization.find(Organization.pluck(:id).sample),
                                     approver: sender.users.shuffle.first || FactoryGirl.create(:user, organization: sender),
                                     executor: sender.users.shuffle.first || FactoryGirl.create(:user, organization: sender),
                                     creator: sender.users.shuffle.first  || FactoryGirl.create(:user, organization: sender)
        )
        accountable = FactoryGirl.create(type.to_sym, document: document)
        accountable.transition_to! :draft
        print '.'
      end
      puts ' --> done'
    end



    Documents::Report.delete_all
    Documents::Report.reset_pk_sequence
    puts 'reports destroyed'
    puts 'Creating reports started'
    10.times do |d|
      sender = Organization.all.shuffle.first
      order = Documents::Order.approved.shuffle.first || FactoryGirl.create(:approved_order)

      document = FactoryGirl.build(:document,
                                   sender_organization: sender,
                                   recipient_organization: order.sender_organization,
                                   approver: sender.users.shuffle.first || FactoryGirl.create(:user, organization: sender),
                                   executor: sender.users.shuffle.first || FactoryGirl.create(:user, organization: sender),
                                   creator: sender.users.shuffle.first  || FactoryGirl.create(:user, organization: sender)
      )
      accountable = FactoryGirl.create(:report, document: document, order: order)

      accountable.transition_to!(:draft)
      accountable.transition_to!(:prepared)

      print '.'
    end
    puts ' --> done'
    puts ' '
    puts 'All test documents was created'
    puts '______________________________'
  end
end

namespace :initial_data do
  task :crete_admin => :environment do
    
    organization = Organization.find_or_create_by_title('Администрация САКЭ')
    
    if User.exists?(:username => 'admin')
      puts "Admin user already exists"
    else
      User.create!(:first_name => 'Администратор', :last_name => 'Администратор', :organization_id => organization.id, :middle_name => 'Администратор', :password => 'admin', :password_confirmation => 'admin', :sys_user => true, :username => 'admin', :position => 'Администратор')
      puts "Admin user created"
    end
      

    
  end
end


