class Registro < ActiveRecord::Base
  
  acts_as_br_date :data
  acts_as_br_currency :valor
  
  validates_presence_of :data, :descricao, :valor, :cd
  
  scope :creditos, :conditions => {:cd=>'C'}
  scope :debitos, :conditions => {:cd=>'D'}

  belongs_to :conta
  belongs_to :registravel, :polymorphic => true

end
