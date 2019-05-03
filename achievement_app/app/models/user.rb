# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
    # FIGVAPER
    # find by credentials
    # is_password?
    # generate session token
    # validate
    # attr reader & after_initialize
    # password=
    # ensure session token
    # reset session token

    validates :username, :password_digest, :session_token, presence: true
    validates :password, length: { minimum: 7, allow_nil: true }
    validates :username, :session_token, uniqueness: true 

    attr_reader :password 

    after_initialize :ensure_session_token


    def self.find_by_credentials(user_name, password)
        user = User.find_by(username: user_name)

        if user && user.is_password?(password)
            user
        else
            nil
        end
    end

    def is_password?(password)
        b_password = BCrypt::Password.new(self.password_digest)
        b_password.is_password?(password)
    end

    def generate_session_token
        SecureRandom.urlsafe_base64
    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def ensure_session_token
        self.session_token ||= self.generate_session_token
    end
    
    def reset_session_token!
        self.session_token = self.generate_session_token
        self.save!
        self.session_token
    end
end
