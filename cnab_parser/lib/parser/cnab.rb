require 'date'

module Parser
  class Cnab

    def parse_file(name)
      IO.foreach(name).lazy.map { |n| parse_line(n) }.to_a
    end

    def parse_line(content)

      {
        transaction_type: content[0].to_i,
        value: content[9..18].to_f / 100.00,
        cpf: content[19..29],
        card: content[30..41],
        store_owner: content[48..61].strip,
        store: content[62..80].strip,
        date: DateTime.strptime("#{content[1..8]} #{content[42..47]} UTC-3", "%Y%m%d %H%M%S %z")
      }
    end
  end
end
