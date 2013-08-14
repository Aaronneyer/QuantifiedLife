class Day < ActiveRecord::Base
  serialize :metadata
  validates :date, uniqueness: true, presence: true
  has_many :posts

  CLASS_MAP = {
    Fixnum => :integer,
    Bignum => :integer,
    Float => :float,
    TrueClass => :boolean,
    FalseClass => :boolean,
    String => :string
  }


  def metadata_attributes
    self.metadata ||= {}
    metadata.map do |key, value|
      Hashie::Mash.new({
        key_name: key,
        type: CLASS_MAP[value.class],
        value: value
      })
    end
  end

  def metadata_attributes=(attributes)
    self.metadata = {} unless self.metadata.is_a?(Hash)
    attributes.each do |attr|
      attr = attr.with_indifferent_access
      self.metadata[attr[:key_name].to_s] = typecast(attr[:value], attr[:type])
    end
  end

  def set_defaults
    self.default_metadata
    self.date ||= Date.yesterday
    self.impact ||= 0
  end

  def default_metadata
    self.metadata = {} unless self.metadata.is_a?(Hash)
    f = Rails.root.join('config', 'default_metadata.yml')
    if File.exists? f
      self.metadata.merge!(YAML.load_file(f))
    end
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
