# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  password_digest :string(255)
#

class User < ActiveRecord::Base

  has_many :microposts, dependent: :destroy

  attr_accessible :name, :email, :password, :password_confirmation
  has_secure_password
  before_create :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }

  valid_email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    format: { with: valid_email_regex },
                    uniqueness: { case_sensitive: false }

  validates :password, presence: true
  validates :password_confirmation, presence: true


  def feed
    # This is preliminary. See Chapter 12 for the full implementation.
    Micropost.where("user_id = ?", id)
  end


  private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end

end
