require 'test_helper'

class CnabUploaderControllerTest < ActionDispatch::IntegrationTest
  test 'file should be uploaded' do
    test_file = Rails.root.join('test', 'lib', 'parser', 'CNAB.txt')
    file = Rack::Test::UploadedFile.new(test_file, "text/txt")
    post '/cnab_uploader/upload', params: { file: file }
    assert_redirected_to root_path
    assert_equal 'Arquivo CNAB importado com sucesso.', flash[:success]
  end

  test 'file should not be uploaded with wrong content' do
    test_file = Rails.root.join('test', 'lib', 'parser', 'CNAB_with_error.txt')
    file = Rack::Test::UploadedFile.new(test_file, "text/txt")
    post '/cnab_uploader/upload', params: { file: file }
    assert_redirected_to root_path
    assert_equal 'Erro ao importar arquivo.', flash[:error]
  end
end
