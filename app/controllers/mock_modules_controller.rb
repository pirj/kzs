class MockModulesController < ApplicationController
  layout 'base'

  %w(drive guard dispatcher storehouse maintenance maneuvers settings education administration).each do |name|
    define_method name do
    end
  end


end
