Coupons::Application.routes.draw do
  resources :orders do
    get :paid, on: :member
  end


  resources :coupons do
    get :admin_form, on: :collection
  end


  resources :deals do
    resource :orders
    member do
      get :publish
      get :finish_success
      get :finish_fail
    end
  end

  resources :certificate_deals, :controller => "deals", :type => "CertificateDeal"
  resources :fixed_deals, :controller => "deals", :type => "FixedDeal"
  resources :unlimited_deals, :controller => "deals", :type => "UnlimitedDeal"

  root :to => 'deals#index'

end
