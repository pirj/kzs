module Documents::AccountableHelper
  def button_with_content(content, options)
    content_tag(:button, content, options )
  end

  def submit_accountable(state)
    button_with_content(t("helpers.submit.documents.to.#{state}"), name: "transition_to", value: state, class: "btn btn-primary")
  end
end