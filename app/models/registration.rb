class Registration < ApplicationRecord
  STATUS = ["pending", "confirmed"]
  validates_presence_of :status, :ticket_id
  validates_inclusion_of :status, :in => STATUS

  belongs_to :event
  belongs_to :user, :optional => true
  belongs_to :ticket

  before_create :generate_uuid

  def to_param
    self.uuid
  end

  protected
    def generate_uuid
      self.uuid = SecureRandom.uuid
    end
end
