class User < ActiveRecord::Base

  ################# DEVISE BLOCK #################
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
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

end
