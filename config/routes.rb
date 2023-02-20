Rails.application.routes.draw do
  root :to => redirect('/rps/start')

  resource :rps do
    get :start
    get :throw
  end
end
