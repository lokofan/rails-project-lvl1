# frozen_string_literal: true

RSpec.describe HexletCode::Form do
  before do
    stub_const('User', Struct.new(:name, :job, :gender, keyword_init: true))
  end

  let!(:user) { User.new(name: 'rob', job: 'hexlet', gender: 'm') }
  let!(:user_without_name) { User.new(job: 'hexlet') }

  it 'returns empty form without url' do
    expected = FixtureReader.read('form_without_url.html')
    actual = HexletCode.form_for(user)
    expect(actual).to eq(expected)
  end

  it 'returns empty form with url' do
    expected = FixtureReader.read('form_with_url.html')
    actual = HexletCode.form_for(user, url: '/users')
    expect(actual).to eq(expected)
  end

  it 'returns form with input and textarea' do
    expected = FixtureReader.read('form_with_input_and_textarea.html')
    actual = HexletCode.form_for user do |f|
      f.input :name, with_label: false
      f.input :job, as: :text, with_label: false
    end
    expect(actual).to eq(expected)
  end

  it 'when specifying a non-existent field' do
    expect do
      HexletCode.form_for user, url: '/users' do |f|
        f.input :name, with_label: false
        f.input :job, as: :text, with_label: false
        f.input :age
      end
    end.to raise_error(NoMethodError)
  end

  it 'returns form with label and submit' do
    expected = FixtureReader.read('form_with_label_and_submit.html')
    actual = HexletCode.form_for user_without_name do |f|
      f.input :name
      f.input :job
      f.submit
    end
    expect(actual).to eq(expected)
  end
end
