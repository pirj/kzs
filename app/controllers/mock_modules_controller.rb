class MockModulesController < ApplicationController
  layout 'base'
  %w(drive guard dispatcher storehouse maintenance maneuvers settings education administration im objects profile important_traffic news).each do |name|
    define_method name do
    end
  end


end
