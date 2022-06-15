# frozen_string_literal: true

module HexletCode
  module Form
    def form_for(object, url: '#')
      form_builder = HexletCode::FormBuilder.new(object, url)
      form_builder.build_form do |f|
        yield(f) if block_given?
      end
    end
  end
end
