$LOAD_PATH << '.'
require 'app/services/cesar_cripto.rb'

class ArquivosController < ApplicationController
  before_action :set_arquivo, only: %i[ show edit update destroy ]

  # GET /arquivos or /arquivos.json
  def index
    @arquivos = Arquivo.all
  end

  # GET /arquivos/1 or /arquivos/1.json
  def show
  end

  # GET /arquivos/new
  def new
    @arquivo = Arquivo.new
  end

  # GET /arquivos/1/edit
  def edit
  end

  # POST /arquivos or /arquivos.json
  def create
    
    @arquivo = Arquivo.new(arquivo_params)
    user = User.first
    @arquivo.user = user
    @chave = ""

    respond_to do |format|
      if @arquivo.save       
        
        arq = abrir_arquivo()

        if @arquivo.cripto_tipo == "Linha"          
          linha(arq)
        elsif @arquivo.cripto_tipo == "Cesar"         
          cesar(arq)
        else #Cripto eh AES
          cripto_aes(arq)
        end
        
        format.html { redirect_to arquivo_url(@arq2), notice: "Arquivo was successfully created." }
        format.json { render :show, status: :created, location: @arq2 }       
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @arq2.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PATCH/PUT /arquivos/1 or /arquivos/1.json
  def update
    respond_to do |format|
      if @arquivo.update(arquivo_params)
        format.html { redirect_to arquivo_url(@arquivo), notice: "Arquivo was successfully updated." }
        format.json { render :show, status: :ok, location: @arquivo }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @arquivo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /arquivos/1 or /arquivos/1.json
  def destroy
    @arquivo.destroy

    respond_to do |format|
      format.html { redirect_to arquivos_url, notice: "Arquivo was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def abrir_arquivo()
    info = @arquivo.image_data

    @listaInfo = info.split('"')
    
    arq = File.new("public/uploads/store/#{@listaInfo[3]}", "r+")

    arq
  end

  def linha(arquivo)
    cont = 0
    temp_linha = []
    arquivo.each do |a|
      if(cont == 1)
        @chave = a
        temp_linha.append("")
      else
        temp_linha.append(a)
      end
      cont+=1
    end
    escrever_arquivo(temp_linha, arquivo)
  end

  def cesar(arquivo)
    cesar = Cesar.new('', 13)
    @chave = 13.to_s
    tmp = []         
    arquivo.each do |a|
      cesar.text = a
      novaLinha = cesar.cipher
      tmp << novaLinha
    end
    escrever_arquivo(tmp, arquivo)
  end

  def cripto_aes(arq)
    @chave = AES.key          
    tmp = []         
    arq.each do |a|
      novaLinha = AES.encrypt(a, @chave)
      tmp << novaLinha
    end
    
    escrever_arquivo(tmp, arq)
  end

  def escrever_arquivo(tmp, arq)
    arq.close unless arq.closed?

    arqTmp = File.new("public/uploads/store/#{@listaInfo[3]}", "w")

    tmp.each  do |t|
      arqTmp.write(t.force_encoding("UTF-8"))
    end
    arqTmp.close unless arqTmp.closed?
    arqTmpNew = File.new("public/uploads/store/#{@listaInfo[3]}", "r")
    arqTmpNew
    @arq2 = Arquivo.new(image: arqTmpNew, description: @arquivo.description, user_id: 1, cripto_tipo: @arquivo.cripto_tipo, cripto_chave: @chave)
        
    # JSON.parse(@arq2.image_data)["metadata"]["filename"] = @listaInfo[13]
    
    @arq2.save
    @arquivo.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_arquivo
      @arquivo = Arquivo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def arquivo_params
      params.require(:arquivo).permit(:image, :description, :user_id, :cripto_tipo, :cripto_chave)
    end


end
