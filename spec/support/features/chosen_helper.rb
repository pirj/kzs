module Features
  module ChosenHelper
    def select_from_chosen(label)
      field_id = find_field(label, visible: false)[:id]
      find("##{field_id}_chosen").click
      sleep 1
      within "##{field_id}_chosen" do
        find('.chosen-results li:first-child').click
        sleep 1
        execute_script(%Q!$("##{field_id}").trigger('chosen:update')!)
      end
    end

    #def select_from_chosen_with_checkbox(label)
    #  field_id = find_field(label, visible: false)[:id]
    #  find("##{field_id}_chosen").click
    #  find("##{field_id}_chosen").click
    #  sleep 1
    #  within "##{field_id}_chosen" do
    #    find('.chosen-results li:first-child').click
    #    sleep 1
    #    execute_script(%Q!$("##{field_id}").trigger('chosen:update')!)
    #  end
    #end

    def select_from_multiple_chosen(label)
      field_id = find_field(label, visible: false)[:id]
      chosen = find("##{field_id}_chosen")
      chosen.click
      sleep 1
      within "##{field_id}_chosen" do
        find('.chosen-results li:first-child').click
        chosen.click
        find('.chosen-results li:last-child').click
        sleep 1
        execute_script(%Q!$("##{field_id}").trigger('chosen:update')!)
      end
    end
  end
end