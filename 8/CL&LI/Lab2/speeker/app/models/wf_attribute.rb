class WfAttribute < ActiveRecord::Base
  has_and_belongs_to_many :word_forms
end
