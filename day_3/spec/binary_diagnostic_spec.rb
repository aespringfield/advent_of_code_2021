require './day_3/binary_diagnostic.rb'

RSpec.describe 'BinaryDiagnostic' do
  let(:data) { File.readlines('./day_3/spec/data.txt', chomp: true) }

  describe('#find_gamma') do
    it 'gets the gamma bit for one number' do
      expect(BinaryDiagnostic.find_gamma(['00001'])).to eq('00001')
    end

    it 'gets the gamma bit for three numbers' do
      expect(BinaryDiagnostic.find_gamma(['00001', '01011', '01100'])).to eq('01001')
    end

    it 'gets the gamma bit for longer numbers' do
      expect(BinaryDiagnostic.find_gamma(['0000101', '0101100', '0110010'])).to eq('0100100')
    end
  end

  describe('#invert') do
    it 'inverts a binary sequence' do
      expect(BinaryDiagnostic.invert('01001')).to eq('10110')
    end
  end

  describe('#find_gamma_and_epsilon') do
    it 'finds rates for data' do
      expect(BinaryDiagnostic.find_gamma_and_epsilon(data)).to eq(['10110', '01001'])
    end
  end

  describe('#convert_binary_to_decimal') do
    it 'converts to decimal' do
      expect(BinaryDiagnostic.convert_binary_to_decimal('01001')).to be(9)
    end
  end

  describe '#run' do
    it 'does the whole thing' do
      expect(BinaryDiagnostic.run(data: data)).to be(198)
    end

    it 'does another set of data' do
      expect(BinaryDiagnostic.run(data: ['01001', '01101', '00001', '11010'])).to be(198)
    end
  end

  describe '#find_oxygen_generator_rating' do
    it 'finds rating for data' do
      expect(BinaryDiagnostic.find_oxygen_generator_rating(data: data)).to eq('10111')
    end
  end

  describe '#find_co2_scrubber_rating' do
    it 'finds rating for data' do
      expect(BinaryDiagnostic.find_co2_scrubber_rating(data: data)).to eq('01010')
    end
  end
end