require 'test_helper'

class CnabTest < ActiveSupport::TestCase

  test 'should parse the line correctly' do
    line = '3201903010000014200096206760174753****3153153453JOÃO MACEDO   BAR DO JOÃO       '
    parser = Parser::Cnab.new
    data = parser.parse_line(line)
    assert data[:value].instance_of? Float
    assert data[:date].instance_of? DateTime
    assert data[:cpf].length == 11
    assert data[:card].length == 12
  end

  test 'should parse the whole file' do
    parser = Parser::Cnab.new
    data = parser.parse_file(Rails.root.join('test', 'lib', 'parser', 'CNAB.txt'))
    assert data.length == 21
  end
end
