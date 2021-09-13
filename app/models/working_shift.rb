class WorkingShift < ApplicationRecord
  has_many :working_shift_staffs, dependent: :destroy
  has_many :users, through: :working_shift_staffs
end
