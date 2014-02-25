# coding: utf-8
module Tasks
  class ListShowDecorator < Documents::BaseDecorator
    decorates :task
    delegate_all

    def task_body
      m=''
      if object.completed
        m ='m-task-completed'
      end

      h.content_tag(:div, class: 'b-task row ' + m) do
        check + num + title_and_comment + date
      end

    end

    def title_and_comment
      h.content_tag( :div,title+comment, class: 'col-sm-8')
    end

    def num
      h.content_tag( :div,object.id.to_s+'.', class: 'b-task-num col-sm-1')
    end

    def title
      if object.task
        h.content_tag( :div,object.task, class: 'b-task-title ')
      end
    end

    def date
      h.content_tag( :span, DateFormatter.new(object.created_at), class: 'span col-sm-2 b-task-date')
    end

    def comment
      if object.executor_comment
        h.content_tag( :span, object.executor_comment, class: 'b-task-comment')
      else
        ''
      end
    end

    def check
      if object.completed #col-sm-8

        h.content_tag( :div, ("<input type='checkbox'  checked='checked'>").html_safe, class: 'checkbox col-sm-1')
      else
        h.content_tag( :div, ("<input type='checkbox'>").html_safe, class: 'checkbox col-sm-1')
      end
    end
  end
end