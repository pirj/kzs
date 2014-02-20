# TODO @prikha -> @babrovka
# что это такое? миграция видимо пала смертью храбрых и теперь эта модель делает ничего,
# есть на нее ссылка в app/admin/users.rb но и она похоже уже не актуальна

class UserDocumentType < ActiveRecord::Base
  attr_accessible :title
end
