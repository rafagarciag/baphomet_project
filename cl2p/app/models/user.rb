class User < ActiveRecord::Base

  ################# DEVISE BLOCK #################
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable
  ################################################


  ################# ATTRIBUTES BLOCK #################
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, #Obligatory and Devise Fields
		:age, :gender, :country, :whyUse #Optional Fields
  ####################################################


  ################# RELATIONSHIPS BLOCK #################
  has_many :pastebins
  #######################################################


  ################# VALIDATIONS BLOCK #################
  validates_presence_of :username, :message => " is missing. Please add one."
  #####################################################

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"]
      end
    end
  end

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
  	data = access_token.extra.raw_info
  	if user = User.where(:email => data.email).first
    		user
  	else # Create a user with a stub password. 
    		User.create!(:username => data.name, :email => data.email, :password => Devise.friendly_token[0,20]) 
  	end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"]
      end
    end
  end

end
