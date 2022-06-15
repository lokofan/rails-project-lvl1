# frozen_string_literal: true

module HexletCode
  class FormBuilder
    INDENT_SYMBOL = ' '
    INDENT_SIZE = 2

    attr_reader :object, :url

    def initialize(object, url)
      @object = object
      @url = url
      @indents = []
    end

    def build_form
      tag('form', action: url, method: 'post') do
        with_indent do
          yield(self) if block_given?
        end
      end
    end

    def input(name, with_label: true, **attrs)
      as_text = attrs.delete(:as) == :text # fix linter =( "Method parameter must be at least 3 characters long."
      return textarea(name, with_label: with_label, **attrs) if as_text

      label(name) if with_label

      input_attrs = { name: name, type: 'text', value: nil }.merge(attrs)
      input_attrs[:value] = object_value(name) unless attrs.key?(:value)
      input_attrs.delete(:value) if input_attrs[:value].nil?

      @indents.last << tag('input', input_attrs)
    end

    def textarea(name, with_label: true, **attrs)
      label(name) if with_label

      textarea_attrs = { cols: 20, rows: 40, name: name }.merge(attrs)
      value = attrs.key(:value) ? textarea_attrs.delete(:value) : object_value(name)

      @indents.last << tag('textarea', textarea_attrs) { value }
    end

    def label(name, **attrs)
      label_attrs = { for: name }.merge(attrs)
      @indents.last << tag('label', label_attrs) { name.capitalize }
    end

    def submit(value = 'Save', **attrs)
      submit_attrs = { type: 'submit', value: value }.merge(attrs)
      input(:commit, with_label: false, **submit_attrs)
    end

    private

    def tag(name, attributes = {})
      HexletCode::Tag.build(name, attributes) do
        yield if block_given?
      end
    end

    def object_value(name)
      object.public_send(name)
    end

    def with_indent
      @indents << []
      indent = INDENT_SYMBOL * INDENT_SIZE * @indents.count

      yield if block_given?

      rows = @indents.pop
      rows.map! { |row| "#{indent}#{row}" }
      rows.join("\n")
    end
  end
end
