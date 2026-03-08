Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      # Auth
      post "auth/register", to: "auth#register"
      post "auth/login",    to: "auth#login"
      get  "auth/me",       to: "auth#me"

      # Courses & Lessons
      resources :courses, only: [:index, :show] do
        resources :lessons, only: [:show], shallow: true do
          member do
            post :complete
          end
        end
      end

      # Quizzes
      resources :quizzes, only: [:show] do
        member do
          post :answer
        end
      end

      # User progress
      namespace :user do
        get "progress",                    to: "progress#index"
        get "progress/courses/:course_id", to: "progress#course"
      end
    end
  end
end
