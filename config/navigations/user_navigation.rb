# -*- coding: utf-8 -*-
# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|

  navigation.items do |primary|
    primary.dom_class = 'nav _left-menu js-left-menu'
    navigation.active_leaf_class = 'active'
    navigation.consider_item_names_as_safe = true

    primary.item :root, '', nil, class: 'brand_logo'

    
    #primary.item :contoller, 'Дашбоард', users_root_path

    primary.item :dashboard, 'Рабочий стол', users_root_path,
                 icon: 'm-dashboard',
                 module: 'dashboard',
                 name: 'all',
                 notification_text: ''

    primary.item :dispatcher, 'Диспетчер', control_dashboard_path,
                 icon: 'm-dispatcher',
                 notification_color: lambda { left_menu_notification_for :control }

    primary.item :units, 'Объекты', units_path,
                 icon: 'm-units',
                 module: 'units',
                 name: 'all',
                 notification_text: lambda { left_menu_notification_for :units }

    primary.item :messages, 'Сообщения', '#',
                 icon: 'm-messages',
                 module: 'messages',
                 name: 'all',
                 notification_text: lambda { left_menu_notification_for :messages } \
                do |second_level|

      second_level.item :broadcast, 'Циркуляр',
                        messages_broadcast_path,
                        module: 'messages',
                        name: 'broadcast'


      second_level.item :dialogues, 'Все диалоги', dialogues_path,
                        module: 'messages',
                        name: 'all'
    end

    primary.item :permits, 'Пропуска', '#',
                 icon: 'm-permits' \
                do |second_level|

      second_level.item :human, 'Физические лица', scope_permits_path(type: :human),
                        module: 'permits'

      second_level.item :car, 'Транспортные средства', scope_permits_path(type: :car),
                        module: 'permits'

      second_level.item :once, 'Разовые пропуска', scope_permits_path(type: :once),
                        module: 'permits'

    end
    
    
    primary.item :permits, 'Документы', documents_path,
                 icon: 'm-documents',
                 notification_text: proc { left_menu_notification_for :documents }


    primary.item :tasks, 'Задачи', tasks_module_path,
                 icon: 'm-tasks'
                 # notification_text: proc { '-' }

  end
end
