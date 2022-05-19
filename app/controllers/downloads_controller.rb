require "down"

class DownloadsController < ApplicationController
    before_action :set_arquivo
    before_action :check_user

    def check_user
      copias = Copium.find_by(user_id: current_user.id, arquivo_id: @arquivo.id)
      if copias.nil?
        respond_to do |format|
          format.html { redirect_to arquivos_path, alert: "You are not authorized to download another users files." }
        end
      end
    end

    def new 
      @filename0 = JSON.parse(@arquivo.image_data)["metadata"]["filename"]
      arq = abrir_arquivo()
      copias = Copium.find_by(user_id: current_user.id, arquivo_id: @arquivo.id)
      if !copias.nil? && current_user.id == copias.user_id
        
          if @arquivo.cripto_tipo == "Remove Line"          
            linha(arq)
          elsif @arquivo.cripto_tipo == "Caesar"         
            cesar(arq)
          elsif @arquivo.cripto_tipo == "AES"
            cripto_aes(arq)
            
          end
      
      else
        @arq2 = Arquivo.new(image: arq, description: @arquivo.description, cripto_tipo: @arquivo.cripto_tipo, cripto_chave: @chave)
        @cached_id = JSON.parse(@arq2.cached_image_data)["id"]
      end

      Dir.mkdir("../../download_teste") unless File.exists?("../../download_teste")

      tempfile = Down.download("http://localhost:3000/" + @arq2.image_url, destination: "../../download_teste")

      @filename2 = JSON.parse(@arq2.image_data)["metadata"]["filename"]
      
      File.delete("public/uploads/cache/#{@cached_id}") if File.exist?("public/uploads/cache/#{@cached_id}")
      if current_user.id == copias.user_id
        File.delete("public/uploads/store/#{@filename2}") if File.exist?("public/uploads/store/#{@filename2}")      
      end
      @arq2.destroy
      
      respond_to do |format|
          format.html { redirect_to arquivos_path, notice: "File was successfully downloaded." }
          #format.json { render :show, status: :created, location: @arquivo }    
      end
    end


    def set_arquivo
        @arquivo = Arquivo.find(params[:id])
    end

    def abrir_arquivo()
        info = @arquivo.image_data
        @listaInfo = info.split('"')
              
        arq = File.new("public/uploads/store/#{@filename0}", "r+")
    
        arq
    end

    def linha(arquivo)
        cont = 0
        temp_linha = []
        arquivo.each do |a|
          if(cont == 2)
            temp_linha << @arquivo.cripto_chave
            temp_linha << a
          else
            temp_linha << a
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
        @chave = @arquivo.cripto_chave          
        tmp = []   
        cont = 0  
        palavra = ""    
        arq.each do |a|
          if (cont == 3)
            for b in 0..48 do
              palavra += a[b].to_s
            end 
            novaLinha = AES.decrypt(palavra.force_encoding("UTF-8"), @chave)
            tmp << novaLinha.force_encoding("UTF-8") + a[49..(a.length)]
          else
            tmp << a
          end

    
          cont = cont + 1
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
        @arq2 = Arquivo.new(image: arqTmpNew, description: @arquivo.description, cripto_tipo: @arquivo.cripto_tipo, cripto_chave: @chave)
                   
        @cached_id = JSON.parse(@arq2.cached_image_data)["id"]
        
        @arq2.save

      end

    end