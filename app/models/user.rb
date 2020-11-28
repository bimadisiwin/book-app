# frozen_string_literal: true

class User < ApplicationRecord
  has_one_attached :avatar
  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follow
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy, inverse_of: :user
  has_many :followers, through: :passive_relationships, source: :user
  has_many :reports, dependent: :destroy
  has_many :comments, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[github]

  def self.create_unique_string
    SecureRandom.uuid
  end

  def self.find_for_github_oauth(auth, _signed_in_resource = nil)
    user = User.find_by(provider: auth.provider, uid: auth.uid)

    user ||= User.new(provider: auth.provider,
                      uid: auth.uid,
                      email: User.dummy_email(auth),
                      password: Devise.friendly_token[0, 20])
    user.save
    user
  end

  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end

  def following?(other_user)
    followings.include?(other_user)
  end

  def follow(other_user)
    relationships.find_or_create_by(follow_id: other_user.id) unless self == other_user
  end

  def unfollow(other_user)
    relationship = relationships.find_by(follow_id: other_user.id)
    relationship&.destroy
  end
end
