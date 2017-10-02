require './jaro'

RSpec.describe Jaro do
  subject { Jaro }

  context 'when transposition encountered' do
    let(:with_transposition) {
      {
        :similarity => 0.94444,
        :source => 'MARTHA',
        :target => 'MARHTA'
      }
    }

    it 'expects to return correct similarity value' do
      _source = with_transposition[:source]
      _target = with_transposition[:target]
      _similarity = with_transposition[:similarity]

      expect(subject.new(_source, _target).distance).to eq(_similarity)
    end
  end

  context 'when transposition not occures' do
    # Data reference: http://rosettacode.org/wiki/Jaro_distance
    let(:without_transposition) {
      {
        :similarity => 0.82222,
        :source => 'DWAYNE',
        :target => 'DUANE'
      }
    }

    it 'expects to return correct similarity value' do
      _source = without_transposition[:source]
      _target = without_transposition[:target]
      _similarity = without_transposition[:similarity]

      expect(subject.new(_source, _target).distance).to eq(_similarity)
    end

    let(:without_transposition) {
      {
        :similarity => 0.73333,
        :source => 'CRATE',
        :target => 'TRACE'
      }
    }

    it 'expects to return correct similarity value' do
      _source = without_transposition[:source]
      _target = without_transposition[:target]
      _similarity = without_transposition[:similarity]

      expect(subject.new(_source, _target).distance).to eq(_similarity)
    end
  end
end
