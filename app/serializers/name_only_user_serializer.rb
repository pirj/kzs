class NameOnlyUserSerializer < ActiveModel::Serializer
  attributes :first_name_with_last_name, :id
end