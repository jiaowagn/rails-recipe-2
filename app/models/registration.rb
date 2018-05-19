class Registration < ApplicationRecord
  STATUS = ["pending", "confirmed"]
  validates_presence_of :status, :ticket_id
  validates_inclusion_of :status, :in => STATUS
  attr_accessor :current_step

  validates_presence_of :name, :email, :cellphone, :if => :should_validate_basic_data?
  validates_presence_of :name, :email, :cellphone, :bio, :if => :should_validate_all_data?

  belongs_to :event
  belongs_to :user, :optional => true
  belongs_to :ticket

  before_create :generate_uuid

  def to_param
    self.uuid
  end

  protected
    def should_validate_basic_data?
      current_step == 2
    end

    def should_validate_all_data?
      current_step == 3 || self.status == "confirmed"
    end

    def generate_uuid
      self.uuid = SecureRandom.uuid
    end
end
