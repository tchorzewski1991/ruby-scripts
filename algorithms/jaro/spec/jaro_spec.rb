require './jaro'

RSpec.describe Jaro do
  subject { Jaro }

  let(:with_transposition) do
    { :similarity => 0.94444, :origin => 'MARTHA', :target => 'MARHTA' }
  end

  # Data reference: http://rosettacode.org/wiki/Jaro_distance
  let(:without_transposition) do
    {
      1 => { :similarity => 0.82222, :origin => 'DWAYNE', :target => 'DUANE' },
      2 => { :similarity => 0.73333, :origin => 'CRATE',  :target => 'TRACE' }
    }
  end

  context 'when transposition encountered' do
    it 'returns correct similarity value' do
      similarity = with_transposition[:similarity]
      origin     = with_transposition[:origin]
      target     = with_transposition[:target]

      expect(subject.new(origin, target).distance).to eq(similarity)
    end
  end

  context 'when transposition not occures' do
    it 'returns correct similarity value' do
      similarity = without_transposition[1][:similarity]
      origin     = without_transposition[1][:origin]
      target     = without_transposition[1][:target]

      expect(subject.new(origin, target).distance).to eq(similarity)
    end

    it 'returns correct similarity value' do
      similarity = without_transposition[2][:similarity]
      origin     = without_transposition[2][:origin]
      target     = without_transposition[2][:target]

      expect(subject.new(origin, target).distance).to eq(similarity)
    end
  end
end
