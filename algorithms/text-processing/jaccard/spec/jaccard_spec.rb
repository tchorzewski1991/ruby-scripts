require './jaccard'

RSpec.describe Jaccard do
  describe '#coefficient (similarity)' do
    it 'computes result for given values' do
      expect(
        Jaccard::Words.coefficient('apple', 'applet')
      ).to eq(0.8)
    end

    it 'rounds result by custom value' do
      expect(
        '%.2f' % Jaccard::Words.coefficient('ala', 'ola', round: 2)
      ).to eq('0.67')
    end

    it 'rounds result by default value' do
      expect(
        '%.5f' % Jaccard::Words.coefficient('ala', 'ola')
      ).to match('0.66667')
    end
  end

  describe '#distance (dissimilarity)' do
    it 'computes result for given values' do
      expect(Jaccard::Words.distance('apple', 'applet')).to eq(0.2)
    end

    it 'rounds result by custom value' do
      expect(
        '%.2f' % Jaccard::Words.distance('ala', 'ola', round: 2)
      ).to eq('0.33')
    end

    it 'rounds result by default value' do
      expect(
        '%.5f' % Jaccard::Words.distance('ala', 'ola')
      ).to match('0.33333')
    end
  end
end
