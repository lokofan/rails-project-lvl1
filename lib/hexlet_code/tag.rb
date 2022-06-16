# frozen_string_literal: true

module HexletCode
  module Tag
    SINGLE_TAGS = %w[br img input].freeze
    PAIRED_TAGS = %w[label div p form textarea].freeze
    MULTILINE_TAGS = %w[form].freeze

    class << self
      def build(tag_name, attributes = {}, &block)
        return single_tag(tag_name, attributes) if SINGLE_TAGS.include?(tag_name)
        return paired_tag(tag_name, attributes, &block) if PAIRED_TAGS.include?(tag_name)

        raise NotImplementedError, "Tag '#{tag_name}' not implemented."
      end

      def single_tag(tag_name, attributes)
        opening_tag(tag_name, attributes)
      end

      def paired_tag(tag_name, attributes, &block)
        opening = opening_tag(tag_name, attributes)
        inner = body(&block)
        closing = closing_tag(tag_name)
        return opening + inner + closing unless MULTILINE_TAGS.include?(tag_name)

        inner_separator = inner.empty? ? '' : "\n"
        "#{opening}\n#{inner}#{inner_separator}#{closing}"
      end

      def opening_tag(tag_name, attributes = {})
        return "<#{tag_name}>" if attributes.empty?

        attributes_str = attributes.map { |attr, value| "#{attr}=\"#{value}\"" }.join(' ')
        "<#{tag_name} #{attributes_str}>"
      end

      def body(&block)
        block&.call.to_s
      end

      def closing_tag(tag_name)
        "</#{tag_name}>"
      end
    end
  end
end
