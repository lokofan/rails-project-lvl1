# frozen_string_literal: true

module FixtureReader
  def self.read(filename)
    current_dir_path = File.expand_path(__dir__)
    fixture_path = File.join(current_dir_path, 'files', filename)
    File.read(fixture_path)
  end
end
