class TransactionType

  def self.data(value)
    [
      {
        description: 'Débito',
        kind: 'Entrada',
        symbol: '+'
      },
      {
        description: 'Boleto',
        kind: 'Saída',
        symbol: '-'
      },
      {
        description: 'Financiamento',
        kind: 'Saída',
        symbol: '-'
      },
      {
        description: 'Crédito',
        kind: 'Entrada',
        symbol: '+'
      },
      {
        description: 'Recebimento Empréstimo',
        kind: 'Entrada',
        symbol: '+'
      },
      {
        description: 'Vendas',
        kind: 'Entrada',
        symbol: '+'
      },
      {
        description: 'Recebimento TED',
        kind: 'Entrada',
        symbol: '+'
      },
      {
        description: 'Recebimento DOC',
        kind: 'Entrada',
        symbol: '+'
      },
      {
        description: 'Aluguel',
        kind: 'Saída',
        symbol: '-'
      }
    ][value - 1]
  end

end
