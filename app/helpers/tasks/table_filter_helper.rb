module Tasks::TableFilterHelper

    # набор параметров фильтрации для списка задач
    #
    # имя столбца, где вставить фильтр — должен соответствовать атрибуту элемента коллекции, над которым проводится сортировка
    # data — json данные, для select элементов в фильтрах
    # type — тип фильтра.Скорее всего будет имя, по которому будет происходить подгрузка хелпера с содержимым формы фильтра
    def tasks_table_filter_opts
      {
        title: {
            type: :text,
            input_names: [:title_cont]
        },
        started_at: {
            type: :date,
            input_names: [:started_at, :finished_at]
        },
        executor: {
            type: :select,
            data: current_organization_users.map { |user| {id: user.id, title: user.first_name_with_last_name} },
            input_names: [:executors_id_in]
        },
        inspector: {
            type: :select_multiple,
            data: current_organization_users.map { |user| {id: user.id, title: user.first_name_with_last_name} },
            input_names: [:inspector_id_in]
        },
        state: {
            type: :select_multiple,
            data: [{id: :formulated, title: :formulated}, {id: :actived, title: :actived}],
            input_names: [:state_cont]
        }
      }
    end


end
