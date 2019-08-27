module Exportable
  extend ActiveSupport::Concern

  included do
    def cols(excluded_fields = [])
      (fields.keys - excluded_fields).map { |colname| attributes[colname] }
    end
  end

  class_methods do
    def colnames(excluded_fields = [])
      # (fields.keys - excluded_fields).map { |f| name.tableize + '_' + f }
      (fields.keys - excluded_fields).map { |f| human_attribute_name(f) }
    end
  end
end
