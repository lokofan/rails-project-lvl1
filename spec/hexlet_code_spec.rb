# frozen_string_literal: true

RSpec.describe HexletCode do
  it 'has a version number' do
    expect(HexletCode::VERSION).not_to be_nil
  end

  it 'has form_for method' do
    expect { described_class.form_for(nil) }.not_to raise_error
  end
end
