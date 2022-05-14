require 'zip'
class Compactacao 

    def initialize(user, zip_name)
        @user = user
        @zip_name = zip_name
    end

    def generate (arquivo)
        # applicants = @position.applicants

        # files = []
        # applicants.each do |applicant|
        #     files << save_files_on_server(applicant)
        # end
        puts(arquivo)
        

        create_temporary_zip_file(arquivo)
    end

    def save_files_on_server(applicant)
        temp_folder = File.join(Rails.root.join('tmp', 'resumes'))
        FileUtils.mkdir_p(temp_folder) unless Dir.exist?(temp_folder)

        filename = "#{applicant.name.parameterize}-#{applicant.resume.filename}"
        filepath = File.join(temp_folder, filename)
        File.open(filepath, 'wb') { |f| f.write(applicant.resume.download) }
        filepath
    end

    def create_temporary_zip_file(filepath)
        temp_file = File.open(Rails.root.join('tmp', @zip_name), 'wb')

        begin
            # zip todos os arquivos
            Zip::OutputStream.open(temp_file) { |zos| }

            Zip::File.open(temp_file, Zip::File::CREATE) do |zip|
                
                    filename = File.basename filepath
                    zip.add(filename, filepath)
                    
                end
        ensure
            temp_file.close
            FileUtils.rm(filepath) 
        end
    end
end