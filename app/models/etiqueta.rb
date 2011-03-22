class Etiqueta < ActiveRecord::Base
  belongs_to :cor
  belongs_to :tamanho
  belongs_to :produto

end
