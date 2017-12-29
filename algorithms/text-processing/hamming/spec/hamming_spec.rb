require './hamming'

RSpec.describe Hamming do
  context 'when equal lengths' do
    it 'returns correct distance for karolin and kathrin' do
      expect(Hamming.distance('karolin', 'kathrin')).to eq(3)
    end

    it 'returns correct distance for karolin and kerstin' do
      expect(Hamming.distance('karolin', 'kerstin')).to eq(3)
    end
  end

  context 'when not equal length' do
    it 'returns nil' do
      expect(Hamming.distance('not', 'equal')).to eq(nil)
    end
  end
end
