class CrawlerEmpregos
	def initialize(query)
		query = adjust_query_empregos(query)
		@html = open("https://www.empregos.com.br/vagas/" + URI.escape(query))
	end

	def call
		parsed_page = Nokogiri::HTML(@html, nil, Encoding::UTF_8.to_s)
		job_listings = parsed_page.css('div.descricao')
		jobs = Array.new		
		job_listings.each do |job_listing|
		job = {
		       	title: job_listing.css('a')[0].text,
		        company: job_listing.css('span.nome-empresa').text,
		        location: job_listing.css('span.cidade-estado').text,
                published_at: job_listing.css('span.publicado').text,
                description: job_listing.css('p')[0].text,
                url:  job_listing.css('a')[0].attributes["href"].value
		    }

		    #formating the rigth way the job hash before insert in array of hashs jobs

		    #Clean the description text take away unnecessary spaces and \n characters
		    job[:title] = job.values[0].gsub("\n", ' ').squeeze(' ').strip()
		    job[:company] = job.values[1].gsub("\n", ' ').squeeze(' ').strip()
		  	job[:location] = job.values[2].gsub("\n", ' ').squeeze(' ').strip()
		  	job[:description] = job.values[4].gsub("\n", ' ').squeeze(' ').strip()
		  	
			#Strip the words "Leia mais" in the end of the job description 
		  	substr = "Leia mais"

		  	job[:description] = job[:description].gsub(substr, "").strip()

		  	#Doesn't need clean
		  	job[:published_at] = job.values[3]

		  	#Doesn't need clean
		  	job[:url] = job.values[5]

		    jobs << job
		end 
		puts jobs
		# @jobs.each do |job|
        #   #  job.save
	end

	def adjust_query_empregos(query)
		query = query.split
		(0..query.length - 2).each do |i| 
			query[i] = query[i] + "-" 
		end
	   	return query.join(" ")
	end
	
end

#CrawlerEmpregos.new('programador ruby').call
#require 'crawler_empregos'

#cria modelo no bd
#docker-compose run --rm website bundle exec rails g model campaign title:string description:text user:references status:integer

#sudo dpkg-reconfigure locales 
