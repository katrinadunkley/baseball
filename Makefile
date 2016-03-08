input/baseball.zip:
	mkdir -p input
	curl http://seanlahman.com/files/database/baseballdatabank-master_2016-03-02.zip -o input/baseball.zip

input/baseballdatabank-master/README.txt: input/baseball.zip
	cd input; unzip baseball.zip

working/import.sql: input/baseballdatabank-master/README.txt
	mkdir -p working
	mkdir -p output
	python src/process.py
output/AllstarFull.csv: working/import.sql
output/Appearances.csv: working/import.sql
output/AwardsManagers.csv: working/import.sql
output/AwardsPlayers.csv: working/import.sql
output/AwardsShareManagers.csv: working/import.sql
output/AwardsSharePlayers.csv: working/import.sql
output/Batting.csv: working/import.sql
output/BattingPost.csv: working/import.sql
output/CollegePlaying.csv: working/import.sql
output/Fielding.csv: working/import.sql
output/FieldingOF.csv: working/import.sql
output/FieldingPost.csv: working/import.sql
output/HallOfFame.csv: working/import.sql
output/HomeGames.csv: working/import.sql
output/Managers.csv: working/import.sql
output/ManagersHalf.csv: working/import.sql
output/Master.csv: working/import.sql
output/Parks.csv: working/import.sql
output/Pitching.csv: working/import.sql
output/PitchingPost.csv: working/import.sql
output/Salaries.csv: working/import.sql
output/Schools.csv: working/import.sql
output/SeriesPost.csv: working/import.sql
output/Teams.csv: working/import.sql
output/TeamsFranchises.csv: working/import.sql
output/TeamsHalf.csv: working/import.sql

working/no_header/AllstarFull.csv: output/AllstarFull.csv
	mkdir -p working/no_header
	tail +2 $^ > $@
working/no_header/Appearances.csv: output/Appearances.csv
	mkdir -p working/no_header
	tail +2 $^ > $@
working/no_header/AwardsManagers.csv: output/AwardsManagers.csv
	mkdir -p working/no_header
	tail +2 $^ > $@
working/no_header/AwardsPlayers.csv: output/AwardsPlayers.csv
	mkdir -p working/no_header
	tail +2 $^ > $@
working/no_header/AwardsShareManagers.csv: output/AwardsShareManagers.csv
	mkdir -p working/no_header
	tail +2 $^ > $@
working/no_header/AwardsSharePlayers.csv: output/AwardsSharePlayers.csv
	mkdir -p working/no_header
	tail +2 $^ > $@
working/no_header/Batting.csv: output/Batting.csv
	mkdir -p working/no_header
	tail +2 $^ > $@
working/no_header/BattingPost.csv: output/BattingPost.csv
	mkdir -p working/no_header
	tail +2 $^ > $@
working/no_header/CollegePlaying.csv: output/CollegePlaying.csv
	mkdir -p working/no_header
	tail +2 $^ > $@
working/no_header/Fielding.csv: output/Fielding.csv
	mkdir -p working/no_header
	tail +2 $^ > $@
working/no_header/FieldingOF.csv: output/FieldingOF.csv
	mkdir -p working/no_header
	tail +2 $^ > $@
working/no_header/FieldingPost.csv: output/FieldingPost.csv
	mkdir -p working/no_header
	tail +2 $^ > $@
working/no_header/HallOfFame.csv: output/HallOfFame.csv
	mkdir -p working/no_header
	tail +2 $^ > $@
working/no_header/HomeGames.csv: output/HomeGames.csv
	mkdir -p working/no_header
	tail +2 $^ > $@
working/no_header/Managers.csv: output/Managers.csv
	mkdir -p working/no_header
	tail +2 $^ > $@
working/no_header/ManagersHalf.csv: output/ManagersHalf.csv
	mkdir -p working/no_header
	tail +2 $^ > $@
working/no_header/Master.csv: output/Master.csv
	mkdir -p working/no_header
	tail +2 $^ > $@
working/no_header/Parks.csv: output/Parks.csv
	mkdir -p working/no_header
	tail +2 $^ > $@
working/no_header/Pitching.csv: output/Pitching.csv
	mkdir -p working/no_header
	tail +2 $^ > $@
working/no_header/PitchingPost.csv: output/PitchingPost.csv
	mkdir -p working/no_header
	tail +2 $^ > $@
working/no_header/Salaries.csv: output/Salaries.csv
	mkdir -p working/no_header
	tail +2 $^ > $@
working/no_header/Schools.csv: output/Schools.csv
	mkdir -p working/no_header
	tail +2 $^ > $@
working/no_header/SeriesPost.csv: output/SeriesPost.csv
	mkdir -p working/no_header
	tail +2 $^ > $@
working/no_header/Teams.csv: output/Teams.csv
	mkdir -p working/no_header
	tail +2 $^ > $@
working/no_header/TeamsFranchises.csv: output/TeamsFranchises.csv
	mkdir -p working/no_header
	tail +2 $^ > $@
working/no_header/TeamsHalf.csv: output/TeamsHalf.csv
	mkdir -p working/no_header
	tail +2 $^ > $@

output/database.sqlite: working/no_header/AllstarFull.csv working/no_header/Appearances.csv working/no_header/AwardsManagers.csv working/no_header/AwardsPlayers.csv working/no_header/AwardsShareManagers.csv working/no_header/AwardsSharePlayers.csv working/no_header/Batting.csv working/no_header/BattingPost.csv working/no_header/CollegePlaying.csv working/no_header/Fielding.csv working/no_header/FieldingOF.csv working/no_header/FieldingPost.csv working/no_header/HallOfFame.csv working/no_header/HomeGames.csv working/no_header/Managers.csv working/no_header/ManagersHalf.csv working/no_header/Master.csv working/no_header/Parks.csv working/no_header/Pitching.csv working/no_header/PitchingPost.csv working/no_header/Salaries.csv working/no_header/Schools.csv working/no_header/SeriesPost.csv working/no_header/Teams.csv working/no_header/TeamsFranchises.csv working/no_header/TeamsHalf.csv 
	-rm output/database.sqlite
	sqlite3 -echo $@ < working/import.sql
db: output/database.sqlite

output/readme.txt: input/baseballdatabank-master/README.txt
	mkdir -p output
	python src/readme.py

output/hashes.txt: output/database.sqlite output/readme.txt
	-rm output/hashes.txt
	echo "Current git commit:" >> output/hashes.txt
	git rev-parse HEAD >> output/hashes.txt
	echo "\nCurrent input/ouput md5 hashes:" >> output/hashes.txt
	md5 output/*.txt >> output/hashes.txt
	md5 output/*.csv >> output/hashes.txt
	md5 output/*.sqlite >> output/hashes.txt
	md5 input/baseball.zip >> output/hashes.txt
	md5 input/baseballdatabank-master/*.txt >> output/hashes.txt
	md5 input/baseballdatabank-master/core/* >> output/hashes.txt
hashes: output/hashes.txt

release: output/hashes.txt
	cp -r output baseball
	zip -r -X output/baseball_`date -u +'%Y-%m-%d-%H-%M-%S'` baseball/*
	rm -rf baseball

all: release

clean:
	rm -rf working
	rm -rf output
