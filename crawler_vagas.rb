class CrawlerVagas
    def initialize(query)
        query = adjust_query_vagas(query)
        @html = open("https://www.vagas.com.br/" + URI.escape(query))
    end

    def call
        parsed_page = Nokogiri::HTML(@html)
        jobs = Array.new

        #Auxiliar lists
        jobs_temp01 = Array.new
        jobs_temp02 = Array.new

        #---------------------------------------------------------------------
        #Parse to get title, company and url
        job_listings = parsed_page.css('div.informacoes-header')
        #Loop in informacoes-header info
        job_listings.each do |job_listing|
            job = {
                title: job_listing.css('a')[0].text,
                company: job_listing.css('span.emprVaga').text,
                url:  "https://www.vagas.com.br" + job_listing.css('a')[0].attributes["href"].value
            }
            job[:title] = job.values[0].gsub("\n", ' ').squeeze(' ').strip()
            job[:company] = job.values[1].gsub("\n", ' ').squeeze(' ').strip()
            jobs << job
        end   

        #---------------------------------------------------------------------
        #Parse to get location and published_at
        job_listings = parsed_page.css('footer')
    
        #Loop in footer info
        job_listings.each do |job_listing|
            job = {
                location: job_listing.css('span.vaga-local').text,
                published_at: job_listing.css('span.data-publicacao').text,
            }
            job[:location] = job.values[0].gsub("\n", ' ').squeeze(' ').strip()
            job[:published_at] = job.values[1]
            jobs_temp01 << job
        end  

        #---------------------------------------------------------------------
        #Parse to get description
        job_listings = parsed_page.css('div.detalhes')
        #loop in div.detalhes info
        job_listings.each do |job_listing|
            job = {
                description: job_listing.css('p').text,
            }
            job[:description] = job.values[0].gsub("\n", ' ').squeeze(' ').strip()
            jobs_temp02 << job
        end  
        
        #remove the last element that is empty in jobs_temp01
        jobs_temp01.pop

        #Make a merge of jobs_temp01, jobs_temp02 and jobs
        jobs.each_with_index do |job, idx|
            job.merge!(jobs_temp01[idx])
            job.merge!(jobs_temp02[idx])
        end
        return jobs
        # @jobs.each do |job|
        #   #  job.save
    end 

    def adjust_query_vagas(query)
        query = query.split
        query.unshift("de-")
        query.unshift("vagas-")
        (2..query.length - 2).each do |i| 
            query[i] = query[i] + "-" 
        end
        query.push("?")
        return query.join("")
    end
end