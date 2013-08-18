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

  index({ email: 1 }, { unique: true })
  index({ reset_password_token: 1 }, { unique: true })

  devise :database_authenticatable, :rememberable, :trackable

  def fetch_events
    if github_token
      gh = Github.new(oauth_token: user.github_token)
      gh_user = gh.users.get
      done = false
      gh.activity.events.performed(gh_user.login).each_page do |page|
        page.each do |event|
          event.merge!(user_id: id)
          if GithubEvent.where(id: event.id).exists?
            done = true
            break
          else
            GithubEvent.create!(ActionController::Parameters.new(event).permit!)
          end
        end
        break if done
      end
    end
  end
end
