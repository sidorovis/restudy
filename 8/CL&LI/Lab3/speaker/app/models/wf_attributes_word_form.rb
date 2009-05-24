class WfAttributesWordForm < ActiveRecord::Base
  belongs_to :wf_attribute
  belongs_to :word_form
  def self.execute( query )
    connection.execute( query )
  end
end
