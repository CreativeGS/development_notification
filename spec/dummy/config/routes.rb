Rails.application.routes.draw do

  mount DevelopmentNotification::Engine => "/development_notification"
end
