class Day
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  field :date, type: Date
  slug :date
  field :summary, type: String
  field :impact, type: Fixnum
  field :extra_info, type: Hash

  index({ date: -1 }, { unique: true })

  validates :date, presence: true, uniqueness: true

  CLASS_MAP = {
    Fixnum => :integer,
    Bignum => :integer,
    Float => :float,
    TrueClass => :boolean,
    FalseClass => :boolean,
    String => :string
  }

  def posts
    Post.where(date: date)
  end

  def extra_info_attributes
    self.extra_info ||= {}
    extra_info.map do |key, value|
      Hashie::Mash.new({
        key_name: key,
        type: CLASS_MAP[value.class],
        value: value
      })
    end
  end

  def extra_info_attributes=(attributes)
    self.extra_info = {} unless self.extra_info.is_a?(Hash)
    attributes.each do |attr|
      attr = attr.with_indifferent_access
      self.extra_info[attr[:key_name].to_s] = typecast(attr[:value], attr[:type])
    end
  end

  def set_defaults(viewer)
    self.extra_info ||= viewer.default_extra_info
    self.date ||= Date.yesterday
    self.impact ||= 0
  end

  private

  def typecast(v, type)
    type = type.try(:to_sym)
    case type
    when nil then v
    when :boolean
      if v.is_a?(String)
        return true if v.in?("true", "1")
        return false if v.in?("false", "0")
        !v.empty?
      else
        !!v
      end
    when :string then v.to_s
    when :integer then v.to_i
    when :float then v.to_f
    end
  end
end
