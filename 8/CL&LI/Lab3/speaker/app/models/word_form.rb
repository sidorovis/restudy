class WordForm < ActiveRecord::Base
  belongs_to :word_group
  has_and_belongs_to_many :wf_attributes
end
