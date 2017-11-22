require './luhn'

RSpec.describe Luhn do
  it 'accepts raw integer' do
    expect(Luhn.valid?(123414)).to eq(true)
  end

  it 'accepts integer with dash delimiter' do
    expect(Luhn.valid?(12_3414)).to eq(true)
  end

  it 'accepts raw string' do
    expect(Luhn.valid?('123414')).to eq(true)
  end

  it 'accepts string with space' do
    expect(Luhn.valid?('12 3414')).to eq(true)
  end

  it 'accepts string with delimiter' do
    expect(Luhn.valid?('12_3414')).to eq(true)
  end

  it 'refutes string with character other then digit' do
    expect(Luhn.valid?('12_3414a')).to eq(false)
  end

  it 'refutes input other then integer or string' do
    expect(Luhn.valid?([])).to eq(false)
  end
end
