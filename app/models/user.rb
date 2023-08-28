class User < ApplicationRecord
  has_secure_password 
  
  validates :first_name, presence: true  
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 5}
  before_save :downcase_email

  def self.authenticate_with_credentials(email, password)
    self.email = email.strip
    self.email = self.email.downcase
    @user = User.find_by_email(@email.downcase)

    if @user.authenticate(password)
      @user
    else
      nil
    end
  end

  private

  def downcase_email
    self.email = email.strip
    self.email = self.email.downcase
  end
end
