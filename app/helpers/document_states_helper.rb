# coding: utf-8
module DocumentStatesHelper

  # render result module to views and interact with document states
  def render_document_status_bar doc
    content_tag :div, class: 'js-status-wrap' do
      content_tag( :div, class: '_doc-state'.html_safe ) do
        last_state_date(doc).html_safe +
        status_progress_bar(doc).html_safe +
        states_actions(doc).html_safe
      end.html_safe
    end.gsub('\n', '')
  end



  protected

  def last_state_date doc
    _transitions = doc.document_transitions
    content_tag(:div, class: '_doc-state__header') do
      unless _transitions.empty?
        content_tag(:h6, 'последний статус назначен' )+
        content_tag(:h4, DateFormatter.new(doc.document_transitions.first.created_at, :full_words))
      else
        content_tag :h6, 'изменений не было'
      end
    end
  end

  def status_progress_bar doc
    width = doc.current_state_number.to_i*100/doc.sorted_states.count
    content_tag :div, class: 'progress _doc-state__progress' do
      content_tag :div, '', class: 'progress-bar progress-bar-success', style: "width:#{width}%"
    end.html_safe
  end

  def states_actions doc
    content_tag(:div, class: '_doc-state__actions') do
      doc.applicable_states.map do |state|
        link_to( t("activerecord.attributes.document.states.actions.#{state}" ), batch_documents_documents_path( document_ids: [doc.id], state: state) )
      end.join('').html_safe +
      link_to( 'история статусов', '#' ) +
      link_to( 'отмена', '#', class: 'js-close-status-wrap' )
    end.html_safe
  end

end