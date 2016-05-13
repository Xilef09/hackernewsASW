class User < ActiveRecord::Base
        has_many :contributions, dependent: :destroy
    acts_as_voter
   
  def self.from_omniauth(auth)
    find_by(provider: auth['provider'], uid: auth['uid']) || create_user_from_omniauth(auth)
  end
  
  def self.create_user_from_omniauth(auth)
    create(
      provider: auth['provider'],
      uid: auth['uid'],
      name: auth['info']['name'],
      about: auth['info']['description'],
      email: auth['info']['email']
      )
  end
  
  def self.getToken() 
    require "base64"
    token  = Base64.encode64(self.id)
    decodedToken = Base64.decode64(enc)
  end 

   
end
