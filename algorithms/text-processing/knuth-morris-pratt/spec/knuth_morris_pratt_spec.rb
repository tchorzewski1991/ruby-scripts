require './knuth_morris_pratt.rb'

RSpec.describe KnuthMorrisPratt do
  subject { KnuthMorrisPratt }

  # Example reference:
  # https://en.wikipedia.org/wiki/Knuth%E2%80%93Morris%E2%80%93Pratt_algorithm
  context 'with beginning of the new match' do
    it 'expects to find target within source string' do
      _source = 'ABC ABCDAB ABCDABCDABDE'
      _target = 'ABCDABD'

      expect(subject.new(_source, _target).compute).to eq('ABCDABD')
    end
  end

  context 'without beginning of the new match' do
    it 'expects to find complete target within source string' do
      _source = 'ABCDAB'
      _target = 'CDA'

      expect(subject.new(_source, _target).compute).to eq('CDA')
    end

    it 'expects to find partial target within source string' do
      _source = 'ABCDAB'
      _target = 'CD'

      expect(subject.new(_source, _target).compute).to eq('CD')
    end
  end
end
