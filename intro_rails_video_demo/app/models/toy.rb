class Toy < ActiveRecord::Base
  TYPES = [
    "string",
    "yarnball",
    "mouse"
  ]

  validates :cat, :name, :ttype, presence: true
  validates :ttype, inclusion: TYPES
  #This last line is to validate that the toys all come from the group
  # we created here called TYPES

  belongs_to :cat
end
