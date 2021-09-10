# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  authentication_token   :string(30)
#
class User < ApplicationRecord
  acts_as_token_authenticatable

  devise  :database_authenticatable,
          :registerable,
          :recoverable,
          :rememberable,
          :validatable

  has_many :tasks, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :email, uniqueness: { case_senstivie: false }

  before_save :ensure_authentication_token

  def ensure_authentication_token
    self.authentication_token ||= generate_authentication_token
  end

  private

  def generate_authentication_token
    Devise.friendly_token
  end
end
