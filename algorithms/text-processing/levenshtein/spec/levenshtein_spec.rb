require './levenshtein'

RSpec.describe Levenshtein do
  subject { Levenshtein }

  # Data reference:
  # https://en.wikipedia.org/wiki/Levenshtein_distance
  # https://youtu.be/M3MQt9GJPW0

  it 'expects distance between \'gold\' and \'good\' to be 1' do
    expect(subject.new('gold', 'good').distance).to eq(1)
  end

  it 'expects distance between \'gut\' and \'good\' to be 3' do
    expect(subject.new('gut', 'good').distance).to eq(3)
  end

  it 'expects distance between \'sort\' and \'sport\' to be 1' do
    expect(subject.new('sort', 'sport').distance).to eq(1)
  end

  it 'expects distance between \'kitten\' and \'sitting\' to be 3' do
    expect(subject.new('kitten', 'sitting').distance).to eq(3)
  end

  it 'expects distance between \'saturday\' and \'sunday\' to be 3' do
    expect(subject.new('saturday', 'sunday').distance).to eq(3)
  end
end
