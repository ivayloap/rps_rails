Rails.application.routes.draw do
  resource :rps do
    get :start
    get :throw
  end
end
