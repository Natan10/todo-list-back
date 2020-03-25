class Task < ApplicationRecord

  belongs_to :user

  #enum
  enum priority: [:urgente,:moderado,:relaxado]

  
end
