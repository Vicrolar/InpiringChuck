Rails.application.routes.draw do

  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    root "chuck#index"
    get '/search' => 'chuck#search'
  end
  
end
