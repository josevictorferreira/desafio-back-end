class CnabUploaderController < ApplicationController
  def upload
    begin
      parser = Parser::Cnab.new
      path = file_params()[:file].path
      data = parser.parse_file(path)
      Transaction.create_transactions(data)
      flash[:success] = 'Arquivo CNAB importado com sucesso.'
    rescue
      flash[:error] = 'Erro ao importar arquivo.'
    end
    redirect_to root_path
  end

  private

  def file_params
    params.permit(:file)
  end
end
