class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  field :email, type: String, default: ''
  slug :email, history: true
  field :encrypted_password, type: String, default: ''
  field :remember_created_at, type: String
  field :sign_in_count, type: Integer, default: 0
  field :current_sign_in_at, type: DateTime
  field :last_sign_in_at, type: DateTime
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip, type: String
  field :default_extra_info, type: Hash
  field :github_token, type: String
  field :github_private, type: Boolean, default: false
  field :admin, type: Boolean
  has_many :github_events

  index({ email: 1 }, { unique: true })
  index({ reset_password_token: 1 }, { unique: true })

  devise :database_authenticatable, :rememberable, :trackable
end
