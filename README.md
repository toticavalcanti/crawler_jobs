# Crawler Jobs Scraping

This project is a example of how scraping empregos.com.br and vagas.com.br websites.

## Getting Started

1 - Clone this project to your machine with:<br />
git clone git@github.com:toticavalcanti/crawler_jobs.git

2 - Enter in the crawler_jobs folder with:<br />
cd crawler_jobs

3 - Run bundle install with:<br />	
docker-compose run app bundle install

4- Run docker-compose build:<br />
docker-compose build

5 - Run irb to interact with the Crawler Jobs Scraping (the irb -I . it's for irb to be able to import the files in the same folder)
<br />
docker-compose run --rm app bundle exec irb -I .

6 - Imports files and libraries inside of irb prompt:
<br />
require 'open-uri'<br />
require 'nokogiri'<br />
require 'crawler_empregos'<br />
require 'crawler_vagas'<br />

7 - Some comands to interact with the scraping:
<br />
CrawlerEmpregos.new('programador ruby').call<br />
CrawlerEmpregos.new('desenvolvedor python').call<br />
CrawlerVagas.new('programador C#').call<br />
CrawlerVagas.new('programador Java').call<br />

...


### Prerequisites

As we use docker, there will be no dependencies, every thing we need is intall inside the docker container. See the Dockerfile and docker-compose.yml to see detail.

## Authors

* **Toti Cavalcanti** - *Initial work* - http://codigofluente.com.br

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Crawler techniques
* Inspiration
* etc


