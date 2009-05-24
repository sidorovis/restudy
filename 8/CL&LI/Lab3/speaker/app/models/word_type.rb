class WordType < ActiveRecord::Base
  has_many :word_groups
  has_many :words, :through => :word_groups
end
