class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  include ExtraInfoAttributes

  field :email, type: String, default: ''
  slug :email, history: true
  field :encrypted_password, type: String, default: ''
  field :remember_created_at, type: String
  field :sign_in_count, type: Integer, default: 0
  field :current_sign_in_at, type: DateTime
  field :last_sign_in_at, type: DateTime
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip, type: String

  field :extra_info, type: Hash, default: {}
  field :github_token, type: String
  field :github_private, type: Boolean, default: false
  field :dropbox_token, type: String
  field :dropbox_uid, type: String
  field :admin, type: Boolean
  field :permitted_viewers, type: Array, default: []
  has_many :github_events
  has_many :photos
  has_many :posts
  has_many :days

  index({ email: 1 }, { unique: true })
  index({ reset_password_token: 1 }, { unique: true })

  devise :database_authenticatable, :rememberable, :trackable

  def can_view?(user)
    can_edit?(user) || user.permitted_viewers.include?(self.id)
  end

  def can_edit?(user)
    admin? || user == self
  end
end
