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
   
    #def from_omniauth(auth_hash)
     #   user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
      #  user.provider= auth_hash['info']['provider']
       # user.uid= auth_hash['uid']
    #    user.name= auth_hash['info']['name']
     #   user.about= auth_hash['info']['description']
      #  user.email= auth_hash['info']['email']
       # user.save!
    #    user
    #end
   
end
