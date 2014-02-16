class CarRegion < ActiveRecord::Base
  attr_accessible :number, :name

  validates :number, :name, presence: true

  def self.numbers
    all.map(&:number)
  end
end
