require "down"

class DownloadsController < ApplicationController
    before_action :set_arquivo

    def new 
        arq = abrir_arquivo()

        if @arquivo.cripto_tipo == "Linha"          
            linha(arq)
          elsif @arquivo.cripto_tipo == "Cesar"         
            cesar(arq)
          else #Cripto eh AES
            cripto_aes(arq)
          end

        # File.delete("public/uploads/store/#{@listaInfo[3]}") if File.exist?("public/uploads/store/#{@listaInfo[3]}")

        tempfile = Down.download("http://localhost:3000/" + @arq2.image_url, destination: "../../Downloads")
        @arq2.destroy
        
        respond_to do |format|
            format.html { redirect_to arquivos_path, notice: "Arquivo was successfully created." }
            #format.json { render :show, status: :created, location: @arquivo }    
        end
    end


    def set_arquivo
        @arquivo = Arquivo.find(params[:id])
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
        @chave = @arquivo.cripto_chave
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

      end

end