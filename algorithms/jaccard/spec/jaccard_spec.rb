require './jaccard'

RSpec.describe Jaccard do
  describe 'jaccard similarity coefficient' do
    it 'expects to return correct similarity for apple-applet' do
      expect(Jaccard::Words.coefficient('apple', 'applet')).to eq(0.8)
    end
  end

  describe 'jaccard distance (dissimilarity)' do
    it 'expects to return correct distance for apple-applet' do
      expect(Jaccard::Words.distance('apple', 'applet')).to eq(0.2)
    end
  end
end
