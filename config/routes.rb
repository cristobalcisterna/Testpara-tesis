Rails.application.routes.draw do
  resources :financial_sources do
    collection{get '/shownullfinancial_source' => 'financial_sources#show_null_financial_source'}
    collection{get '/showactivefinancial_source' => 'financial_sources#show_active_financial_source'}
  end

  resources :investment_types do
    collection{get '/shownullinvestment_type' => 'investment_types#show_null_investment_type'}
    collection{get '/showactiveinvestment_type' => 'investment_types#show_active_investment_type'}
  end

  resources :condition_goods do
    collection{get '/showrequest' => 'condition_goods#show_request'}
    collection{get '/showexcluded' => 'condition_goods#show_excluded'}
    collection{get '/showlost' => 'condition_goods#show_lost'}
    collection{get '/showdestroyed' => 'condition_goods#show_destroyed'}
    collection{get '/showconditionnull' => 'condition_goods#showcondition_null'}
    collection{get '/showconditionactive' => 'condition_goods#showcondition_active'}
  end
  resources :conditions
  resources :finances
  resources :users do
    collection{post '/newuser' => 'users#asignar_cargo'}
  end
  resources :internal_positions

  resources :units do
    collection{get '/shownullunit' => 'units#show_null_unit'}
    collection{get '/showactiveunit' => 'units#show_active_unit'}
  end

  resources :duty_managers do
    collection{get '/showdutymanagerunit/:id' => 'duty_managers#show_dutymanager_unit'}
    collection{get '/shownulldutymanager' => 'duty_managers#show_null_duty_manager'}
    collection{get '/showactivedutymanager' => 'duty_managers#show_active_duty_manager'}
    collection{get '/mygoods', to: 'duty_managers#get_my_goods'}
    collection{get '/myoffices', to: 'duty_managers#get_my_offices'}
    collection{get '/mybuildings', to: 'duty_managers#get_my_mybuildings'}
    collection{get '/currentuser', to: 'duty_managers#get_current_user'}

    

  end
  resources :buildings do
    collection{get '/showbuildingunit/:id' => 'buildings#show_building_unit'}
    collection{get '/shownullbuilding' => 'buildings#show_null_building'}
    collection{get '/showactivebuilding' => 'buildings#show_active_building'}
    collection{get '/showbuildingdutymanager/:id' => 'buildings#show_building_duty_manager'}
    collection{get '/showbuildinguser/:id' => 'buildings#show_building_user'}
    collection{get '/mybuilding/:id' => 'buildings#show_my_building'}
    
  end
  resources :offices do
    collection{get '/showofficebuilding/:id' => 'offices#show_office_building'}
    collection{get '/showofficeunit/:id' => 'offices#show_office_unit'}
    collection{get '/shownulloffice' => 'offices#show_null_office'}
    collection{get '/showactiveoffice' => 'offices#show_active_office'}
    collection{get '/showofficedutymanager/:id' => 'offices#show_office_duty_manager'}
    collection{get '/showofficeuser/:id' => 'offices#show_office_user'}
    collection{get '/myoffice/:id' => 'offices#show_my_office'}
  end
  resources :goods do 
   collection{get '/shownull' => 'goods#show_null'}
   collection{get '/showactive' => 'goods#show_active'}
   collection{get '/showgoodutymanager/:id' => 'goods#show_good_dutymanager'}
   collection{get '/showgoodoffice/:id' => 'goods#show_good_office'}
   collection{get '/showgoodbuilding/:id' => 'goods#show_good_building'}
   collection{get '/showgoodunit/:id' => 'goods#show_good_unit'}
   collection{get '/showgoodpending' => 'goods#show_good_pending'}
   collection{get '/showgooddecommissioned/:id' => 'goods#show_good_decommissioned'}
   collection{get '/showgooduser/:id' => 'goods#show_good_user'}
   collection{get '/mygood/:id' => 'goods#show_my_good'}
  end
  
  #NO DESCOMENTAR, MANEJO INTERNO
  #resources :internal_positions
  #resources :permissions
  root 'welcome#index'
  devise_for :users, skip: [:sessions,:registrations], controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    delete '/users/sign_out' => 'devise/sessions#destroy'
  end

  #RUTAS PARA VER ENTIDADES A CARGO DE DUTYMANAGER
  
  #  devise_scope :user do
  #    get 'sign_in', to: 'users/sessions#new', as: :new_session
  #    get 'sign_out', to: 'users/sessions#destroy', as: :destroy_session
  #  end
  #
  # RUTAS DE RESPUESTAS PREDEFINIDAS
  get '/403', to: "errors#authorization_required"
  post '/users/:id/change-profile', to:"profiles#change_user_profile"


 
  #get 'app/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
