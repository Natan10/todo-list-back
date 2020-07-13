class Task < ActiveRecord::Base

  belongs_to :user

  #enum
  enum priority: [:urgente,:moderado,:relaxado]

  
end
