Kzs::Application.routes.draw do
  root :to => 'dashboard#index'

  #get "/users/sign_out" => "sessions#destroy"

# TODO BAD
#  match '/library' => 'admin/users#index'
#  match '/library' => 'library#library'
# GOOD
  get 'library' => 'library#library'

  devise_for :users

  # TODO: important! просмотреть защиту аплоадов через этот роут.
  # Пользователи не должны видеть чужих аплоудов.
  # Пользователи должны пройти контроль на права.
  # https://github.com/galetahub/ckeditor#cancan-integration
  mount Ckeditor::Engine => '/ckeditor'

  # a convenient alias
  get '/documents' => 'documents/documents#index', as: :documents
  namespace :documents do
    resources :documents, path:'', only: ['index', 'edit', 'show', 'destroy'] do
      # TODO BAD
      # match '/documents/batch' => 'documents#batch'
      # GOOD
      get 'batch', on: :collection
      post 'search', on: :collection

      get 'history', on: :member
    end

    resources :official_mails, path: 'mails', except: 'index' do
      member do
        get 'reply'
        post 'reply', to: :create_reply
        get 'assign_state'
      end
      resources :conformations, only: [:create]

      # Приложенные документы
      resources :attached_documents, only: [:index, :create, :destroy] do
        post 'confirm', on: :collection
      end
    end

    resources :orders, except: 'index' do
      member do
        get 'assign_state'
        get 'reject'
        post 'reject', to: :create_reject
      end
      resources :conformations, only: [:create]

      # Приложенные документы
      resources :attached_documents, only: [:index, :create, :destroy] do
        post 'confirm', on: :collection
      end
    end

    resources :reports, except: 'index' do
      member do
        get 'assign_state'
      end
      resources :conformations, only: [:create]

      # Приложенные документы
      resources :attached_documents, only: [:index, :create, :destroy] do
        post 'confirm', on: :collection
      end
    end
  end


  # TODO REMOVE
  #get '/documents/action_list'
  #get '/documents/approve'
  #get '/documents/prepare'
  #get '/documents/send_document'


  # TODO BAD
  # use restful routes definition
  # get '/documents/mail/new' => 'documents#mail'
  # get '/documents/order/new' => 'documents#order'

  #resources :documents, path:'old_documents' do
  #  collection do
      # TODO OKISH
      # could be just params on index or search actions
      # get 'sents'
      # get 'drafts'
      # get 'callbacks'
    #end
  #  member do
  #    get 'prepare'
  #    get 'approve'
  #    get 'callback'
  #    get 'archive'
  #    get 'delete'
  #    get 'send_document'
  #    get 'execute'
  #    get 'copy'
  #    get 'to_drafts'
  #    get 'reply'
  #  end
  #end

  # TODO BAD avoid match when possible
  # TODO OKISH does not belongs to routes responsibilities
  # match '/document/executor_phone' => 'documents#executor_phone'

  match '/permits/user' => 'permits#user', as: :new_user_permit
  match '/permits/vehicle' => 'permits#vehicle'
  match '/permits/daily' => 'permits#daily'

  # TODO OKISH do we need so much member actions?
  resources :permits do
    member do
      get 'agree'
      get 'cancel'
      get 'release'
      get 'issue'
      get 'reject'
    end
    collection do
      get 'group_print'
    end
  end

  resources :users, :controller => "users"
  resources :rights
  resources :groups

  resources :organizations do
    # TODO DISCUSS
    # зачем нужен этот экшен? Судя по контроллеру он отдает pdf
    # стоит ли его выносить или можно обойтись экшеном show
    #
    member do
      get 'details'
    end
  end

  resources :projects
  resources :document_attached_files

  #TODO-prikha: move task-related code inside Documents module
  resources :task_lists, only: [:update]

  #match '/save_desktop_configuration' => 'dashboard#save_desktop_configuration', :via => :post
  post '/save_desktop_configuration' => 'dashboard#save_desktop_configuration'

  # TODO BAD
  #match '/dashboard' => 'dashboard#index'
  # TODO GOOD
  get '/dashboard' => 'dashboard#index'

  scope module: 'tasks' do
    namespace :api, defaults: { format: 'json' } do
      resources :tasks
    end
    get 'tasks/gantt' => 'tasks#gantt'
    resources :tasks
  end

  ActiveAdmin.routes(self)

  # # added for redirect to customization error in /errors/error_404
  # unless Rails.application.config.consider_all_requests_local
  #   match '*not_found', to: 'errors#error_404'
  # end

  get 'errors/error_404'

end
